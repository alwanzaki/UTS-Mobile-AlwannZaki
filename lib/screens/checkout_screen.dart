import 'package:flutter/material.dart';
import '../data.dart';
import '../theme.dart';
import '../widgets.dart';
import 'orders_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Product> selectedItems;
  const CheckoutScreen({super.key, required this.selectedItems});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  static const int _proteksiPrice = 1700;
  static const int _maxDiskonOngkir = 10000;

  final List<Map<String, dynamic>> _shipping = [
    {'name': 'Reguler', 'eta': 'Estimasi tiba 2-3 hari', 'cost': 12000},
    {'name': 'Hemat Kargo', 'eta': 'Estimasi tiba 4-6 hari', 'cost': 8000},
    {'name': 'Instan', 'eta': 'Estimasi tiba hari ini', 'cost': 25000},
  ];

  bool _proteksi = false;
  int _shipIndex = 0;

  int get _subtotal =>
      widget.selectedItems.fold(0, (s, p) => s + p.price * p.qty);
  int get _hemat => widget.selectedItems
      .fold(0, (s, p) => s + (p.oldPrice - p.price) * p.qty);
  int get _proteksiTotal =>
      _proteksi ? _proteksiPrice * widget.selectedItems.length : 0;
  int get _ongkir => _shipping[_shipIndex]['cost'] as int;
  int get _diskonOngkir => _ongkir < _maxDiskonOngkir ? _ongkir : _maxDiskonOngkir;
  int get _total => _subtotal + _proteksiTotal + _ongkir - _diskonOngkir;

  void _buatPesanan() {
    final messenger = ScaffoldMessenger.of(context);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const OrdersScreen(initialTab: 3)),
      (route) => route.isFirst,
    );
    messenger.showSnackBar(
      const SnackBar(content: Text('Pesanan berhasil dibuat')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout', style: TextStyle(fontSize: 16)),
      ),
      body: ListView(
        children: [
          _address(),
          const SizedBox(height: 8),
          _products(),
          const SizedBox(height: 8),
          _shippingSection(),
          const SizedBox(height: 8),
          _summary(),
          const SizedBox(height: 8),
        ],
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget _address() {
    return const Section(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.location_on, color: tokoGreen),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Budi Santoso (+62) 812-3456-7890',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                SizedBox(height: 2),
                Text(
                    'Jl. Merdeka No. 10, RT 01/RW 02, Kel. Contoh, Kec. Contoh, Kota Contoh, Jawa Tengah 51111',
                    style: TextStyle(fontSize: 12, color: textGrey)),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: textGrey),
        ],
      ),
    );
  }

  Widget _products() {
    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final p in widget.selectedItems) ...[
            Row(
              children: [
                const StoreBadge(),
                const SizedBox(width: 6),
                Text(p.store,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductImage(icon: p.icon, color: p.color, size: 56),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(p.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12)),
                      Text(p.variant,
                          style: const TextStyle(
                              fontSize: 11, color: textGrey)),
                      Row(
                        children: [
                          Text(rp(p.price),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                          const SizedBox(width: 6),
                          Text(rp(p.oldPrice),
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: textGrey,
                                  decoration: TextDecoration.lineThrough)),
                          const Spacer(),
                          Text('x${p.qty}',
                              style: const TextStyle(
                                  fontSize: 12, color: textGrey)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
          ],
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.green.shade50,
            child: Row(
              children: [
                Checkbox(
                  value: _proteksi,
                  onChanged: (v) => setState(() => _proteksi = v ?? false),
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Proteksi Kerusakan +',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                      Text('Dapatkan kompensasi 100% jika barang rusak.',
                          style: TextStyle(fontSize: 10, color: textGrey)),
                    ],
                  ),
                ),
                Text('${rp(_proteksiPrice)} x${widget.selectedItems.length}',
                    style: const TextStyle(fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shippingSection() {
    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Opsi Pengiriman',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 8),
          for (int i = 0; i < _shipping.length; i++)
            InkWell(
              onTap: () => setState(() => _shipIndex = i),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _shipIndex == i ? Colors.green.shade50 : Colors.white,
                  border: Border.all(
                      color: _shipIndex == i
                          ? tokoGreen
                          : Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_shipping[i]['name'] as String,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13)),
                          Text(_shipping[i]['eta'] as String,
                              style: const TextStyle(
                                  fontSize: 11, color: textGrey)),
                        ],
                      ),
                    ),
                    Text(rp(_shipping[i]['cost'] as int),
                        style: const TextStyle(fontSize: 13)),
                  ],
                ),
              ),
            ),
          const Text('Diskon ongkir s/d Rp10.000 untuk pesanan ini.',
              style: TextStyle(fontSize: 11, color: textGrey)),
        ],
      ),
    );
  }

  Widget _summary() {
    Widget row(String label, String value, {Color? color, bool bold = false}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            Expanded(
              child: Text(label,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
            ),
            Text(value,
                style: TextStyle(
                    fontSize: 12,
                    color: color,
                    fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
          ],
        ),
      );
    }

    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Ringkasan Belanja',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 6),
          row('Total Harga Barang', rp(_subtotal)),
          row('Proteksi Kerusakan', rp(_proteksiTotal)),
          row('Ongkos Kirim', rp(_ongkir)),
          row('Diskon Ongkir', rp(-_diskonOngkir), color: tokoGreen),
          const Divider(),
          row('Total Pembayaran', rp(_total), bold: true),
        ],
      ),
    );
  }

  Widget _bottomBar() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 6),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Total ',
                      style: const TextStyle(fontSize: 12),
                      children: [
                        TextSpan(
                          text: rp(_total),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: tokoOrange),
                        ),
                      ],
                    ),
                  ),
                  Text('Hemat ${rp(_hemat + _diskonOngkir)}',
                      style: const TextStyle(fontSize: 11, color: tokoGreen)),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _buatPesanan,
              child: const Text('Buat Pesanan'),
            ),
          ],
        ),
      ),
    );
  }
}
