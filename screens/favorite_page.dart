import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/item.dart';

class FavoritePage extends StatelessWidget {
  final List<Item> items;

  const FavoritePage({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final favoriteItems = items.where((item) => item.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite"),
        backgroundColor: Colors.white.withOpacity(0.2),
        elevation: 0,
      ),

      // ⭐ DI SINI BACKGROUND DITAMBAHKAN
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/shoe_i.jpeg"), 
              ),
            ),
          ),

          // Efek blur
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              color: Colors.white.withOpacity(0.1),
            ),
          ),

          // ⭐ Konten Favorite (tidak diubah)
          favoriteItems.isEmpty
              ? const Center(
                  child: Text(
                    "Belum ada produk favorite",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                )
              : ListView.builder(
                  itemCount: favoriteItems.length,
                  itemBuilder: (context, index) {
                    final item = favoriteItems[index];

                    return ListTile(
                      leading: Image.asset(
                        item.imagePath,
                        width: 50,
                        height: 50,
                      ),
                      title: Text(
                        item.name,
                        style: const TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                        "Rp ${item.price}",
                        style: const TextStyle(color: Colors.black54),
                      ),
                      trailing:
                          const Icon(Icons.favorite, color: Colors.red),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
