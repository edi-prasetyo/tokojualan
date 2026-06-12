import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

import 'core/constants/app_color.dart';
import 'core/services/auth_service.dart';

// IMPORT PROVIDER KAMU
import 'modules/auth/controllers/auth_controller.dart';
import 'modules/category/pages/category_page.dart';
import 'modules/favorites/pages/favorite_page.dart';
import 'modules/home/pages/home_page.dart';
import 'modules/profile/pages/profile_page.dart';
import 'modules/auth/pages/login_page.dart';

class MainNavigation extends ConsumerStatefulWidget {
  final int initialIndex;
  const MainNavigation({super.key, this.initialIndex = 0});

  @override
  ConsumerState<MainNavigation> createState() => _MainNavigationState();
}

class MenuItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  MenuItem({required this.icon, required this.activeIcon, required this.label});
}

class _MainNavigationState extends ConsumerState<MainNavigation> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  void onItemTapped(int index) async {
    final authService = ref.read(authServiceProvider);
    bool loggedIn = await authService.isLoggedIn();

    if ((index == 2 || index == 3) && !loggedIn) {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
      return; // Stop di sini jika belum login
    }

    // UPDATE STATE: Ini yang membuat halaman bisa berpindah
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    const CategoryPage(),
    const FavoritePage(),
    const ProfilePage(),
  ];

  final List<MenuItem> menus = [
    MenuItem(
      icon: MingCuteIcons.mgc_home_4_line,
      activeIcon: MingCuteIcons.mgc_home_4_fill,
      label: "Home",
    ),
    MenuItem(
      icon: MingCuteIcons.mgc_tag_2_line,
      activeIcon: MingCuteIcons.mgc_tag_2_fill,
      label: "Category",
    ),
    MenuItem(
      icon: MingCuteIcons.mgc_heart_line,
      activeIcon: MingCuteIcons.mgc_heart_fill,
      label: "Favorite",
    ),
    MenuItem(
      icon: MingCuteIcons.mgc_user_2_line,
      activeIcon: MingCuteIcons.mgc_user_2_fill,
      label: "Profile",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (previous, next) {
      if (next.value == null) {
        setState(() {
          selectedIndex = 0;
        });
      }
    });

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        if (selectedIndex != 0) {
          setState(() => selectedIndex = 0);
        } else {
          await SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: IndexedStack(index: selectedIndex, children: _pages),

        // 1. TAMBAHKAN FAB BULAT DI SINI
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(), // Memastikan bentuknya bulat sempurna
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          onPressed: () {
            // Aksi ketika tombol plus diklik
            print("Tombol Plus Diklik");
          },
          child: const Icon(Icons.add, size: 28),
        ),

        // 2. ATUR POSISINYA AGAR MELAYANG DI TENGAH BOTTOM NAVBAR
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors
                .white, // Menjaga background di belakang shadow tetap bersih
            boxShadow: [
              BoxShadow(
                color: AppColors.darkColor.withValues(alpha: 0.07),
                blurRadius: 10, // Tingkat keburaman bayangan
                spreadRadius: 2, // Seberapa luas bayangan menyebar
                offset: const Offset(
                  0,
                  -4,
                ), // -4 artinya bayangan mengarah ke ATAS (khas bottom nav)
              ),
            ],
          ),
          child: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: onItemTapped,
            backgroundColor: Colors.white,
            elevation:
                0, // 👈 PENTING: Set ke 0 agar elevasinya tidak tabrakan dengan custom shadow kita
            indicatorColor: AppColors.primaryColor.withOpacity(0.1),
            destinations: menus.map((menu) {
              return NavigationDestination(
                icon: Icon(menu.icon, color: AppColors.primaryTextColorGrey),
                selectedIcon: Icon(
                  menu.activeIcon,
                  color: AppColors.primaryColor,
                ),
                label: menu.label,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
