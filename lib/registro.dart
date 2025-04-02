import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoPaternoController = TextEditingController();
  final TextEditingController apellidoMaternoController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController calleController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController coloniaController = TextEditingController();
  final TextEditingController codigoPostalController = TextEditingController();

  // Función para registrar al usuario en el backend
  Future<void> registerUser() async {
    final url = 'http://192.168.0.103:3000/register'; // Cambia la IP si es necesario

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': emailController.text,
        'contrasena': passwordController.text,
        'nombre': nombreController.text,
        'apellidoPaterno': apellidoPaternoController.text,
        'apellidoMaterno': apellidoMaternoController.text,
        'telefono': telefonoController.text,
        'calle': calleController.text,
        'numero': numeroController.text,
        'colonia': coloniaController.text,
        'codigoPostal': codigoPostalController.text,
      }),
    );

    if (response.statusCode == 201) {
      // Registro exitoso
      print('Usuario registrado correctamente');
      // Redirigir al usuario a la pantalla de inicio de sesión
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      // Error al registrar
      final errorMessage = json.decode(response.body);
      print('Error al registrar usuario: ${errorMessage['error'] ?? errorMessage['message']}');
    }
  }

  bool validateForm() {
    // Verificar que los campos no estén vacíos
    if (emailController.text.isEmpty || passwordController.text.isEmpty || confirmPasswordController.text.isEmpty ||
        nombreController.text.isEmpty || apellidoPaternoController.text.isEmpty || apellidoMaternoController.text.isEmpty ||
        telefonoController.text.isEmpty || calleController.text.isEmpty || numeroController.text.isEmpty ||
        coloniaController.text.isEmpty || codigoPostalController.text.isEmpty) {
      showError("Todos los campos son obligatorios.");
      return false;
    }

    // Validación de correo electrónico
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(emailController.text)) {
      showError("Por favor ingrese un correo electrónico válido.");
      return false;
    }

    // Validación de teléfono (debe tener 10 dígitos)
    final telefonoRegex = RegExp(r'^[0-9]{10}$');
    if (!telefonoRegex.hasMatch(telefonoController.text)) {
      showError("El teléfono debe contener 10 dígitos.");
      return false;
    }

    // Validación de la contraseña (debe tener entre 8 y 12 caracteres, al menos una mayúscula y una minúscula)
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z]).{8,12}$');
    if (!passwordRegex.hasMatch(passwordController.text)) {
      showError("La contraseña debe tener entre 8 y 12 caracteres, e incluir al menos una letra mayúscula y una minúscula.");
      return false;
    }

    // Verificar que las contraseñas coincidan
    if (passwordController.text != confirmPasswordController.text) {
      showError("Las contraseñas no coinciden.");
      return false;
    }

    // Validación de código postal (debe tener exactamente 5 dígitos numéricos)
    final codigoPostalRegex = RegExp(r'^[0-9]{5}$');
    if (!codigoPostalRegex.hasMatch(codigoPostalController.text)) {
      showError("El código postal debe tener exactamente 5 dígitos.");
      return false;
    }

    return true;
  }

  void showError(String message) {
    // Mostrar un mensaje de error en un cuadro de diálogo
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text("Cerrar"),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 197, 191, 1),
        title: const Text("Registro",
        style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container ( 
            decoration: BoxDecoration(
            color: Color.fromRGBO(240, 124, 113, 1), // Fondo rosa
            border: Border.all(
              color: Colors.white, // Borde blanco
              width: 20.0, // Ancho del borde
            ),
          ), 
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Crear Cuenta",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                    Image.asset(
                    'assets/registro.png',
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
                      // Campos de texto para los datos del usuario
                      _buildTextField(nombreController, "Nombre", Icons.person),
                      const SizedBox(height: 15),
                      _buildTextField(apellidoPaternoController, "Apellido Paterno", Icons.person),
                      const SizedBox(height: 15),
                      _buildTextField(apellidoMaternoController, "Apellido Materno", Icons.person),
                      const SizedBox(height: 15),
                      _buildTextField(telefonoController, "Teléfono", Icons.phone),
                      const SizedBox(height: 15),
                      _buildTextField(calleController, "Calle", Icons.location_on),
                      const SizedBox(height: 15),
                      _buildTextField(numeroController, "Número", Icons.home),
                      const SizedBox(height: 15),
                      _buildTextField(coloniaController, "Colonia", Icons.location_on),
                      const SizedBox(height: 15),
                      _buildTextField(codigoPostalController, "Código Postal", Icons.pin),
                      const SizedBox(height: 15),
                      _buildTextField(emailController, "Correo Electrónico", Icons.email),
                      const SizedBox(height: 15),
                      _buildTextField(passwordController, "Contraseña", Icons.lock, obscureText: true),
                      const SizedBox(height: 15),
                      _buildTextField(confirmPasswordController, "Confirmar Contraseña", Icons.lock, obscureText: true),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                        onPressed: () {
                          // Verificar que el formulario es válido antes de registrar
                          if (validateForm()) {
                            registerUser();
                          }
                        },
                        child: const Text("Registrarse", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                ],
              ),
            ),
          ),
        ),
      ),
    );      
  }

  // Función para construir los campos de texto de manera reutilizable
  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
           borderSide: const BorderSide(color: Colors.black),
        ),
        
        prefixIcon: Icon(icon, color: Colors.black),
      ),
    );
  }
}
