import 'package:flutter/material.dart';
import '../models/item.dart';
import '../screens/detail_page.dart';

class ItemCard extends StatefulWidget {
  final Item item;
  final VoidCallback onFavoriteToggle;
  final Function(Item) onAddToCart;

  const ItemCard({
    super.key,
    required this.item,
    required this.onFavoriteToggle,
    required this.onAddToCart,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 180),
      vsync: this,
      lowerBound: 0.7,
      upperBound: 1.0,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
  }

  void toggleFavorite() {
    setState(() {
      widget.item.isFavorite = !widget.item.isFavorite;
    });

    widget.onFavoriteToggle();

    _controller.forward(from: 0.7);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailPage(
              item: widget.item,
              onAddToCart: widget.onAddToCart,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // ============================
            // KONTEN PRODUK
            // ============================
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Hero(
                      tag: widget.item.name,
                      child: Image.asset(
                        widget.item.imagePath,
                        width: 160,
                        height: 160,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // NAMA PRODUK
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    widget.item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(height: 4),

                // HARGA
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Text(
                    "Rp ${widget.item.price}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            // ============================
            // FAVORITE BUTTON
            // ============================
            Positioned(
              right: 10,
              top: 10,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: GestureDetector(
                  onTap: toggleFavorite,
                  child: Icon(
                    widget.item.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: widget.item.isFavorite ? Colors.red : Colors.grey,
                    size: 28,
                  ),
                ),
              ),
            ),

            // ============================
            // CART BUTTON
            // ============================
            Positioned(
              left: 10,
              top: 10,
              child: GestureDetector(
                onTap: () {
                  widget.onAddToCart(widget.item);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${widget.item.name} ditambahkan ke keranjang"),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: const Icon(
                  Icons.add_shopping_cart,
                  size: 28,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
