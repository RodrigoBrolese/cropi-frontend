import 'package:cropi/src/models/models.dart';
import 'package:cropi/src/services/api/api_client.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class PlantationsShowOcurrenceCard extends StatelessWidget {
  const PlantationsShowOcurrenceCard({
    required this.ocurrence,
    super.key,
  });

  final Ocurrence ocurrence;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(ocurrence.pathogenic.name),
              subtitle: Text(ocurrence.pathogenic.scientificName),
              trailing: Text(DateFormat('dd/MM/yyyy')
                  .format(DateTime.parse(ocurrence.occurrenceDate))),
            ),
            ocurrence.image != null
                ? Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    height: 300,
                    child: Image.network(
                        GetIt.I<ApiClient>().fullUrl + ocurrence.image!),
                  )
                : const SizedBox(),
          ]),
    );
  }
}
