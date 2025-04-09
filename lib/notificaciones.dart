import 'package:flutter/material.dart';

class NotificacionesPantalla extends StatelessWidget {
  const NotificacionesPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
      ),
      body: const Center(
        child: Text('Aquí van las notificaciones.'),
      ),
    );
  }
}
