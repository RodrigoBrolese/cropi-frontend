import 'package:cropi/src/features/plantations/plantations_create/bloc/bloc.dart';
import 'package:cropi/src/features/plantations/plantations_create/widgets/plantations_create_success_body.dart';
import 'package:cropi/src/features/plantations/widgets/plantation_select_culture.dart';
import 'package:cropi/src/features/plantations/widgets/plantation_select_location.dart';
import 'package:cropi/src/models/culture.dart';
import 'package:cropi/src/widgets/atom/alert_card.dart';
import 'package:cropi/src/widgets/atom/primary_button.dart';
import 'package:cropi/src/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class PlantationsCreateBody extends StatefulWidget {
  const PlantationsCreateBody({super.key});

  @override
  State<PlantationsCreateBody> createState() => _PlantationsCreateBodyState();
}

class _PlantationsCreateBodyState extends State<PlantationsCreateBody> {
  final _formKey = GlobalKey<FormState>();

  GoogleMapController? mapController;
  bool _isSaving = false;

  final _plantingDateController = TextEditingController(text: '');
  final _cultureController = TextEditingController(text: '');
  final _areaController = TextEditingController(text: '');
  final _nameController = TextEditingController(text: '');

  final _cultureFocusNode = FocusNode();

  @override
  void initState() {
    var state = context.read<PlantationsCreateBloc>().state;

    _cultureController.text = state.cultureSelected?.name ?? '';
    _plantingDateController.text = state.plantingDate != null
        ? DateFormat('dd/MM/yyyy').format(state.plantingDate!)
        : '';
    _areaController.text = state.area != null ? state.area.toString() : '';
    _nameController.text = state.name ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantationsCreateBloc, PlantationsCreateState>(
        builder: (context, state) {
      if (state is PlantationsCreateLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is PlantationsCreateSuccess) {
        return const PlantationsCreateSuccessBody();
      }

      return Column(
        children: [
          state.error != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: AlertCard(
                    message: state.error!,
                    color: Theme.of(context).colorScheme.error,
                    textColor: Theme.of(context).colorScheme.onError,
                  ),
                )
              : const SizedBox(),
          Expanded(
              child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      const SizedBox(height: 5),
                      Input(
                        label: 'Nome',
                        controller: _nameController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }

                          if (value.length < 3) {
                            return 'O nome deve ter no mínimo 3 caracteres';
                          }

                          return null;
                        },
                        onChanged: (value) {
                          context
                              .read<PlantationsCreateBloc>()
                              .add(PlantationsCreateNameChanged(name: value));
                        },
                      ),
                      const SizedBox(height: 16),
                      Input(
                        label: 'Area (Em hectares)',
                        controller: _areaController,
                        type: TextInputType.number,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }

                          if (double.tryParse(value) == null) {
                            return 'Valor inválido';
                          }

                          return null;
                        },
                        onChanged: (value) {
                          context
                              .read<PlantationsCreateBloc>()
                              .add(PlantationsCreateAreaChanged(area: value));
                        },
                      ),
                      const SizedBox(height: 16),
                      Input(
                        label: 'Data de plantio',
                        type: TextInputType.datetime,
                        controller: _plantingDateController,
                        readOnly: true,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }

                          return null;
                        },
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now()
                                .subtract(const Duration(days: 365)),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );

                          if (date != null) {
                            _plantingDateController.text =
                                DateFormat('dd/MM/yyyy').format(date);
                            // ignore: use_build_context_synchronously
                            context.read<PlantationsCreateBloc>().add(
                                PlantationsCreatePlantingDateChanged(
                                    plantingDate: date));
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      Input(
                        label: 'Cultura',
                        controller: _cultureController,
                        focusNode: _cultureFocusNode,
                        type: TextInputType.none,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }

                          return null;
                        },
                        onTap: () async {
                          _cultureFocusNode.unfocus();

                          final culture = await showModalBottomSheet<Culture>(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return PlantationSelectCulture(
                                  cultures: state.cultures ?? []);
                            },
                          );

                          if (culture != null) {
                            _cultureController.text = culture.name;
                            // ignore: use_build_context_synchronously
                            context.read<PlantationsCreateBloc>().add(
                                PlantationsCreateCultureChanged(
                                    culture: culture));
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton(
                        onPressed: () async {
                          await showModalBottomSheet(
                            context: context,
                            backgroundColor:
                                Theme.of(context).colorScheme.surface,
                            enableDrag: kIsWeb ? false : true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            builder: (context) {
                              return PlantationSelectLocation(
                                userLocation: state.userPosition != null
                                    ? state.location ??
                                        LatLng(state.userPosition!.latitude,
                                            state.userPosition!.longitude)
                                    : const LatLng(0, 0),
                              );
                            },
                          ).then((value) {
                            if (value == null) {
                              return;
                            }

                            if (mapController != null) {
                              mapController!.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: value!,
                                    zoom: 18,
                                  ),
                                ),
                              );
                            }

                            context.read<PlantationsCreateBloc>().add(
                                PlantationsCreateLocationSelected(
                                    location: value));
                          });
                        },
                        child: const Text('Selecione a localização no mapa'),
                      ),
                      const SizedBox(height: 16),
                      state.location != null
                          ? SizedBox(
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
                                  onMapCreated: (controller) {
                                    setState(() {
                                      mapController = controller;
                                    });
                                  },
                                  mapType: MapType.satellite,
                                  markers: {
                                    Marker(
                                      markerId: const MarkerId('1'),
                                      position: state.location!,
                                    ),
                                  },
                                  initialCameraPosition: CameraPosition(
                                    target: state.location!,
                                    zoom: 18,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 16),
                    ],
                  ))),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: PrimaryButton(
              isLoading: _isSaving,
              onPressed: () {
                setState(() {
                  _isSaving = true;
                });

                if (!_formKey.currentState!.validate()) {
                  setState(() {
                    _isSaving = false;
                  });
                  return;
                }

                context
                    .read<PlantationsCreateBloc>()
                    .add(PlantationsCreateSave(onEnd: (result) {
                  setState(() {
                    _isSaving = false;
                  });

                  if (result) {
                    context.pushReplacement('/plantations/create/success');
                  }
                }));
              },
              text: 'Salvar',
            ),
          )
        ],
      );
    });
  }
}
