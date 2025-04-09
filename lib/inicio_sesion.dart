import 'package:flutter/material.dart';
import 'registro.dart'; // Importa la pantalla de registro
import 'inicio_pantalla.dart'; // Importa la pantalla principal
import 'dart:convert'; // Para convertir la respuesta en JSON
import 'package:http/http.dart' as http; // Para realizar solicitudes HTTP

class InicioSesion extends StatefulWidget {
  const InicioSesion({super.key});

  @override
  _InicioSesionState createState() => _InicioSesionState();
}

class _InicioSesionState extends State<InicioSesion> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isLoading = false;

  void _iniciarSesion() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa tus credenciales')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    bool autenticado = await verificarCredenciales(email, password);

    setState(() {
      isLoading = false;
    });

    if (autenticado) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => InicioPantalla(usuario: email), // Pasa el usuario a la pantalla principal
        ),
      );
    } else {
      // Si las credenciales son incorrectas, muestra un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario o contraseña incorrectos')),
      );
    }
  }

  Future<bool> verificarCredenciales(String email, String password) async {
   //para emular en Android
   // final url = Uri.parse('http://10.0.2.2:3000/login'); // URL de tu servidor backend (si es un emulador de Android)
     //emular en la web
      final url = Uri.parse('http://localhost:3000/login'); // Reemplaza con tu IP local

    // Hacer la solicitud POST
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'contrasena': password}),
    );

    // Verificar si la respuesta es exitosa (código de estado 200)
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Si la respuesta tiene éxito, se devuelve true
      return data['success'];
    } else {
      // Si la respuesta no es exitosa, devuelve false
      final errorData = json.decode(response.body);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorData['message'] ?? 'Error desconocido')),
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(21, 105, 126, 1), // Fondo azul
            border: Border.all(
              color: Colors.white, // Borde blanco
              width: 20.0, // Ancho del borde
            ),
          ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Iniciar Sesión",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/login.png',
                  width: 100, // Ajusta el tamaño de la imagen
                  height: 100,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [  
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: "Correo Electrónico",
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: "Contraseña",
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock, color: Colors.black),
                        suffixIcon: IconButton(
                          color: Colors.black,
                          icon: Icon(
                            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                        const SizedBox(height: 20),
                      isLoading
                      ? const CircularProgressIndicator() // Muestra un indicador de carga mientras se realiza la solicitud
                      : ElevatedButton(
                          onPressed: _iniciarSesion,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                          child: const Text("Iniciar Sesión", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 15),
                        TextButton(
                          onPressed: () {
                            // Navega a la pantalla de registro
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Registro()),
                            );
                          },
                        child: const Text(
                          "¿No tienes una cuenta? Regístrate aquí",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//nos falta agregar lo del olvido de la contraseña