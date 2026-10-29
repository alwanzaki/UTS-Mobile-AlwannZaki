import 'package:flutter/material.dart';
import '../data.dart';
import '../theme.dart';
import '../widgets.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          _header(context),
          _walletRow(),
          const SizedBox(height: 8),
          _menu(),
          const SizedBox(height: 8),
          _banner(),
          const SizedBox(height: 8),
          _flashSale(),
          const SizedBox(height: 8),
          _products(context),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 38,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, size: 20, color: textGrey),
                  SizedBox(width: 8),
                  Text('Cari di Tokopedia',
                      style: TextStyle(color: textGrey, fontSize: 14)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.mail_outline, color: textGrey),
          const SizedBox(width: 10),
          const Icon(Icons.notifications_none, color: textGrey),
          const SizedBox(width: 10),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen()),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_cart_outlined, color: textGrey),
                Positioned(
                  right: -6,
                  top: -6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: tokoOrange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('4',
                        style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _walletRow() {
    Widget item(IconData icon, String title, String sub) {
      return Expanded(
        child: Row(
          children: [
            Icon(icon, color: tokoGreen, size: 22),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold)),
                  Text(sub,
                      style: const TextStyle(fontSize: 10, color: textGrey)),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Row(
        children: [
          item(Icons.account_balance_wallet, 'Rp609', 'GoPay'),
          item(Icons.monetization_on, '150', 'Koin Toko'),
          item(Icons.local_activity, '3 Kupon', 'Cek kupon'),
        ],
      ),
    );
  }

  Widget _menu() {
    final menus = [
      [Icons.phone_android, 'Top-up &\nTagihan', Colors.green],
      [Icons.flight, 'Tiket &\nTravel', Colors.blue],
      [Icons.storefront, 'Official\nStore', Colors.purple],
      [Icons.delivery_dining, 'Tokopedia\nNow', Colors.orange],
      [Icons.card_giftcard, 'Hadiah\nSpesial', Colors.pink],
      [Icons.local_offer, 'Promo\nHari Ini', Colors.red],
    ];
    return Container(
      color: Colors.white,
      height: 96,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: menus.length,
        itemBuilder: (context, i) {
          final m = menus[i];
          final c = m[2] as MaterialColor;
          return Container(
            width: 72,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: c.shade50,
                  child: Icon(m[0] as IconData, color: c, size: 22),
                ),
                const SizedBox(height: 6),
                Text(m[1] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 10, color: textGrey)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _banner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      height: 90,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [tokoDark, tokoGreen]),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('GRATIS ONGKIR FESTIVAL',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text('Diskon hingga 70% - 26 Okt s/d 1 Nov',
              style: TextStyle(color: Colors.yellow, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _flashSale() {
    final items = homeProducts.take(5).toList();
    return Section(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Icon(Icons.flash_on, color: tokoOrange, size: 20),
                SizedBox(width: 4),
                Text('Flash Sale',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Spacer(),
                Text('Lihat Semua',
                    style: TextStyle(
                        color: tokoGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: items.length,
              itemBuilder: (context, i) {
                final p = items[i];
                return Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductImage(icon: p.icon, color: p.color, size: 100),
                      const SizedBox(height: 6),
                      Text(rp(p.price),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                      Text('-${p.discountPercent}%',
                          style: const TextStyle(
                              color: tokoOrange,
                              fontSize: 11,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _products(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Rekomendasi untuk Kamu',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: homeProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.66,
            ),
            itemBuilder: (context, i) => _productCard(context, homeProducts[i]),
          ),
        ],
      ),
    );
  }

  Widget _productCard(BuildContext context, Product p) {
    return InkWell(
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${p.name} (halaman detail belum dibuat)')),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: p.color,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Icon(p.icon, size: 56, color: Colors.black45),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(rp(p.price),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text('${p.discountPercent}%',
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 4),
                      Text(rp(p.oldPrice),
                          style: const TextStyle(
                              fontSize: 10,
                              color: textGrey,
                              decoration: TextDecoration.lineThrough)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(p.city,
                      style: const TextStyle(fontSize: 10, color: textGrey)),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 12, color: Colors.amber),
                      Text(' ${p.rating} | Terjual ${p.sold}+',
                          style: const TextStyle(
                              fontSize: 10, color: textGrey)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
