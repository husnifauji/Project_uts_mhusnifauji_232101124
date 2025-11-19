import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import 'settings_page.dart';
import 'change_password_page.dart';
import 'help_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.bodyMedium!.color;
    final cardColor = Theme.of(context).cardColor;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: cardColor,
        elevation: 0,
        title: Text(
          "Profil",
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // FOTO PROFIL
            CircleAvatar(
              radius: 60,
              backgroundImage: const AssetImage("assets/images/user.jpg"),
              backgroundColor: Colors.grey.shade300,
            ),

            const SizedBox(height: 15),

            Text(
              "Admin",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor),
            ),
            Text(
              "admin@gmail.com",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            ),

            const SizedBox(height: 25),

            // MENU
            _menuTile(
              context,
              Icons.settings,
              "Pengaturan",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),

            _menuTile(
              context,
              Icons.lock_outline,
              "Ubah Password",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChangePasswordPage()),
                );
              },
            ),

            _menuTile(
              context,
              Icons.help_outline,
              "Bantuan",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpPage()),
                );
              },
            ),

            // 🔥 LOGOUT DENGAN DIALOG KONFIRMASI
            _menuTile(context, Icons.logout, "Logout", () {
              _showLogoutDialog(context);
            }),
          ],
        ),
      ),
    );
  }

  // LIST TILE MENU
  Widget _menuTile(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Theme.of(context).cardColor,
      child: ListTile(
        leading: Icon(icon, size: 28, color: Theme.of(context).iconTheme.color),
        title: Text(
          title,
          style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Theme.of(context).iconTheme.color,
        ),
        onTap: onTap,
      ),
    );
  }

  // ⚠️ DIALOG KONFIRMASI LOGOUT
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Konfirmasi Logout"),
          content: const Text("Apakah Anda yakin ingin keluar dari aplikasi?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx); // tutup dialog

                // kembali ke halaman utama
                Navigator.pushReplacementNamed(context, "/");
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}
