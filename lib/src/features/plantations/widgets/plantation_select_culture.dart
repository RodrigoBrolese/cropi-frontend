import 'package:cropi/src/models/culture.dart';
import 'package:cropi/src/widgets/atom/modal_bar.dart';
import 'package:flutter/material.dart';

class PlantationSelectCulture extends StatelessWidget {
  const PlantationSelectCulture({required this.cultures, super.key});

  final List<Culture> cultures;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            const ModalBar(),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Selecione a cultura',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: cultures.length,
                itemBuilder: (context, index) {
                  final culture = cultures[index];

                  return ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        child: OutlinedButton(
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              culture.name,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(culture);
                          },
                        )),
                  );
                },
              ),
            ),
          ]),
        )
      ],
    );
  }
}
