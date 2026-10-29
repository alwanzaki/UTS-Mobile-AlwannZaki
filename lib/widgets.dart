import 'package:flutter/material.dart';
import 'theme.dart';

/// Mengubah angka menjadi format Rupiah, contoh: 181450 -> Rp181.450
String rp(int n) {
  final s = n.abs().toString();
  final b = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) b.write('.');
    b.write(s[i]);
  }
  return '${n < 0 ? '-' : ''}Rp$b';
}

/// Kotak putih sebagai pembungkus bagian halaman.
class Section extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  const Section({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: padding,
      child: child,
    );
  }
}

/// Gambar produk sederhana (ikon di atas warna latar).
class ProductImage extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  const ProductImage({
    super.key,
    required this.icon,
    required this.color,
    this.size = 64,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: size * 0.5, color: Colors.black54),
    );
  }
}

/// Label kecil "Official Store" di samping nama toko.
class StoreBadge extends StatelessWidget {
  const StoreBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: tokoGreen,
        borderRadius: BorderRadius.circular(3),
      ),
      child: const Icon(Icons.verified, size: 12, color: Colors.white),
    );
  }
}
