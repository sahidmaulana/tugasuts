import 'package:flutter/material.dart';

void main() {
  runApp(const CafeDrinksOrderApp());
}

class CafeDrinksOrderApp extends StatelessWidget {
  const CafeDrinksOrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pemesanan Minuman Cafe',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const DrinkMenuScreen(),
    );
  }
}

class DrinkItem {
  final String id;
  final String name;
  final String description;
  final double price;

  DrinkItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });
}

class OrderItem {
  final DrinkItem item;
  int quantity;

  OrderItem({
    required this.item,
    this.quantity = 1,
  });
}

class DrinkMenuScreen extends StatefulWidget {
  const DrinkMenuScreen({super.key});

  @override
  State<DrinkMenuScreen> createState() => _DrinkMenuScreenState();
}

class _DrinkMenuScreenState extends State<DrinkMenuScreen> {
  final List<DrinkItem> _drinkItems = [
    DrinkItem(
      id: 'D01',
      name: 'Espresso',
      description: 'Kopi hitam pekat, kaya rasa.',
      price: 25000.0,
    ),
    DrinkItem(
      id: 'D02',
      name: 'Cappuccino',
      description: 'Espresso dengan susu steamed dan busa tebal.',
      price: 30000.0,
    ),
    DrinkItem(
      id: 'D03',
      name: 'Latte',
      description: 'Espresso dengan susu steamed, lebih banyak susu.',
      price: 30000.0,
    ),
    DrinkItem(
      id: 'D04',
      name: 'Americano',
      description: 'Espresso diencerkan dengan air panas.',
      price: 28000.0,
    ),
    DrinkItem(
      id: 'D05',
      name: 'Matcha Latte',
      description: 'Teh hijau matcha dengan susu.',
      price: 32000.0,
    ),
    DrinkItem(
      id: 'D06',
      name: 'Chocolate Blend',
      description: 'Minuman cokelat creamy dingin.',
      price: 35000.0,
    ),
    DrinkItem(
      id: 'D07',
      name: 'Ice Tea',
      description: 'Teh dingin menyegarkan.',
      price: 18000.0,
    ),
  ];

  final List<OrderItem> _cart = [];

  void _addToCart(DrinkItem item) {
    setState(() {
      final existingItemIndex = _cart.indexWhere((orderItem) => orderItem.item.id == item.id);

      if (existingItemIndex != -1) {
        _cart[existingItemIndex].quantity++;
      } else {
        _cart.add(OrderItem(item: item, quantity: 1));
      }
    });
    _showSnackBar('${item.name} ditambahkan ke keranjang!');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _goToCartScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DrinkCartScreen(cartItems: _cart),
      ),
    ).then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Minuman'),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.local_cafe),
                onPressed: _goToCartScreen,
              ),
              if (_cart.isNotEmpty)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      _cart.fold<int>(0, (sum, item) => sum + item.quantity).toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _drinkItems.length,
        itemBuilder: (context, index) {
          final item = _drinkItems[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rp ${item.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _addToCart(item),
                        child: const Text('Tambah'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DrinkCartScreen extends StatefulWidget {
  final List<OrderItem> cartItems;

  const DrinkCartScreen({super.key, required this.cartItems});

  @override
  State<DrinkCartScreen> createState() => _DrinkCartScreenState();
}

class _DrinkCartScreenState extends State<DrinkCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Minuman'),
        centerTitle: true,
      ),
      body: widget.cartItems.isEmpty
          ? const Center(
        child: Text('Keranjang kosong.'),
      )
          : ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) {
          final orderItem = widget.cartItems[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderItem.item.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Rp ${orderItem.item.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (orderItem.quantity > 1) {
                              orderItem.quantity--;
                            } else {
                              widget.cartItems.removeAt(index);
                            }
                          });
                        },
                      ),
                      Text(orderItem.quantity.toString()),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            orderItem.quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: widget.cartItems.isNotEmpty
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: Rp ${widget.cartItems.fold<double>(0.0, (sum, item) => sum + (item.item.price * item.quantity)).toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _showSnackBar('Fitur checkout belum tersedia.');
              },
              child: const Text('Checkout'),
            ),
          ],
        ),
      )
          : null,
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}