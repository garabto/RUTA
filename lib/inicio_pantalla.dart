import 'package:flutter/material.dart';
import 'inicio_sesion.dart'; // Importa la pantalla de inicio de sesión

class InicioPantalla extends StatelessWidget {
  final String usuario; // Recibe el usuario autenticado

  const InicioPantalla({Key? key, required this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inicio"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Regresa a la pantalla de inicio de sesión
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const InicioSesion()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "¡Bienvenido, $usuario!",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Acción del botón (puede ser ver rutas, mapa, etc.)
              },
              child: const Text("Explorar rutas"),
            ),
          ],
        ),
      ),
    );
  }
}
