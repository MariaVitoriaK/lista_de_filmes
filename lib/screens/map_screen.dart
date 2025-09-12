import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart' as gmaps;
import 'dart:ui' as ui;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late gmaps.GMap _map;

  @override
  void initState() {
    super.initState();
    // Registra a view para o mapa
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('mapElement', (int viewId) {
      final elem = gmaps.GMap(
        gmaps.document.createElement('div'),
        gmaps.MapOptions()
          ..center =
              gmaps.LatLng(-28.232667, -52.381083) // UPF
          ..zoom = 15,
      );
      _map = elem;
      return elem.div!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mapa")),
      body: const HtmlElementView(viewType: 'mapElement'),
    );
  }
}
