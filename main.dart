// lib/main.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// IMPORT WAJIB
import 'theme_provider.dart';
import 'models/item.dart';
import 'widgets/item_card.dart';
import 'screens/detail_page.dart';
import 'screens/profile_page.dart';
import 'screens/login_page.dart'; // ⬅ Tambah login
import 'screens/help_page.dart';   // opsional jika dibutuhkan

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Shoes_App",

      theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),

      // ⭐ MULAI DARI LOGIN
      initialRoute: "/login",

      routes: {
        "/login": (context) => const LoginPage(),
        "/home": (context) => const HomePage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  int _currentIndex = 0;
  String searchQuery = "";

  // DAFTAR PRODUK
  final List<Item> items = [
    Item(
      name: "adidas Japan sneaker",
      imagePath: "assets/images/shoe1.png",
      price: 350000,
      description: "Sepatu Adidas Japan dengan desain modern dan nyaman dipakai.",
    ),
    Item(
      name: "Spezial noire",
      imagePath: "assets/images/shoe2.png",
      price: 420000,
      description: "Adidas Spezial Noire cocok untuk gaya casual dan streetwear.",
    ),
    Item(
      name: "Adidas Black",
      imagePath: "assets/images/shoe3.png",
      price: 380000,
      description: "Sepatu Adidas Black, ringan dan nyaman digunakan.",
    ),
    Item(
      name: "Adidas women",
      imagePath: "assets/images/shoe4.png",
      price: 450000,
      description: "Sepatu Adidas women, warna kuning cerah untuk aktivitas sehari-hari.",
    ),
  ];

  final List<Item> cartItems = [];

  void addToCart(Item item) {
    setState(() {
      cartItems.add(item);
    });
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ===============================
  // HALAMAN HOME
  // ===============================
  Widget _homePage() {
    final filteredItems = items
        .where((item) =>
            item.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Stack(
      children: [
        // Background
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/shoe_i.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Blur overlay
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              color: Colors.white.withOpacity(0.12),
            ),
          ),
        ),

        SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      const Text(
                        "Best Shoes Collection",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => setState(() => _currentIndex = 2),
                        icon: const Icon(Icons.shopping_cart_outlined),
                      ),
                      if (cartItems.isNotEmpty)
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.red,
                          child: Text(
                            cartItems.length.toString(),
                            style: const TextStyle(
                                fontSize: 11, color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ),

                // SEARCH
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: TextField(
                    onChanged: (value) => setState(() {
                      searchQuery = value;
                    }),
                    decoration: InputDecoration(
                      hintText: "Cari sepatu...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.85),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // GRID
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      itemCount: filteredItems.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.72,
                      ),
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        return ItemCard(
                          item: item,
                          onFavoriteToggle: () => setState(() {}),
                          onAddToCart: addToCart,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ===============================
  // FAVORITE
  // ===============================
  Widget _favoritePage() {
    final favoriteItems = items.where((i) => i.isFavorite).toList();

    if (favoriteItems.isEmpty) {
      return const Center(
        child: Text("Belum ada favorite", style: TextStyle(fontSize: 18)),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: favoriteItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        return ItemCard(
          item: favoriteItems[index],
          onFavoriteToggle: () => setState(() {}),
          onAddToCart: addToCart,
        );
      },
    );
  }

  // ===============================
  // CART
  // ===============================
  Widget _cartPage() {
    if (cartItems.isEmpty) {
      return const Center(
          child: Text("Keranjang kosong", style: TextStyle(fontSize: 18)));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final it = cartItems[index];
        return Card(
          child: ListTile(
            leading: Image.asset(it.imagePath,
                width: 50, height: 50, fit: BoxFit.cover),
            title: Text(it.name),
            subtitle: Text("Rp ${it.price}"),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => setState(() => cartItems.removeAt(index)),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailPage(
                    item: it,
                    onAddToCart: addToCart,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // ===============================
  // PROFILE
  // ===============================
  Widget _profilePage() {
    return const ProfilePage();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _homePage(),
      _favoritePage(),
      _cartPage(),
      _profilePage(),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: "Favorite"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: "Cart"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }
}
