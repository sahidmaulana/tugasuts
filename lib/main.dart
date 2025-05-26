import 'package:flutter/material.dart';

void main() {
  runApp(CafeSukmaApp());
}

class CafeSukmaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cafe Sukma',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        primaryColor: Colors.brown[800],
        colorScheme: ColorScheme.fromSwatch().copyWith(
          surface: Colors.brown[50],
        ),
        scaffoldBackgroundColor: Colors.brown[50],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.brown[800],
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown[700],
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: CafeSukmaHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Model untuk item menu
class MenuItem {
  final String name;
  final double price;
  final String category;

  MenuItem({
    required this.name,
    required this.price,
    required this.category,
  });
}

// Model untuk item di keranjang
class CartItem {
  final MenuItem menuItem;
  int quantity;

  CartItem({
    required this.menuItem,
    this.quantity = 1,
  });

  double get subtotal => menuItem.price * quantity;
}

class CafeSukmaHome extends StatefulWidget {
  @override
  _CafeSukmaHomeState createState() => _CafeSukmaHomeState();
}

class _CafeSukmaHomeState extends State<CafeSukmaHome> {
  // Daftar menu makanan dan minuman
  final List<MenuItem> menuItems = [
    // Makanan
    MenuItem(name: 'Nasi Goreng Spesial', price: 25000, category: 'Makanan'),
    MenuItem(name: 'Ayam Bakar', price: 30000, category: 'Makanan'),
    MenuItem(name: 'Gado-Gado', price: 20000, category: 'Makanan'),
    MenuItem(name: 'Mie Ayam', price: 18000, category: 'Makanan'),
    MenuItem(name: 'Sate Ayam', price: 28000, category: 'Makanan'),
    MenuItem(name: 'Bakso', price: 15000, category: 'Makanan'),
    MenuItem(name: 'Rendang', price: 35000, category: 'Makanan'),
    MenuItem(name: 'Soto Ayam', price: 22000, category: 'Makanan'),

    // Minuman
    MenuItem(name: 'Kopi Hitam', price: 8000, category: 'Minuman'),
    MenuItem(name: 'Kopi Susu', price: 12000, category: 'Minuman'),
    MenuItem(name: 'Cappuccino', price: 18000, category: 'Minuman'),
    MenuItem(name: 'Teh Manis', price: 6000, category: 'Minuman'),
    MenuItem(name: 'Jus Jeruk', price: 15000, category: 'Minuman'),
    MenuItem(name: 'Jus Mangga', price: 16000, category: 'Minuman'),
    MenuItem(name: 'Es Teh', price: 7000, category: 'Minuman'),
    MenuItem(name: 'Milkshake Vanilla', price: 20000, category: 'Minuman'),
  ];

  // List untuk menyimpan item di keranjang
  List<CartItem> cartItems = [];

  // Controller untuk input uang pembayaran
  TextEditingController paymentController = TextEditingController();

