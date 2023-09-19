import 'package:cropi/src/features/plantations/plantations_show/widgets/plantations_show_ocurrences/plantations_show_ocurrence_card.dart';
import 'package:cropi/src/models/models.dart';
import 'package:flutter/material.dart';

class PlantationsShowRegionOcurrences extends StatelessWidget {
  const PlantationsShowRegionOcurrences({
    required this.ocurrences,
    super.key,
  });

  final List<Ocurrence> ocurrences;

  @override
  Widget build(BuildContext context) {
    return ocurrences.isEmpty
        ? const Center(child: Text('Não há ocorrencias proximas'))
        : ListView.builder(
            itemCount: ocurrences.length,
            itemBuilder: (context, index) {
              var ocurrence = ocurrences[index];
              return PlantationsShowOcurrenceCard(
                ocurrence: ocurrence,
              );
            },
          );
  }
}
