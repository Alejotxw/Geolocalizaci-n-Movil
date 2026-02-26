import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Geolocalizador Flutter',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final Location _locationCustom = Location();
  
  // Posición inicial (Ecuador o coordenadas 0,0 mientras carga)
  static const LatLng _center = LatLng(-0.180653, -78.467834); 
  
  Marker? _userMarker;

  @override
  void initState() {
    super.initState();
    // Llamamos a la lógica de permisos apenas abre la app
    _checkPermissions();
  }

  // 1. MUESTRA CÓMO LA APP PIDE PERMISOS
  Future<void> _checkPermissions() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Verificar si el GPS está encendido
    serviceEnabled = await _locationCustom.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationCustom.requestService();
      if (!serviceEnabled) return;
    }

    // Solicitar permiso de ubicación al usuario
    permissionGranted = await _locationCustom.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationCustom.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    // Si ya tiene permisos, obtenemos la ubicación real
    _animateToUser();
  }

  // 2. MUESTRA CÓMO CENTRA EL MAPA Y CREA EL MARCADOR
  Future<void> _animateToUser() async {
    final posData = await _locationCustom.getLocation();
    final LatLng userLatLng = LatLng(posData.latitude!, posData.longitude!);

    setState(() {
      _userMarker = Marker(
        markerId: const MarkerId('current_location'),
        position: userLatLng,
        infoWindow: const InfoWindow(title: '¡Aquí estoy!', snippet: 'Ubicación actual'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
    });

    // Movimiento de cámara corregido (CameraUpdate)
    mapController.animateCamera(
      CameraUpdate.newLatLngZoom(userLatLng, 16.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Geolocalizador'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: GoogleMap(
        onMapCreated: (controller) => mapController = controller,
        initialCameraPosition: const CameraPosition(
          target: _center,
          zoom: 12.0,
        ),
        markers: _userMarker != null ? {_userMarker!} : {},
        myLocationEnabled: true, // Muestra el punto azul de Google
        myLocationButtonEnabled: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animateToUser,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}