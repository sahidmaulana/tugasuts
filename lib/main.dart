import 'package:flutter/material.dart';

void main() {
  runApp(const CafeApp());
}

class CafeApp extends StatelessWidget {
  const CafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cafe Sederhana',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MenuScreen(),
    );
  }
}

class MenuItem {
  final String name;
  final String description;
  final double price;

  MenuItem({
    required this.name,
    required this.description,
    required this.price,
  });
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<MenuItem> _menuItems = [
    MenuItem(
      name: 'Espresso',
      description: 'Kopi pekat dengan crema sempurna.',
      price: 25000.0,
    ),
    MenuItem(
      name: 'Latte',
      description: 'Espresso dengan susu steamed dan sedikit busa.',
      price: 30000.0,
    ),
    MenuItem(
      name: 'Cappuccino',
      description: 'Espresso dengan susu steamed dan busa tebal.',
      price: 30000.0,
    ),
    MenuItem(
      name: 'Americano',
      description: 'Espresso diencerkan dengan air panas.',
      price: 28000.0,
    ),
    MenuItem(
      name: 'Croissant',
      description: 'Roti renyah dengan mentega.',
      price: 20000.0,
    ),
    MenuItem(
      name: 'Chocolate Cake',
      description: 'Kue cokelat lezat.',
      price: 35000.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Cafe'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _menuItems.length,
        itemBuilder: (context, index) {
          final item = _menuItems[index];
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
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'Rp ${item.price.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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