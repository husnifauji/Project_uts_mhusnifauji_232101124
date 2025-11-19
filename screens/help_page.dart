import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyMedium!.color;
    final cardColor = Theme.of(context).cardColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bantuan",
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: cardColor,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _helpTile(
            context,
            Icons.info_outline,
            "Tentang Aplikasi",
            "Informasi singkat mengenai aplikasi ini.",
          ),

          _helpTile(
            context,
            Icons.book_outlined,
            "Panduan Penggunaan",
            "Cara menggunakan fitur-fitur pada aplikasi.",
          ),

          _helpTile(
            context,
            Icons.call_outlined,
            "Kontak Bantuan",
            "Hubungi kami jika mengalami kendala.",
          ),

          _helpTile(
            context,
            Icons.privacy_tip_outlined,
            "Kebijakan Privasi",
            "Informasi tentang privasi dan data pengguna.",
          ),
        ],
      ),
    );
  }

  // CARD INFO
  Widget _helpTile(
      BuildContext context,
      IconData icon,
      String title,
      String subtitle,
      ) {
    return Card(
      elevation: 2,
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(icon, size: 30, color: Theme.of(context).iconTheme.color),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).textTheme.bodyMedium!.color,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
