import 'package:cropi/src/widgets/templates/layout.dart';
import 'package:flutter/material.dart';
import 'package:cropi/src/features/plantations/plantations_list/bloc/bloc.dart';
import 'package:cropi/src/features/plantations/plantations_list/widgets/plantations_body.dart';
import 'package:go_router/go_router.dart';

class PlantationsPage extends StatelessWidget {
  const PlantationsPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const PlantationsPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlantationsBloc(),
      child: const Scaffold(
        body: PlantationsView(),
      ),
    );
  }
}

class PlantationsView extends StatelessWidget {
  const PlantationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: const PlantationsBody(),
      title: 'Plantações',
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/plantations/create');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
