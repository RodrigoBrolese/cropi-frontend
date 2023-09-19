import 'dart:io';

import 'package:cropi/src/models/models.dart';
import 'package:cropi/src/widgets/atom/alert_card.dart';
import 'package:cropi/src/widgets/atom/modal_bar.dart';
import 'package:cropi/src/widgets/atom/primary_button.dart';
import 'package:cropi/src/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class PlantationShowOcurrenceAdd extends StatefulWidget {
  const PlantationShowOcurrenceAdd({
    required this.pathogenics,
    super.key,
  });

  final List<Pathogenic> pathogenics;

  @override
  State<PlantationShowOcurrenceAdd> createState() =>
      _PlantationShowOcurrenceAddState();
}

class _PlantationShowOcurrenceAddState
    extends State<PlantationShowOcurrenceAdd> {
  final _formKey = GlobalKey<FormState>();

  final _dateController = TextEditingController();
  // final _diseaseController = TextEditingController();

  XFile? image;

  bool imageMustSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Form(
          key: _formKey,
          child: Column(children: [
            const ModalBar(),
            Expanded(
                child: Column(
              children: [
                imageMustSelected
                    ? AlertCard(
                        message: 'Selecione uma imagem',
                        color: Colors.red.withOpacity(.7),
                        textColor: Colors.white,
                        margin: const EdgeInsets.only(bottom: 15),
                      )
                    : const SizedBox(),
                Input(
                  label: 'Data',
                  type: TextInputType.datetime,
                  controller: _dateController,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe a data';
                    }
                  },
                  onTap: () async {
                    final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now());

                    if (date != null) {
                      _dateController.text =
                          DateFormat('dd/MM/yyyy').format(date);
                    }
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Doença',
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Selecione uma doença';
                    }

                    return null;
                  },
                  items: widget.pathogenics
                      .map((pathogenic) => DropdownMenuItem(
                            value: pathogenic.id,
                            child: Text(pathogenic.name),
                          ))
                      .toList(),
                  onChanged: (value) {},
                ),
                image != null
                    ? Container(
                        padding: const EdgeInsets.only(top: 5),
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: kIsWeb
                            ? Image.network(image!.path)
                            : Image(image: FileImage(File(image!.path))),
                      )
                    : const SizedBox(),
                const SizedBox(height: 10),
                //input file
                !kIsWeb
                    ? OutlinedButton(
                        onPressed: () async {
                          final picker = ImagePicker();
                          XFile? selectedImage = await picker.pickImage(
                              source: ImageSource.gallery);

                          if (selectedImage == null) {
                            setState(() {
                              imageMustSelected = true;
                            });
                          }

                          setState(() {
                            image = selectedImage;
                            imageMustSelected = false;
                          });
                        },
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.add_a_photo),
                                const SizedBox(width: 5),
                                Text(image == null
                                    ? 'Adicionar imagem'
                                    : 'Alterar imagem')
                              ],
                            )),
                      )
                    : const SizedBox(),
              ],
            )),
            PrimaryButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }

                if (image == null && !kIsWeb) {
                  setState(() {
                    imageMustSelected = true;
                  });
                  return;
                }

                Ocurrence ocurrence = Ocurrence(
                  id: '',
                  pathogenic: widget.pathogenics[0],
                  occurrenceDate: DateFormat('yyyy-MM-dd').format(
                      DateFormat('dd/MM/yyyy').parse(_dateController.text)),
                  createDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                  image: image?.path,
                  updateDate: '',
                );

                Navigator.of(context).pop(ocurrence);
              },
              text: 'Adicionar',
            ),
            const SizedBox(height: 10),
          ])),
    );
  }
}
