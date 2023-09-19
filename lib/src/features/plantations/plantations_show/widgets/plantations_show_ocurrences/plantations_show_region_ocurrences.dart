import 'package:cropi/src/features/plantations/plantations_show/bloc/bloc.dart';
import 'package:cropi/src/features/plantations/plantations_show/widgets/plantations_show_ocurrences/plantations_show_ocurrence_add.dart';
import 'package:cropi/src/features/plantations/plantations_show/widgets/plantations_show_ocurrences/plantations_show_ocurrence_card.dart';
import 'package:cropi/src/models/models.dart';
import 'package:flutter/material.dart';

class PlantationsShowPlantationOcurrences extends StatefulWidget {
  const PlantationsShowPlantationOcurrences({
    required this.ocurrences,
    super.key,
  });

  final List<Ocurrence> ocurrences;

  @override
  State<PlantationsShowPlantationOcurrences> createState() =>
      _PlantationsShowPlantationOcurrencesState();
}

class _PlantationsShowPlantationOcurrencesState
    extends State<PlantationsShowPlantationOcurrences> {
  @override
  Widget build(BuildContext context) {
    var pathogenics = context.read<PlantationsShowBloc>().state.pathogenics!;

    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
      child: Stack(
        children: [
          widget.ocurrences.isNotEmpty
              ? ListView.builder(
                  itemCount: widget.ocurrences.length,
                  itemBuilder: (context, index) {
                    var ocurrence = widget.ocurrences[index];
                    return PlantationsShowOcurrenceCard(
                      ocurrence: ocurrence,
                    );
                  },
                )
              : const Center(
                  child: Text('Não há ocorrencias cadastradas'),
                ),
          Positioned(
              bottom: 30,
              right: 0,
              child: FloatingActionButton(
                  onPressed: () async {
                    Ocurrence? ocurrence =
                        await showModalBottomSheet<Ocurrence>(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return PlantationShowOcurrenceAdd(
                                pathogenics: pathogenics,
                              );
                            });

                    if (ocurrence != null) {
                      // ignore: use_build_context_synchronously
                      context.read<PlantationsShowBloc>().add(
                          AddPlantationOcurrenceEvent(ocurrence: ocurrence));
                    }
                  },
                  child: const Icon(Icons.add)))
        ],
      ),
    );
  }
}
