import 'package:flutter/material.dart';
import '../data.dart';
import '../theme.dart';
import '../widgets.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Product> _items = cartItems();

  List<Product> get _chosen => _items.where((p) => p.selected).toList();
  int get _total => _chosen.fold(0, (sum, p) => sum + p.price * p.qty);
  int get _count => _chosen.fold(0, (sum, p) => sum + p.qty);
  bool get _allSelected => _items.isNotEmpty && _items.every((p) => p.selected);

  Map<String, List<Product>> get _byStore {
    final map = <String, List<Product>>{};
    for (final p in _items) {
      map.putIfAbsent(p.store, () => []).add(p);
    }
    return map;
  }

  void _goCheckout() {
    final chosen = _chosen;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CheckoutScreen(selectedItems: chosen),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final groups = _byStore;
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang (${_items.length})',
            style: const TextStyle(fontSize: 16)),
      ),
      body: _items.isEmpty
          ? const Center(
              child: Text('Keranjang kamu kosong',
                  style: TextStyle(color: textGrey)))
          : ListView(
              children: [
                for (final entry in groups.entries) _storeSection(entry),
                const SizedBox(height: 8),
              ],
            ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget _storeSection(MapEntry<String, List<Product>> entry) {
    final products = entry.value;
    final storeAll = products.every((p) => p.selected);
    return Container(
      margin: const EdgeInsets.only(top: 8),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: storeAll,
                onChanged: (v) => setState(() {
                  for (final p in products) {
                    p.selected = v ?? false;
                  }
                }),
              ),
              const StoreBadge(),
              const SizedBox(width: 6),
              Expanded(
                child: Text(entry.key,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13)),
              ),
            ],
          ),
          for (final p in products) _itemRow(p),
        ],
      ),
    );
  }

  Widget _itemRow(Product p) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 12, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: p.selected,
            onChanged: (v) => setState(() => p.selected = v ?? false),
          ),
          ProductImage(icon: p.icon, color: p.color, size: 64),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13)),
                const SizedBox(height: 2),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  color: bgGrey,
                  child: Text(p.variant,
                      style:
                          const TextStyle(fontSize: 10, color: textGrey)),
                ),
                const SizedBox(height: 4),
                Text(rp(p.price),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.delete_outline,
                          color: textGrey, size: 22),
                      onPressed: () => setState(() => _items.remove(p)),
                    ),
                    const Spacer(),
                    _qtyButton(Icons.remove, () {
                      if (p.qty > 1) setState(() => p.qty--);
                    }),
                    Container(
                      width: 36,
                      alignment: Alignment.center,
                      child: Text('${p.qty}',
                          style: const TextStyle(fontSize: 14)),
                    ),
                    _qtyButton(Icons.add, () => setState(() => p.qty++)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 16, color: tokoGreen),
      ),
    );
  }

  Widget _bottomBar() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(4, 6, 12, 6),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 6),
          ],
        ),
        child: Row(
          children: [
            Checkbox(
              value: _allSelected,
              onChanged: (v) => setState(() {
                for (final p in _items) {
                  p.selected = v ?? false;
                }
              }),
            ),
            const Text('Semua', style: TextStyle(fontSize: 13)),
            const Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('Total Harga',
                    style: TextStyle(fontSize: 10, color: textGrey)),
                Text(rp(_total),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15)),
              ],
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: _chosen.isEmpty ? null : _goCheckout,
              child: Text('Beli ($_count)'),
            ),
          ],
        ),
      ),
    );
  }
}
