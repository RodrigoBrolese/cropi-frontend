import 'package:cropi/src/features/plantations/plantations_create/bloc/bloc.dart';
import 'package:cropi/src/features/plantations/plantations_create/widgets/plantations_create_body.dart';
import 'package:cropi/src/widgets/templates/layout.dart';
import 'package:flutter/material.dart';

class PlantationsCreatePage extends StatelessWidget {
  const PlantationsCreatePage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
        builder: (_) => const PlantationsCreatePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlantationsCreateBloc(),
      child: const Scaffold(
        body: PlantationsCreateView(),
      ),
    );
  }
}

class PlantationsCreateView extends StatelessWidget {
  const PlantationsCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    context
        .read<PlantationsCreateBloc>()
        .add(const LoadPlantationCreateEvent());
    return const Layout(
      body: PlantationsCreateBody(),
      title: 'Nova plantação',
      showBackButton: true,
    );
  }
}
