import 'package:cropi/src/widgets/atom/modal_bar.dart';
import 'package:cropi/src/widgets/atom/primary_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlantationSelectLocation extends StatefulWidget {
  const PlantationSelectLocation({required this.userLocation, super.key});

  final LatLng userLocation;

  @override
  State<PlantationSelectLocation> createState() =>
      _PlantationSelectLocationState();
}

class _PlantationSelectLocationState extends State<PlantationSelectLocation> {
  Marker? _marker;

  @override
  void initState() {
    _marker = Marker(
      markerId: const MarkerId('1'),
      position: widget.userLocation,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        primary: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          margin: const EdgeInsets.all(16),
          color: Theme.of(context).colorScheme.surface,
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            const ModalBar(),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Selecione a localização da plantação',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
                child: GoogleMap(
              mapType: MapType.satellite,
              markers: {_marker!},
              initialCameraPosition:
                  CameraPosition(target: widget.userLocation, zoom: 16),
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
                ),
              },
              onTap: (argument) {
                setState(() {
                  _marker = Marker(
                    markerId: const MarkerId('1'),
                    position: argument,
                  );
                });
              },
            )),
            const SizedBox(height: 16),
            PrimaryButton(
              text: 'Selecionar',
              onPressed: () {
                Navigator.of(context).pop(LatLng(
                    _marker!.position.latitude, _marker!.position.longitude));
              },
            ),
            const SizedBox(
              height: 16,
            )
          ]),
        ),
      ),
    );
  }
}