  // Variabel untuk menampung total harga
  double get totalPrice {
    return cartItems.fold(0, (sum, item) => sum + item.subtotal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.local_cafe, size: 28),
            SizedBox(width: 8),
            Text(
              'Cafe Sukma',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Row(
        children: [
          // Panel kiri - Menu
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Menu Cafe Sukma',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[800],
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildCategorySection('Makanan'),
                        SizedBox(height: 20),
                        _buildCategorySection('Minuman'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Divider
          Container(
            width: 1,
            color: Colors.brown[300],
          ),

          // Panel kanan - Keranjang dan Pembayaran
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pesanan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[800],
                    ),
                  ),
                  SizedBox(height: 16),

                  // Daftar item di keranjang
                  Expanded(
                    flex: 2,
                    child: _buildCartSection(),
                  ),

                  Divider(thickness: 2, color: Colors.brown[300]),

                  // Section pembayaran
                  Expanded(
                    flex: 1,
                    child: _buildPaymentSection(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk membangun section kategori menu
  Widget _buildCategorySection(String category) {
    List<MenuItem> categoryItems = menuItems.where((item) => item.category == category).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.brown[700],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            category,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 12),
        ...categoryItems.map((item) => _buildMenuItem(item)).toList(),
      ],
    );
  }

  // Widget untuk item menu individual
  Widget _buildMenuItem(MenuItem item) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Rp ${_formatPrice(item.price)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.brown[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => _addToCart(item),
              child: Text('Tambah'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk section keranjang
  Widget _buildCartSection() {
    if (cartItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 48,
              color: Colors.brown[400],
            ),
            SizedBox(height: 8),
            Text(
              'Keranjang Kosong',
              style: TextStyle(
                fontSize: 16,
                color: Colors.brown[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        CartItem cartItem = cartItems[index];
        return Card(
          margin: EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        cartItem.menuItem.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _removeFromCart(index),
                      icon: Icon(Icons.delete, color: Colors.red[600]),
                      iconSize: 18,
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => _decreaseQuantity(index),
                      icon: Icon(Icons.remove, size: 16),
                      iconSize: 16,
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '${cartItem.quantity}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _increaseQuantity(index),
                      icon: Icon(Icons.add, size: 16),
                      iconSize: 16,
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                    Spacer(),
                    Text(
                      'Rp ${_formatPrice(cartItem.subtotal)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget untuk section pembayaran
  Widget _buildPaymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Total harga
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.brown[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Rp ${_formatPrice(totalPrice)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[800],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16),

        // Input uang pembayaran
        TextField(
          controller: paymentController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Uang Dibayar',
            prefixText: 'Rp ',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.brown[700]!),
            ),
          ),
        ),

        SizedBox(height: 16),

        // Tombol bayar
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: cartItems.isEmpty ? null : _processPayment,
            child: Text(
              'BAYAR',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  // Fungsi untuk menambah item ke keranjang
  void _addToCart(MenuItem item) {
    setState(() {
      // Cek apakah item sudah ada di keranjang
      int existingIndex = cartItems.indexWhere((cartItem) => cartItem.menuItem.name == item.name);

      if (existingIndex != -1) {
        // Jika sudah ada, tambah quantity
        cartItems[existingIndex].quantity++;
      } else {
        // Jika belum ada, tambah item baru
        cartItems.add(CartItem(menuItem: item));
      }
    });

    // Tampilkan snackbar konfirmasi
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} ditambahkan ke pesanan'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.brown[700],
      ),
    );
  }

  // Fungsi untuk menghapus item dari keranjang
  void _removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  // Fungsi untuk menambah quantity
  void _increaseQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
    });
  }

  // Fungsi untuk mengurangi quantity
  void _decreaseQuantity(int index) {
    setState(() {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      }
    });
  }

  // Fungsi untuk memproses pembayaran
  void _processPayment() {
    if (paymentController.text.isEmpty) {
      _showErrorDialog('Masukkan jumlah uang pembayaran!');
      return;
    }

    double payment;
    try {
      payment = double.parse(paymentController.text.replaceAll(',', ''));
    } catch (e) {
      _showErrorDialog('Format uang tidak valid!');
      return;
    }

    if (payment < totalPrice) {
      _showErrorDialog('Uang tidak cukup!\nKurang: Rp ${_formatPrice(totalPrice - payment)}');
      return;
    }

    double change = payment - totalPrice;
    _showReceipt(payment, change);
  }

  // Fungsi untuk menampilkan dialog error
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Error',
            style: TextStyle(color: Colors.red[700]),
          ),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk menampilkan struk
  void _showReceipt(double payment, double change) {
    DateTime now = DateTime.now();
    String dateTime = '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Column(
              children: [
                Icon(
                  Icons.local_cafe,
                  size: 32,
                  color: Colors.brown[700],
                ),
                SizedBox(height: 8),
                Text(
                  'CAFE SUKMA',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800],
                  ),
                ),
                Text(
                  'STRUK PEMBELIAN',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.brown[600],
                  ),
                ),
                Divider(),
              ],
            ),
          ),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tanggal: $dateTime',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 8),
                Divider(),

                // Daftar item
                ...cartItems.map((item) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          item.menuItem.name,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '${item.quantity}x',
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Rp ${_formatPrice(item.subtotal)}',
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                )).toList(),

                Divider(),

                // Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TOTAL:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rp ${_formatPrice(totalPrice)}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                SizedBox(height: 8),

                // Pembayaran
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Bayar:'),
                    Text('Rp ${_formatPrice(payment)}'),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Kembalian:'),
                    Text('Rp ${_formatPrice(change)}'),
                  ],
                ),

                SizedBox(height: 16),

                Center(
                  child: Text(
                    'Terima Kasih telah berkunjung\nke Cafe Sukma',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.brown[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('TUTUP'),
              onPressed: () {
                Navigator.of(context).pop();
                _resetTransaction();
              },
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk reset transaksi setelah pembayaran berhasil
  void _resetTransaction() {
    setState(() {
      cartItems.clear();
      paymentController.clear();
    });
  }

  // Fungsi untuk format harga
  String _formatPrice(double price) {
    return price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
    );
  }

  @override
  void dispose() {
    paymentController.dispose();
    super.dispose();
  }
}