import 'package:flutter/material.dart';

class RutasPantalla extends StatelessWidget {
  const RutasPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rutas'),
      ),
      body: const Center(
        child: Text('Aquí van las rutas disponibles.'),
      ),
    );
  }
}
