import 'package:flutter/material.dart';
import '../../ads/pages/ad_detail.dart';
import '../models/search_model.dart'; // Pastikan path ke AdModel Anda benar

class AdCardWidget extends StatelessWidget {
  final AdModel ad;

  const AdCardWidget({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // ➡️ Menambahkan aksi navigasi saat kartu di-klik oleh user
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AdDetailPage(id: ad.id), // Mengirimkan id iklan
          ),
        );
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dummy Image placeholder
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.image, color: Colors.grey, size: 36),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ad.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Rp ${ad.price} / ${ad.priceType}",
                      style: const TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 12,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          ad.location,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 11,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: ad.condition == 'new'
                                ? Colors.green[50]
                                : Colors.amber[50],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            ad.condition == 'new' ? 'Baru' : 'Bekas',
                            style: TextStyle(
                              fontSize: 10,
                              color: ad.condition == 'new'
                                  ? Colors.green[700]
                                  : Colors.amber[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
