import 'package:flutter/material.dart';
import '../theme.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

/// Kerangka navigasi bawah. tabAwal: 0 = Beranda, 4 = Akun.
class MainShell extends StatefulWidget {
  final int tabAwal;
  const MainShell({super.key, this.tabAwal = 0});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.tabAwal;
  }

  Widget _placeholder(String title) {
    return SafeArea(
      child: Center(
        child: Text(
          '$title\n(halaman belum dibuat)',
          textAlign: TextAlign.center,
          style: const TextStyle(color: textGrey),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          const HomeScreen(),
          _placeholder('Feed'),
          _placeholder('Official Store'),
          _placeholder('Wishlist'),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: tokoGreen,
        unselectedItemColor: textGrey,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.dynamic_feed_outlined), activeIcon: Icon(Icons.dynamic_feed), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.storefront_outlined), activeIcon: Icon(Icons.storefront), label: 'Official Store'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), activeIcon: Icon(Icons.favorite), label: 'Wishlist'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Akun'),
        ],
      ),
    );
  }
}
