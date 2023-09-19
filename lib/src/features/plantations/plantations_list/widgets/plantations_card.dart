import 'package:cropi/src/models/plantation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class PlantationsCard extends StatelessWidget {
  const PlantationsCard({required this.plantation, this.onTap, super.key});

  final Plantation plantation;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap as void Function()?,
        splashColor: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              title: Text(plantation.alias),
              subtitle: Text(plantation.culture.name),
              trailing: const Icon(Icons.chevron_right),
            ),
            plantation.hasOcurrences
                ? Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red),
                      color: Colors.red.withOpacity(.1),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.warning, color: Colors.red),
                        SizedBox(width: 8),
                        Text(
                          'Condições favoraveis para doenças',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: ListBody(
                children: [
                  Text(
                      'Estação Meteorológica: ${plantation.station.city} - ${plantation.station.uf}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Area: ${plantation.area}'),
                      Text(
                          'Data de plantio: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(plantation.plantingDate))}'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: GoogleMap(
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: false,
                        rotateGesturesEnabled: false,
                        scrollGesturesEnabled: false,
                        tiltGesturesEnabled: false,
                        myLocationButtonEnabled: false,
                        mapType: MapType.satellite,
                        markers: {
                          Marker(
                            markerId: MarkerId(plantation.id.toString()),
                            position: LatLng(
                                plantation.latitude, plantation.longitude),
                          ),
                        },
                        initialCameraPosition: CameraPosition(
                          target:
                              LatLng(plantation.latitude, plantation.longitude),
                          zoom: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
