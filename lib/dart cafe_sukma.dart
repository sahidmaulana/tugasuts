import 'dart:io';
import 'dart:math';

class MenuItem {
  final String name;
  final int price;
  final String category;
  final String description;
  final bool available;

  MenuItem(this.name, this.price, this.category, this.description,
      [this.available = true]);
}

class OrderItem {
  final MenuItem item;
  int quantity;

  OrderItem(this.item, this.quantity);
}

class Order {
  final List<OrderItem> items = [];

  void addItem(MenuItem item, int quantity) {
    final existing = items.firstWhere(
          (element) => element.item.name == item.name,
      orElse: () => OrderItem(item, 0),
    );
    if (!items.contains(existing)) {
      items.add(existing);
    }
    existing.quantity += quantity;
  }

  void clear() => items.clear();

  int get subtotal => items.fold(0, (sum, e) => sum + e.item.price * e.quantity);

  int get tax => (subtotal * 0.11).round();

  int get serviceCharge => (subtotal * 0.05).round();

  int get total => subtotal + tax + serviceCharge;

  void printSummary() {
    print("\nPesanan Anda:");
    for (var item in items) {
      print("- ${item.item.name} x${item.quantity} = Rp ${item.item.price * item.quantity}");
    }
    print("----------------------------");
    print("Subtotal      : Rp $subtotal");
    print("Pajak (11%)   : Rp $tax");
    print("Service (5%)  : Rp $serviceCharge");
    print("TOTAL         : Rp $total\n");
  }
}

class Payment {
  final String method;
  final int amountPaid;
  final int totalDue;

  Payment(this.method, this.amountPaid, this.totalDue);

  bool get isValid => amountPaid >= totalDue;

  int get change => amountPaid - totalDue;

  void printPayment() {
    print("Metode Pembayaran: $method");
    print("Dibayar: Rp $amountPaid");
    print("Kembalian: Rp $change\n");
  }
}

class Receipt {
  final Order order;
  final Payment payment;
  final String cashier;
  final String transactionId = DateTime.now().millisecondsSinceEpoch.toString();

  Receipt(this.order, this.payment, this.cashier);

  void printReceipt() {
    final now = DateTime.now();
    print("=============================");
    print("         CAFE SUKMA");
    print("    Jl. Contoh No. 123");
    print("  Telp: (021) 1234-5678");
    print("=============================");
    print("Tanggal : ${now.toLocal()}");
    print("Kasir   : $cashier");
    print("No. Transaksi: $transactionId");
    print("=============================");
    for (var item in order.items) {
      print("${item.item.name} x${item.quantity}    Rp ${item.item.price * item.quantity}");
    }
    print("-----------------------------");
    print("Subtotal        : Rp ${order.subtotal}");
    print("Pajak (11%)     : Rp ${order.tax}");
    print("Service (5%)    : Rp ${order.serviceCharge}");
    print("-----------------------------");
    print("TOTAL           : Rp ${order.total}");
    print("Pembayaran      : ${payment.method}");
    print("Bayar           : Rp ${payment.amountPaid}");
    print("Kembalian       : Rp ${payment.change}");
    print("=============================");
    print(" Terima kasih atas");
    print(" kunjungan Anda!");
    print("Selamat menikmati!");
    print("=============================");
  }

  void saveToFile() {
    final file = File("nota_${transactionId}.txt");
    final sink = file.openWrite();
    sink.writeln("=== NOTA CAFE SUKMA ===");
    for (var item in order.items) {
      sink.writeln("${item.item.name} x${item.quantity} = Rp ${item.item.price * item.quantity}");
    }
    sink.writeln("TOTAL: Rp ${order.total}");
    sink.writeln("Bayar: Rp ${payment.amountPaid}");
    sink.writeln("Kembali: Rp ${payment.change}");
    sink.writeln("Terima kasih!");
    sink.close();
    print("Nota disimpan ke file: ${file.path}");
  }
}

