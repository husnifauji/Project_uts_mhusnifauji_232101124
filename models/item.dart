class Item {
  final String name;
  final String imagePath;
  final int price;
  final String description;   // ← Tambahkan ini
  bool isFavorite;

  Item({
    required this.name,
    required this.imagePath,
    required this.price,
    required this.description, // ← Tambahkan ini
    this.isFavorite = false,
  });
}
