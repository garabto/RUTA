import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'inicio_sesion.dart';
import 'notificaciones.dart';
import 'rutas.dart';
import 'horarios.dart';
import 'inicio_sesion_premium.dart';
import 'registro_premium.dart';


class InicioPantalla extends StatefulWidget {
  final String usuario;

  const InicioPantalla({super.key, required this.usuario});

  @override
  _InicioPantallaState createState() => _InicioPantallaState();
}

class _InicioPantallaState extends State<InicioPantalla> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final LatLng ubicacionPorDefecto = LatLng(20.079609, -98.733201);
  LocationData? currentLocation;
  Location location = Location();

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    final loc = await location.getLocation();
    setState(() {
      currentLocation = loc;
    });
  }

  @override
  Widget build(BuildContext context) {
    final LatLng ubicacionInicial = currentLocation != null
        ? LatLng(currentLocation!.latitude!, currentLocation!.longitude!)
        : ubicacionPorDefecto;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Inicio"),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _getLocation,
            tooltip: "Actualizar ubicación",
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => print("Ir a la pantalla de usuario"),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.usuario),
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
            _buildNavButton('Notificaciones'),
            _buildNavButton('Rutas'),
            _buildNavButton('Horarios'),
            _buildNavButton('Servicio Premium'),
            _buildNavButton('Información/Contactos'),
            Divider(),
            _buildNavButton('Cerrar Sesión'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              height: 600,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blueAccent),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FlutterMap(
                  options: MapOptions(
                    center: ubicacionInicial,
                    zoom: 15.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: ubicacionInicial,
                          width: 40,
                          height: 40,
                          child: Icon(Icons.location_pin, color: Colors.red, size: 40),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // Aquí podrías poner más cosas, como un botón o datos extra
          ],
        ),
      ),

    );
  }

  Widget _buildNavButton(String label) {
    return ListTile(
      title: Text(label),
      onTap: () {
        if (label == 'Cerrar Sesión') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const InicioSesion()),
          );
        } else if (label == 'Notificaciones') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotificacionesPantalla()),
        );
      } else if (label == 'Rutas') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RutasPantalla()),
        );
      } else if (label == 'Horarios') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HorariosPantalla()),
        );
      } else if (label == 'Servicio Premium') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InicioSesionPremiumPantalla()),
        );
      } else if (label == 'Información/Contactos') {
        /*Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InfoContactosPantalla()),
        );*/
        print('Navegar a $label');
      } else {
        print('Navegar a $label');
      }
    },
    );
  }
}
