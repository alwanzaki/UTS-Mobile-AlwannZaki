import 'package:flutter/material.dart';
import '../data.dart';
import '../theme.dart';
import '../widgets.dart';

/// Halaman Pesanan Saya. initialTab: 0 Menunggu Pembayaran, 1 Diproses,
/// 2 Dikirim, 3 Selesai, 4 Dibatalkan.
class OrdersScreen extends StatelessWidget {
  final int initialTab;
  const OrdersScreen({super.key, this.initialTab = 3});

  static const List<String> _tabs = [
    'Menunggu Pembayaran',
    'Diproses',
    'Dikirim',
    'Selesai',
    'Dibatalkan',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      initialIndex: initialTab.clamp(0, _tabs.length - 1),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pesanan Saya', style: TextStyle(fontSize: 16)),
          actions: const [
            Icon(Icons.search),
            SizedBox(width: 12),
          ],
          bottom: TabBar(
            isScrollable: true,
            labelColor: tokoGreen,
            unselectedLabelColor: textGrey,
            indicatorColor: tokoGreen,
            tabs: [for (final t in _tabs) Tab(text: t)],
          ),
        ),
        body: TabBarView(
          children: [
            for (int i = 0; i < _tabs.length; i++)
              i == 3 ? _doneList() : _empty(_tabs[i]),
          ],
        ),
      ),
    );
  }

  Widget _empty(String status) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.receipt_long, size: 56, color: Colors.black26),
          const SizedBox(height: 8),
          Text('Belum ada pesanan "$status"',
              style: const TextStyle(color: textGrey)),
        ],
      ),
    );
  }

  Widget _doneList() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: doneOrders.length,
      itemBuilder: (context, i) => _orderCard(doneOrders[i]),
    );
  }

  Widget _orderCard(Order o) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const StoreBadge(),
              const SizedBox(width: 6),
              Expanded(
                child: Text(o.store,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13)),
              ),
              const Text('Selesai',
                  style: TextStyle(color: tokoGreen, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImage(icon: o.icon, color: o.color, size: 56),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(o.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12)),
                    Text(o.variant,
                        style:
                            const TextStyle(fontSize: 11, color: textGrey)),
                    Text('${o.qty} x ${rp(o.price)}',
                        style:
                            const TextStyle(fontSize: 11, color: textGrey)),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 20),
          Text.rich(
            TextSpan(
              text: 'Total belanja: ',
              style: const TextStyle(fontSize: 12, color: textGrey),
              children: [
                TextSpan(
                  text: rp(o.total),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (o.rated) ...[
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Lihat Ulasan'),
                ),
                const SizedBox(width: 8),
              ],
              if (!o.rated) ...[
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Ulas'),
                ),
                const SizedBox(width: 8),
              ],
              ElevatedButton(
                onPressed: () {},
                child: const Text('Beli Lagi'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
