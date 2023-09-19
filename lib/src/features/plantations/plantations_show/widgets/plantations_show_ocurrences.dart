import 'package:cropi/src/features/plantations/plantations_show/widgets/plantations_show_ocurrences/plantations_show_plantation_ocurrences.dart';
import 'package:cropi/src/features/plantations/plantations_show/widgets/plantations_show_ocurrences/plantations_show_region_ocurrences.dart';
import 'package:cropi/src/models/models.dart';
import 'package:flutter/material.dart';

class PlantationsShowOcurrences extends StatefulWidget {
  const PlantationsShowOcurrences({
    Key? key,
    required this.plantationOcurrences,
    required this.regionOcurrences,
  }) : super(key: key);

  final List<Ocurrence> plantationOcurrences;
  final List<Ocurrence> regionOcurrences;

  @override
  State<PlantationsShowOcurrences> createState() =>
      _PlantationsShowOcurrencesState();
}

class _PlantationsShowOcurrencesState extends State<PlantationsShowOcurrences>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar.secondary(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(text: 'Na plantação'),
            Tab(text: 'Na região'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              PlantationsShowPlantationOcurrences(
                ocurrences: widget.plantationOcurrences,
              ),
              PlantationsShowRegionOcurrences(
                ocurrences: widget.regionOcurrences,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
