import 'package:cropi/src/models/plantation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class PlantationsShowInfo extends StatefulWidget {
  const PlantationsShowInfo({required this.plantation, super.key});

  final Plantation plantation;

  @override
  State<PlantationsShowInfo> createState() => _PlantationsShowInfoState();
}

class _PlantationsShowInfoState extends State<PlantationsShowInfo> {
  @override
  Widget build(BuildContext context) {
    var plantation = widget.plantation;

    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
      child: ListView(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            title: Text(plantation.alias),
            subtitle: Text(
                '${plantation.culture.name} (${plantation.culture.scientificName})'),
          ),
          plantation.hasOcurrences
              ? const _PlantationsShowInfoProducts()
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
                    Text('Area: ${plantation.area}ha'),
                    Text(
                        'Data de plantio: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(plantation.plantingDate))}'),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 400,
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
                          position:
                              LatLng(plantation.latitude, plantation.longitude),
                        ),
                      },
                      initialCameraPosition: CameraPosition(
                        target:
                            LatLng(plantation.latitude, plantation.longitude),
                        zoom: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlantationsShowInfoProducts extends StatelessWidget {
  const _PlantationsShowInfoProducts();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red),
        color: Colors.red.withOpacity(.1),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning, color: Colors.red),
              SizedBox(width: 8),
              Text(
                'Condições favoraveis para doenças',
                style: TextStyle(color: Colors.red),
              )
            ],
          ),
          SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Produtos recomendados:",
                  style: TextStyle(color: Colors.red)),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.red,
                        size: 12,
                      ),
                      SizedBox(width: 8),
                      Text("Tebuconazol (triazol)",
                          style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.red,
                        size: 12,
                      ),
                      SizedBox(width: 8),
                      Text("Azoxistrobina (estrobilurina)",
                          style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.red,
                        size: 12,
                      ),
                      SizedBox(width: 8),
                      Text("Difenoconazol (triazol)",
                          style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
