import 'package:flutter/material.dart';

class HorariosPantalla extends StatelessWidget {
  const HorariosPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Horarios')),
      body: const Center(child: Text('Aquí van los horarios')),
    );
  }
}
