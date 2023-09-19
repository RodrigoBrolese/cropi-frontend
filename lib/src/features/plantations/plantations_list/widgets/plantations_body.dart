import 'package:cropi/src/features/plantations/plantations_list/plantations_list.dart';
import 'package:cropi/src/widgets/atom/alert_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlantationsBody extends StatelessWidget {
  const PlantationsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantationsBloc, PlantationsState>(
      builder: (context, state) {
        if (state is PlantationsLoadingError) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<PlantationsBloc>().add(const LoadPlantationsEvent());
            },
            child: ListView(children: const [
              AlertCard(
                  color: Colors.red,
                  textColor: Colors.white,
                  message:
                      "Ocorreu um erro, verifique sua conexão com a internet ou tente novamente mais tarde.")
            ]),
          );
        }

        if (state is PlantationsInitial) {
          context.read<PlantationsBloc>().add(const LoadPlantationsEvent());
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.plantations.isEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<PlantationsBloc>().add(const LoadPlantationsEvent());
            },
            child: const Center(child: Text('Não há plantações cadastradas')),
          );
        }

        return RefreshIndicator(
          child: ListView.builder(
            itemCount: state.plantations.length,
            itemBuilder: (context, index) {
              final plantation = state.plantations[index];
              return PlantationsCard(
                plantation: plantation,
                onTap: () {
                  context.push('/plantations/${plantation.id}');
                },
              );
            },
          ),
          onRefresh: () async {
            context.read<PlantationsBloc>().add(const LoadPlantationsEvent());
          },
        );
      },
    );
  }
}
