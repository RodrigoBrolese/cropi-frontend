import 'package:cropi/src/features/plantations/plantations_show/widgets/plantations_show_info.dart';
import 'package:cropi/src/features/plantations/plantations_show/widgets/plantations_show_ocurrences.dart';
import 'package:flutter/material.dart';
import 'package:cropi/src/features/plantations/plantations_show/bloc/bloc.dart';

class PlantationsShowBody extends StatelessWidget {
  const PlantationsShowBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantationsShowBloc, PlantationsShowState>(
      builder: (context, state) {
        if (state is PlantationsShowInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is PlantationsShowError) {
          return const Center(
            child: Text("Erro ao carregar dados"),
          );
        }

        return DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(tabs: [
                  Tab(
                    text: "Informações",
                  ),
                  Tab(
                    text: "Ocorrências",
                  ),
                ]),
                Expanded(
                  child: TabBarView(children: [
                    PlantationsShowInfo(
                      plantation: state.plantation!,
                    ),
                    PlantationsShowOcurrences(
                      regionOcurrences: state.regionOcurrences!,
                      plantationOcurrences: state.plantationOcurrences!,
                    )
                  ]),
                )
              ],
            ));
      },
    );
  }
}
