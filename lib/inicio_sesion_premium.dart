import 'package:flutter/material.dart';

class InicioSesionPremiumPantalla extends StatelessWidget {
  const InicioSesionPremiumPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión Premium'),
      ),
      body: const Center(
        child: Text('Formulario de inicio de sesión premium.'),
      ),
    );
  }
}
