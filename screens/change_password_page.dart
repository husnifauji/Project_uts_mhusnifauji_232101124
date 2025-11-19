import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  bool isOldVisible = false;
  bool isNewVisible = false;
  bool isConfirmVisible = false;

  void _changePassword() {
    final oldPass = oldPassController.text;
    final newPass = newPassController.text;
    final confirmPass = confirmPassController.text;

    if (oldPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
      _showMessage("Semua field wajib diisi!");
      return;
    }

    if (newPass != confirmPass) {
      _showMessage("Password baru dan konfirmasi tidak sama!");
      return;
    }

    // Simulasi update password
    _showMessage("Password berhasil diubah!");
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyMedium!.color;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ubah Password",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _passwordField(
              label: "Password Lama",
              controller: oldPassController,
              isVisible: isOldVisible,
              onToggle: () => setState(() => isOldVisible = !isOldVisible),
            ),

            const SizedBox(height: 20),

            _passwordField(
              label: "Password Baru",
              controller: newPassController,
              isVisible: isNewVisible,
              onToggle: () => setState(() => isNewVisible = !isNewVisible),
            ),

            const SizedBox(height: 20),

            _passwordField(
              label: "Konfirmasi Password Baru",
              controller: confirmPassController,
              isVisible: isConfirmVisible,
              onToggle: () =>
                  setState(() => isConfirmVisible = !isConfirmVisible),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: _changePassword,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                "Simpan",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _passwordField({
    required String label,
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback onToggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: !isVisible,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: onToggle,
        ),
      ),
    );
  }
}
