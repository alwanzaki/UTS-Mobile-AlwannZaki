import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets.dart';
import 'orders_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _showNotice = true;

  void _openOrders(int tab) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => OrdersScreen(initialTab: tab)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _header(),
        if (_showNotice) _notice(),
        const SizedBox(height: 8),
        _orderSummary(),
        const SizedBox(height: 8),
        _wallet(),
        const SizedBox(height: 8),
        _menuList('Keuangan', [
          [Icons.account_balance, 'Tokopedia Card'],
          [Icons.savings, 'Saldo Tokopedia'],
          [Icons.credit_score, 'PayLater'],
        ]),
        const SizedBox(height: 8),
        _menuList('Aktivitas Saya', [
          [Icons.favorite_border, 'Wishlist'],
          [Icons.history, 'Terakhir Dilihat'],
          [Icons.storefront, 'Toko Favorit'],
        ]),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _header() {
    return Container(
      color: tokoGreen,
      padding: EdgeInsets.fromLTRB(
          14, MediaQuery.of(context).padding.top + 10, 14, 14),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.settings, color: Colors.white),
              SizedBox(width: 12),
              Icon(Icons.shopping_cart_outlined, color: Colors.white),
              SizedBox(width: 12),
              Icon(Icons.mail_outline, color: Colors.white),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const CircleAvatar(
                radius: 26,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 30, color: textGrey),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Alwan Zaki',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text('Member Gold',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 4),
                    const Text('0 Pengikut | 5 Mengikuti',
                        style: TextStyle(color: Colors.white70, fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _notice() {
    return Container(
      color: Colors.yellow.shade100,
      padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
      child: Row(
        children: [
          const Icon(Icons.info_outline, size: 18, color: Colors.orange),
          const SizedBox(width: 8),
          const Expanded(
            child: Text('Lengkapi Nama, Jenis Kelamin, dan Tanggal Lahir-mu.',
                style: TextStyle(fontSize: 12)),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            onPressed: () => setState(() => _showNotice = false),
          ),
        ],
      ),
    );
  }

  Widget _orderSummary() {
    final items = [
      [Icons.payment, 'Menunggu\nPembayaran'],
      [Icons.inventory_2_outlined, 'Diproses'],
      [Icons.local_shipping_outlined, 'Dikirim'],
      [Icons.rate_review_outlined, 'Beri\nUlasan'],
    ];
    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Pesanan Saya',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const Spacer(),
              InkWell(
                onTap: () => _openOrders(3),
                child: const Text('Lihat Riwayat Pesanan >',
                    style: TextStyle(color: tokoGreen, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(items.length, (i) {
              return Expanded(
                child: InkWell(
                  onTap: () => _openOrders(i),
                  child: Column(
                    children: [
                      Icon(items[i][0] as IconData, color: textGrey),
                      const SizedBox(height: 4),
                      Text(items[i][1] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 11, color: textGrey)),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _wallet() {
    Widget cell(IconData icon, String title, String sub) {
      return Expanded(
        child: Column(
          children: [
            Icon(icon, color: Colors.black87),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontSize: 12)),
            Text(sub, style: const TextStyle(fontSize: 10, color: tokoGreen)),
          ],
        ),
      );
    }

    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Dompet Saya',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 12),
          Row(
            children: [
              cell(Icons.account_balance_wallet, 'GoPay', 'Rp609'),
              cell(Icons.monetization_on, 'Koin Toko', 'Klaim Bonus'),
              cell(Icons.confirmation_number_outlined, 'Kupon Saya',
                  '3 Kupon'),
              cell(Icons.savings_outlined, 'Saldo', 'Rp1.250'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _menuList(String title, List<List<dynamic>> items) {
    return Section(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
            child: Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
          for (final it in items) ...[
            const Divider(height: 1),
            ListTile(
              dense: true,
              leading: Icon(it[0] as IconData, color: tokoGreen),
              title: Text(it[1] as String),
              trailing: const Icon(Icons.chevron_right, color: textGrey),
            ),
          ],
        ],
      ),
    );
  }
}
