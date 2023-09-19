import 'package:cropi/src/features/plantations/plantations_create/bloc/bloc.dart';
import 'package:cropi/src/features/plantations/plantations_create/widgets/plantations_create_success_body.dart';
import 'package:cropi/src/widgets/templates/layout.dart';
import 'package:flutter/material.dart';

class PlantationsCreateSuccessPage extends StatelessWidget {
  const PlantationsCreateSuccessPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
        builder: (_) => const PlantationsCreateSuccessPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlantationsCreateBloc(),
      child: const Scaffold(
        body: PlantationsCreateSuccessView(),
      ),
    );
  }
}

class PlantationsCreateSuccessView extends StatelessWidget {
  const PlantationsCreateSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Layout(
      body: PlantationsCreateSuccessBody(),
      title: 'Plantação cadastrada',
      showBackButton: true,
    );
  }
}
