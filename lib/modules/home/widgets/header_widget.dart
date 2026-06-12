import 'package:flutter/material.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import '../../../core/constants/app_color.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Baris Atas: Profil Pengguna & Icon Notifikasi
          Row(
            children: [
              // Avatar Pengguna
              Container(
                width: 44, // Ukuran total kotak logo (Lebar)
                height: 44, // Ukuran total kotak logo (Tinggi)
                padding: const EdgeInsets.all(
                  8,
                ), // <--- PADDING DI SINI: Memberi jarak aman agar logo tidak mentok/terpotong
                decoration: BoxDecoration(
                  color: AppColors
                      .primaryColor, // Background kotak logo (bisa diganti sesuai kebutuhan)
                  borderRadius: BorderRadius.circular(
                    30,
                  ), // Menglengkungkan sudut kotak
                ),
                child: Image.asset(
                  'assets/images/logo.png', // <--- PATH ASSET LOGOMU
                  fit: BoxFit
                      .contain, // <--- Memaksa gambar mengecil secara proporsional di dalam kotak tanpa terpotong
                ),
              ),
              const SizedBox(width: 12),
              // Nama & Greeting
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selamat Datang,",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primaryTextColorGrey,
                      ),
                    ),
                    const Text(
                      "Toko Jualan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              // Tombol Notifikasi & Keranjang
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  MingCuteIcons.mgc_notification_line,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  MingCuteIcons.mgc_shopping_bag_1_fill,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