void main() {
  final menuItems = <MenuItem>[
    MenuItem('Espresso', 15000, 'Minuman Panas', 'Kopi hitam pekat'),
    MenuItem('Americano', 18000, 'Minuman Panas', 'Espresso + air panas'),
    MenuItem('Cappuccino', 22000, 'Minuman Panas', 'Espresso + susu busa'),
    MenuItem('Latte', 25000, 'Minuman Panas', 'Espresso + susu'),
    MenuItem('Mocha', 28000, 'Minuman Panas', 'Kopi + coklat'),

    MenuItem('Es Americano', 20000, 'Minuman Dingin', 'Americano dengan es'),
    MenuItem('Es Latte', 27000, 'Minuman Dingin', 'Latte dengan es'),
    MenuItem('Frappuccino', 32000, 'Minuman Dingin', 'Blended coffee'),
    MenuItem('Jus Jeruk', 15000, 'Minuman Dingin', 'Jeruk segar'),
    MenuItem('Smoothie Bowl', 35000, 'Minuman Dingin', 'Buah + yogurt'),

    MenuItem('Croissant', 12000, 'Makanan Ringan', 'Roti lapis mentega'),
    MenuItem('Pastry', 10000, 'Makanan Ringan', 'Kue renyah'),
    MenuItem('Cake', 28000, 'Makanan Ringan', 'Kue lembut dan manis'),
    MenuItem('Sandwich', 25000, 'Makanan Ringan', 'Roti isi daging dan sayur'),
    MenuItem('Nasi Goreng', 38000, 'Makanan Berat', 'Nasi + telur + ayam'),

    MenuItem('Pasta Carbonara', 45000, 'Makanan Berat', 'Pasta dengan saus krim'),
    MenuItem('Burger', 40000, 'Makanan Berat', 'Daging sapi + roti'),
    MenuItem('Steak', 70000, 'Makanan Berat', 'Daging panggang'),
    MenuItem('Pizza', 60000, 'Makanan Berat', 'Pizza mini topping keju'),
    MenuItem('Fish & Chips', 50000, 'Makanan Berat', 'Ikan goreng + kentang'),
  ];

  final order = Order();

  stdout.write("Masukkan nama kasir: ");
  final cashier = stdin.readLineSync() ?? "Kasir";

  while (true) {
    print("\n=== MENU CAFE SUKMA ===");
    var grouped = <String, List<MenuItem>>{};
    for (var item in menuItems) {
      grouped.putIfAbsent(item.category, () => []).add(item);
    }

    for (var category in grouped.keys) {
      print("\n[$category]");
      for (var item in grouped[category]!) {
        print("- ${item.name} (Rp ${item.price})");
      }
    }

    stdout.write("\nMasukkan nama item (atau 'done'): ");
    String? name = stdin.readLineSync();
    if (name == null || name.toLowerCase() == 'done') break;

    var menuItem = menuItems.firstWhere(
          (e) => e.name.toLowerCase() == name.toLowerCase(),
      orElse: () => MenuItem('', 0, '', ''),
    );
    if (menuItem.name == '') {
      print("Item tidak ditemukan.");
      continue;
    }

    stdout.write("Masukkan jumlah: ");
    int qty = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;
    if (qty <= 0) {
      print("Jumlah tidak valid.");
      continue;
    }

    order.addItem(menuItem, qty);
    print("${menuItem.name} x$qty ditambahkan ke pesanan.");
  }

  if (order.items.isEmpty) {
    print("Tidak ada pesanan.");
    return;
  }

  order.printSummary();

  stdout.write("Pilih metode pembayaran (Cash/Debit/Credit/E-Wallet): ");
  final method = stdin.readLineSync() ?? 'Cash';
  stdout.write("Masukkan jumlah uang yang diberikan: ");
  final amount = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;

  final payment = Payment(method, amount, order.total);

  if (!payment.isValid) {
    print("Pembayaran tidak cukup. Transaksi dibatalkan.");
    return;
  }

  final receipt = Receipt(order, payment, cashier);
  receipt.printReceipt();

  stdout.write("Simpan nota ke file? (y/n): ");
  if ((stdin.readLineSync() ?? '').toLowerCase() == 'y') {
    receipt.saveToFile();
  }

  print("\nTransaksi selesai.");
}
