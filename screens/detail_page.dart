import 'package:flutter/material.dart';
import '../models/item.dart';

class DetailPage extends StatelessWidget {
  final Item item;
  final Function(Item)? onAddToCart;

  const DetailPage({
    super.key,
    required this.item,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: () {
              if (onAddToCart != null) {
                onAddToCart!(item);
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${item.name} ditambahkan ke keranjang"),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          )
        ],
      ),

      body: Column(
        children: [
          const SizedBox(height: 20),

          // GAMBAR
          Hero(
            tag: item.name,
            child: Image.asset(
              item.imagePath,
              height: 260,
            ),
          ),

          const SizedBox(height: 20),

          // NAMA PRODUK
          Text(
            item.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          // HARGA
          Text(
            "Rp ${item.price}",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.blue,
            ),
          ),

          const SizedBox(height: 20),

          // DESKRIPSI PRODUK
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              item.description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),

          const Spacer(),

          // BUTTON BUY NOW
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (onAddToCart != null) {
                        onAddToCart!(item);
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text("${item.name} ditambahkan ke keranjang"),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(14),
                    ),
                    child: const Text("Beli Sekarang"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
