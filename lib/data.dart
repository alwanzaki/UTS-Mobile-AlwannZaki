import 'package:flutter/material.dart';

/// Model produk (dipakai di Beranda, Keranjang, dan Checkout).
class Product {
  final int id;
  final String store;
  final String name;
  final String variant;
  final int price;
  final int oldPrice;
  final String city;
  final double rating;
  final int sold;
  final IconData icon;
  final Color color;
  int qty;
  bool selected;

  Product({
    required this.id,
    required this.store,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.icon,
    required this.color,
    this.variant = '',
    this.city = 'Jakarta Barat',
    this.rating = 4.8,
    this.sold = 100,
    this.qty = 1,
    this.selected = false,
  });

  int get discountPercent =>
      oldPrice > price ? (((oldPrice - price) * 100) / oldPrice).round() : 0;
}

/// Model pesanan yang sudah selesai.
class Order {
  final String store;
  final String name;
  final String variant;
  final int price;
  final int qty;
  final int total;
  final bool rated;
  final IconData icon;
  final Color color;

  const Order({
    required this.store,
    required this.name,
    required this.variant,
    required this.price,
    required this.qty,
    required this.total,
    required this.rated,
    required this.icon,
    required this.color,
  });
}

/// Data dummy isi keranjang (dibuat baru setiap dipanggil).
List<Product> cartItems() => [
      Product(
        id: 1,
        store: 'Eiger Official Store',
        name: 'Tas Ransel Laptop Eiger Rhinos 25L',
        variant: 'Hitam',
        price: 349000,
        oldPrice: 499000,
        icon: Icons.backpack,
        color: Colors.blueGrey.shade100,
      ),
      Product(
        id: 2,
        store: 'Logitech Official Store',
        name: 'Mouse Wireless Logitech M331 Silent',
        variant: 'Hitam',
        price: 189000,
        oldPrice: 249000,
        icon: Icons.mouse,
        color: Colors.indigo.shade100,
      ),
      Product(
        id: 3,
        store: 'Logitech Official Store',
        name: 'Keyboard Bluetooth Logitech K380',
        variant: 'Putih',
        price: 429000,
        oldPrice: 519000,
        icon: Icons.keyboard,
        color: Colors.teal.shade100,
      ),
      Product(
        id: 4,
        store: 'Gadget Jaya Mandiri',
        name: 'Kabel Data USB-C 1 Meter Fast Charging',
        variant: 'Putih',
        price: 25000,
        oldPrice: 45000,
        icon: Icons.cable,
        color: Colors.orange.shade100,
      ),
    ];

/// Data dummy produk Beranda.
final List<Product> homeProducts = [
  Product(
      id: 11,
      store: 'Sepatu Kita',
      name: 'Sepatu Sneakers Pria Casual Putih',
      price: 159000,
      oldPrice: 299000,
      city: 'Bandung',
      rating: 4.9,
      sold: 2300,
      icon: Icons.directions_run,
      color: Colors.lightBlue.shade100),
  Product(
      id: 12,
      store: 'Samsung Official',
      name: 'Headset Bluetooth TWS Earbuds Pro',
      price: 249000,
      oldPrice: 399000,
      city: 'Jakarta Pusat',
      rating: 4.7,
      sold: 1500,
      icon: Icons.headphones,
      color: Colors.purple.shade100),
  Product(
      id: 13,
      store: 'Kaos Nusantara',
      name: 'Kaos Oversize Cotton Combed 30s',
      price: 65000,
      oldPrice: 99000,
      city: 'Semarang',
      rating: 4.8,
      sold: 5200,
      icon: Icons.checkroom,
      color: Colors.pink.shade100),
  Product(
      id: 14,
      store: 'Dapur Sehat',
      name: 'Blender Portable USB Rechargeable',
      price: 119000,
      oldPrice: 189000,
      city: 'Surabaya',
      rating: 4.6,
      sold: 870,
      icon: Icons.blender,
      color: Colors.amber.shade100),
  Product(
      id: 15,
      store: 'Smart Watch ID',
      name: 'Smartwatch Layar AMOLED Tahan Air',
      price: 399000,
      oldPrice: 799000,
      city: 'Jakarta Barat',
      rating: 4.7,
      sold: 940,
      icon: Icons.watch,
      color: Colors.cyan.shade100),
  Product(
      id: 16,
      store: 'Buku Pintar',
      name: 'Buku Pemrograman Flutter untuk Pemula',
      price: 89000,
      oldPrice: 110000,
      city: 'Yogyakarta',
      rating: 5.0,
      sold: 320,
      icon: Icons.menu_book,
      color: Colors.green.shade100),
  Product(
      id: 17,
      store: 'Home Living',
      name: 'Lampu Meja LED Dimmer Touch',
      price: 75000,
      oldPrice: 125000,
      city: 'Tangerang',
      rating: 4.8,
      sold: 1800,
      icon: Icons.lightbulb,
      color: Colors.yellow.shade100),
  Product(
      id: 18,
      store: 'Tas Kita',
      name: 'Tas Selempang Pria Waterproof',
      price: 99000,
      oldPrice: 175000,
      city: 'Bekasi',
      rating: 4.7,
      sold: 2100,
      icon: Icons.work,
      color: Colors.brown.shade100),
];

/// Data dummy pesanan selesai.
final List<Order> doneOrders = [
  Order(
      store: 'Sport Station Official',
      name: 'Sepatu Lari Pria Ringan Breathable',
      variant: 'Ukuran 42',
      price: 275000,
      qty: 1,
      total: 281200,
      rated: false,
      icon: Icons.directions_run,
      color: Colors.lightBlue.shade100),
  Order(
      store: 'Toko Aksesoris HP',
      name: 'Case Silikon Anti Shock iPhone',
      variant: 'Hitam',
      price: 35000,
      qty: 2,
      total: 78500,
      rated: true,
      icon: Icons.phone_iphone,
      color: Colors.grey.shade300),
  Order(
      store: 'Gadget Jaya Mandiri',
      name: 'Charger Fast Charging 20W Type-C',
      variant: 'Putih',
      price: 55000,
      qty: 1,
      total: 61700,
      rated: true,
      icon: Icons.electrical_services,
      color: Colors.orange.shade100),
];
