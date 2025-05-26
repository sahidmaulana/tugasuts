
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CafeDrinksOrderApp());
}

class CafeDrinksOrderApp extends StatelessWidget {
  const CafeDrinksOrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cafe Sukma - Pemesanan',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.brown,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
      ),
      home: const MainMenuScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageIcon;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageIcon,
  });
}

class OrderItem {
  final MenuItem item;
  int quantity;

  OrderItem({
    required this.item,
    this.quantity = 1,
  });
}

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<OrderItem> _cart = [];

  final List<MenuItem> _menuItems = [
    // MINUMAN (17 items)
    MenuItem(id: 'D01', name: 'Espresso', description: 'Kopi hitam pekat, kaya rasa', price: 25000.0, category: 'Minuman', imageIcon: '☕'),
    MenuItem(id: 'D02', name: 'Cappuccino', description: 'Espresso dengan susu steamed dan busa tebal', price: 30000.0, category: 'Minuman', imageIcon: '☕'),
    MenuItem(id: 'D03', name: 'Latte', description: 'Espresso dengan susu steamed, lebih banyak susu', price: 30000.0, category: 'Minuman', imageIcon: '☕'),
    MenuItem(id: 'D04', name: 'Americano', description: 'Espresso diencerkan dengan air panas', price: 28000.0, category: 'Minuman', imageIcon: '☕'),
    MenuItem(id: 'D05', name: 'Matcha Latte', description: 'Teh hijau matcha dengan susu', price: 32000.0, category: 'Minuman', imageIcon: '🍵'),
    MenuItem(id: 'D06', name: 'Chocolate Blend', description: 'Minuman cokelat creamy dingin', price: 35000.0, category: 'Minuman', imageIcon: '🍫'),
    MenuItem(id: 'D07', name: 'Ice Tea', description: 'Teh dingin menyegarkan', price: 18000.0, category: 'Minuman', imageIcon: '🧊'),
    MenuItem(id: 'D08', name: 'Mocha', description: 'Perpaduan espresso dan cokelat yang sempurna', price: 33000.0, category: 'Minuman', imageIcon: '☕'),
    MenuItem(id: 'D09', name: 'Caramel Macchiato', description: 'Espresso dengan sirup karamel dan susu', price: 35000.0, category: 'Minuman', imageIcon: '☕'),
    MenuItem(id: 'D10', name: 'Vanilla Latte', description: 'Latte dengan aroma vanilla yang harum', price: 32000.0, category: 'Minuman', imageIcon: '☕'),
    MenuItem(id: 'D11', name: 'Cold Brew', description: 'Kopi dingin diseduh dengan air dingin 12 jam', price: 30000.0, category: 'Minuman', imageIcon: '🧊'),
    MenuItem(id: 'D12', name: 'Affogato', description: 'Es krim vanilla disiram espresso panas', price: 40000.0, category: 'Minuman', imageIcon: '🍦'),
    MenuItem(id: 'D13', name: 'Thai Tea', description: 'Teh Thailand dengan susu kental manis', price: 25000.0, category: 'Minuman', imageIcon: '🧡'),
    MenuItem(id: 'D14', name: 'Green Tea Latte', description: 'Teh hijau dengan susu yang creamy', price: 28000.0, category: 'Minuman', imageIcon: '🍵'),
    MenuItem(id: 'D15', name: 'Strawberry Smoothie', description: 'Smoothie segar dari buah strawberry', price: 30000.0, category: 'Minuman', imageIcon: '🍓'),
    MenuItem(id: 'D16', name: 'Mango Juice', description: 'Jus mangga segar tanpa pemanis buatan', price: 22000.0, category: 'Minuman', imageIcon: '🥭'),
    MenuItem(id: 'D17', name: 'Lemon Tea', description: 'Teh dengan perasan lemon segar', price: 20000.0, category: 'Minuman', imageIcon: '🍋'),

    // MAKANAN (17 items)
    MenuItem(id: 'F01', name: 'Nasi Goreng Spesial', description: 'Nasi goreng dengan telur, ayam, dan sayuran', price: 35000.0, category: 'Makanan', imageIcon: '🍚'),
    MenuItem(id: 'F02', name: 'Mie Ayam', description: 'Mie dengan topping ayam dan pangsit', price: 28000.0, category: 'Makanan', imageIcon: '🍜'),
    MenuItem(id: 'F03', name: 'Gado-Gado', description: 'Salad Indonesia dengan bumbu kacang', price: 25000.0, category: 'Makanan', imageIcon: '🥗'),
    MenuItem(id: 'F04', name: 'Ayam Bakar', description: 'Ayam bakar bumbu kecap dengan lalapan', price: 40000.0, category: 'Makanan', imageIcon: '🍗'),
    MenuItem(id: 'F05', name: 'Soto Ayam', description: 'Sup ayam kuning dengan rempah tradisional', price: 30000.0, category: 'Makanan', imageIcon: '🍲'),
    MenuItem(id: 'F06', name: 'Rendang', description: 'Daging sapi dengan bumbu rendang autentik', price: 45000.0, category: 'Makanan', imageIcon: '🥩'),
    MenuItem(id: 'F07', name: 'Sandwich Club', description: 'Sandwich lapis dengan ayam, telur, dan sayuran', price: 32000.0, category: 'Makanan', imageIcon: '🥪'),
    MenuItem(id: 'F08', name: 'Pasta Carbonara', description: 'Pasta dengan saus carbonara creamy', price: 38000.0, category: 'Makanan', imageIcon: '🍝'),
    MenuItem(id: 'F09', name: 'Pizza Margherita', description: 'Pizza klasik dengan tomat, keju, dan basil', price: 50000.0, category: 'Makanan', imageIcon: '🍕'),
    MenuItem(id: 'F10', name: 'Burger Beef', description: 'Burger daging sapi dengan keju dan sayuran', price: 42000.0, category: 'Makanan', imageIcon: '🍔'),
    MenuItem(id: 'F11', name: 'Fish & Chips', description: 'Ikan crispy dengan kentang goreng', price: 40000.0, category: 'Makanan', imageIcon: '🍟'),
    MenuItem(id: 'F12', name: 'Chicken Wings', description: 'Sayap ayam dengan saus pedas manis', price: 35000.0, category: 'Makanan', imageIcon: '🍗'),
    MenuItem(id: 'F13', name: 'Caesar Salad', description: 'Salad dengan dressing caesar dan crouton', price: 30000.0, category: 'Makanan', imageIcon: '🥗'),
    MenuItem(id: 'F14', name: 'Fried Rice', description: 'Nasi goreng ala western dengan sosis', price: 32000.0, category: 'Makanan', imageIcon: '🍚'),
    MenuItem(id: 'F15', name: 'Grilled Chicken', description: 'Ayam panggang dengan herbs dan lemon', price: 38000.0, category: 'Makanan', imageIcon: '🍗'),
    MenuItem(id: 'F16', name: 'Beef Steak', description: 'Steak daging sapi dengan saus black pepper', price: 55000.0, category: 'Makanan', imageIcon: '🥩'),
    MenuItem(id: 'F17', name: 'Ramen', description: 'Mie ramen Jepang dengan kuah kaldu kaya', price: 35000.0, category: 'Makanan', imageIcon: '🍜'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<MenuItem> get _drinks => _menuItems.where((item) => item.category == 'Minuman').toList();
  List<MenuItem> get _foods => _menuItems.where((item) => item.category == 'Makanan').toList();

  void _addToCart(MenuItem item) {
    setState(() {
      final index = _cart.indexWhere((orderItem) => orderItem.item.id == item.id);
      if (index != -1) {
        _cart[index].quantity++;
      } else {
        _cart.add(OrderItem(item: item));
      }
    });
    _showSnackBar('${item.name} ditambahkan ke keranjang!');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _goToCartScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CartScreen(cartItems: _cart),
      ),
    ).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    int totalItems = _cart.fold(0, (sum, item) => sum + item.quantity);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cafe Sukma', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.local_drink), text: 'Minuman'),
            Tab(icon: Icon(Icons.restaurant), text: 'Makanan'),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: _goToCartScreen,
              ),
              if (_cart.isNotEmpty)
                Positioned(
                  right: 0,
                  top: 4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                    child: Text(
                      '$totalItems',
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMenuList(_drinks),
          _buildMenuList(_foods),
        ],
      ),
    );
  }

  Widget _buildMenuList(List<MenuItem> items) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [Colors.brown.shade50, Colors.brown.shade100],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.brown.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        item.imageIcon,
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
                                color: Colors.green,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => _addToCart(item),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              ),
                              child: const Text('Tambah'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CartScreen extends StatefulWidget {
  final List<OrderItem> cartItems;

  const CartScreen({super.key, required this.cartItems});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double subtotal = widget.cartItems.fold(
      0.0,
          (sum, item) => sum + item.item.price * item.quantity,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
        centerTitle: true,
      ),
      body: widget.cartItems.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey),
            SizedBox(height: 16),
            Text('Keranjang masih kosong', style: TextStyle(fontSize: 18, color: Colors.grey)),
          ],
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final orderItem = widget.cartItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.brown.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              orderItem.item.imageIcon,
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orderItem.item.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Rp ${orderItem.item.price.toStringAsFixed(0)}',
                                style: const TextStyle(fontSize: 14, color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle, color: Colors.red),
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
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.brown.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                orderItem.quantity.toString(),
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle, color: Colors.green),
                              onPressed: () {
                                setState(() => orderItem.quantity++);
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
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.brown.shade50,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Belanja:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rp ${subtotal.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: widget.cartItems.isNotEmpty
                        ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(cartItems: widget.cartItems),
                        ),
                      );
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Lanjut ke Pembayaran',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  final List<OrderItem> cartItems;

  const PaymentScreen({super.key, required this.cartItems});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _paymentController = TextEditingController();
  double get _total => widget.cartItems.fold(0.0, (sum, item) => sum + item.item.price * item.quantity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ringkasan Pesanan',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown),
                    ),
                    const Divider(),
                    ...widget.cartItems.map((item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text('${item.item.name} x${item.quantity}'),
                          ),
                          Text(
                            'Rp ${(item.item.price * item.quantity).toStringAsFixed(0)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Rp ${_total.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Masukkan Jumlah Pembayaran',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _paymentController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: 'Jumlah Bayar',
                prefixText: 'Rp ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.brown, width: 2),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_paymentController.text.isNotEmpty) {
                    double payment = double.tryParse(_paymentController.text) ?? 0;
                    if (payment >= _total) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ReceiptScreen(
                            cartItems: widget.cartItems,
                            payment: payment,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Jumlah pembayaran kurang!'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Masukkan jumlah pembayaran!'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Proses Pembayaran',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReceiptScreen extends StatelessWidget {
  final List<OrderItem> cartItems;
  final double payment;

  const ReceiptScreen({
    super.key,
    required this.cartItems,
    required this.payment,
  });

  @override
  Widget build(BuildContext context) {
    double totalAmount = cartItems.fold(0.0, (sum, item) => sum + (item.item.price * item.quantity));
    double change = payment - totalAmount;
    int totalItems = cartItems.fold(0, (sum, item) => sum + item.quantity);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nota Pembelian'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Text(
                      '☕ CAFE SUKMA ☕',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Jl. Pangeran Sukarma No. 123',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const Text(
                      'Telp: (021) 123-4567',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const Divider(height: 32, thickness: 2),
                    Text(
                      'Tanggal: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      'Waktu: ${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const Divider(height: 24, thickness: 1),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        'Detail Pesanan',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown),
                      ),
                      const Divider(),
                      Expanded(
                        child: ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final item = cartItems[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  Text(item.item.imageIcon, style: const TextStyle(fontSize: 20)),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.item.name,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${item.quantity} x Rp ${item.item.price.toStringAsFixed(0)}',
                                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'Rp ${(item.item.price * item.quantity).toStringAsFixed(0)}',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const Divider(thickness: 2),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Item: $totalItems'),
                              Text('Subtotal: Rp ${totalAmount.toStringAsFixed(0)}'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total Tagihan:',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Rp ${totalAmount.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Dibayar:', style: TextStyle(fontSize: 16)),
                              Text(
                                'Rp ${payment.toStringAsFixed(0)}',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Kembalian:', style: TextStyle(fontSize: 16)),
                              Text(
                                'Rp ${change.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.brown.shade50,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      '🙏 Terima Kasih! 🙏',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Selamat menikmati pesanan Anda!\nSemoga hari Anda menyenangkan!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showOrderAgainDialog(context);
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Pesan Lagi'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    icon: const Icon(Icons.home),
                    label: const Text('Selesai'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderAgainDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Row(
            children: [
              Icon(Icons.restaurant_menu, color: Colors.brown),
              SizedBox(width: 8),
              Text('Pesan Lagi?'),
            ],
          ),
          content: const Text('Apakah Anda ingin membuat pesanan baru?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tidak', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const MainMenuScreen()),
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Ya, Pesan Lagi'),
            ),
          ],
        );
      },
    );
  }
}