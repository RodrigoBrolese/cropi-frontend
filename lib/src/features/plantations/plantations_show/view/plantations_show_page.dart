import 'package:cropi/src/widgets/templates/layout.dart';
import 'package:flutter/material.dart';
import 'package:cropi/src/features/plantations/plantations_show/bloc/bloc.dart';
import 'package:cropi/src/features/plantations/plantations_show/widgets/plantations_show_body.dart';

class PlantationsShowPage extends StatelessWidget {
  const PlantationsShowPage({required this.plantationId, super.key});

  final String plantationId;

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
        builder: (_) => const PlantationsShowPage(
              plantationId: "",
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlantationsShowBloc(),
      child: Scaffold(
        body: PlantationsShowView(
          plantationId: plantationId,
        ),
      ),
    );
  }
}

class PlantationsShowView extends StatelessWidget {
  const PlantationsShowView({required this.plantationId, super.key});

  final String plantationId;

  @override
  Widget build(BuildContext context) {
    context
        .read<PlantationsShowBloc>()
        .add(LoadPlantationShowEvent(plantationId: plantationId));

    return const Layout(
      title: 'Plantação',
      showBackButton: true,
      noPadding: true,
      body: PlantationsShowBody(),
    );
  }
}
