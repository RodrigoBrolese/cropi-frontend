import 'package:cropi/src/features/plantations/plantations_create/bloc/bloc.dart';
import 'package:cropi/src/widgets/atom/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlantationsCreateSuccessBody extends StatelessWidget {
  const PlantationsCreateSuccessBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantationsCreateBloc, PlantationsCreateState>(
        builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 100,
          ),
          const SizedBox(height: 10),
          Text("Plantação cadastrada com sucesso!",
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 50),
          PrimaryButton(
            onPressed: () {
              context.replace('/plantations');
            },
            text: 'Visualizar plantação',
          ),
        ],
      );
    });
  }
}
