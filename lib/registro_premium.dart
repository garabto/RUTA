import 'package:flutter/material.dart';

class RegistroPremiumPage extends StatelessWidget {
  const RegistroPremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro Premium'),
      ),
      body: const Center(
        child: Text('Formulario de registro premium.'),
      ),
    );
  }
}
