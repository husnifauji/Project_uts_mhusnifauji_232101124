import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkMode = false;
  bool notification = true;
  String language = "Indonesia";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Pengaturan",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // MODE GELAP
          SwitchListTile(
            title: const Text("Mode Gelap"),
            subtitle: const Text("Aktifkan tema gelap"),
            value: darkMode,
            onChanged: (value) {
              setState(() {
                darkMode = value;
              });
            },
          ),

          // NOTIFIKASI
          SwitchListTile(
            title: const Text("Notifikasi"),
            subtitle: const Text("Terima pemberitahuan dari aplikasi"),
            value: notification,
            onChanged: (value) {
              setState(() {
                notification = value;
              });
            },
          ),

          // BAHASA
          ListTile(
            title: const Text("Bahasa"),
            subtitle: Text(language),
            trailing: DropdownButton<String>(
              value: language,
              underline: Container(),
              items: const [
                DropdownMenuItem(value: "Indonesia", child: Text("Indonesia")),
                DropdownMenuItem(value: "English", child: Text("English")),
              ],
              onChanged: (value) {
                setState(() {
                  language = value!;
                });
              },
            ),
          ),

          const SizedBox(height: 20),

          // TENTANG APLIKASI
          const Text(
            "Tentang Aplikasi",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),

          const SizedBox(height: 10),

          Card(
            child: ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text(" Shoes_App"),
              subtitle: const Text("Version 1.0.0"),
            ),
          ),
        ],
      ),
    );
  }
}
