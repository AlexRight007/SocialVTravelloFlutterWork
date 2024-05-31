// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socialv/models/tourvisor/departure_model.dart';
import 'package:socialv/services/tourvisorService.dart';
import 'package:socialv/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class LocationDropdownWidget extends StatefulWidget {
  void Function(int?)? onChanged;
  LocationDropdownWidget({
    this.onChanged,
  });
  @override
  _LocationDropdownWidgetState createState() => _LocationDropdownWidgetState();
}

class _LocationDropdownWidgetState extends State<LocationDropdownWidget> {
  late List<Departure> departures = [];

  @override
  void initState() {
    super.initState();
    loadDepartures();
  }

  Future<void> loadDepartures() async {
    try {
      final tourvisorService = TourvisorService();
      departures = await tourvisorService.getDepartures();
      setState(() {});
    } catch (e) {
      log('Error loading departures: $e');
      // Обработайте ошибку, например, отобразите сообщение об ошибке
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(
              "Местоположение",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: context.iconColor),
            ),
            // const SizedBox(
            //   width: 10,
            // ),
            // Icon(
            //   Icons.location_on_outlined,
            //   color: context.accentColor,
            // ),
            Spacer(),
            DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: globalSelectedCityFrom,
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: context.accentColor,
                ),
                onChanged: (int? newValue) {
                  setState(() {
                    globalSelectedCityFrom = newValue!;
                    if (widget.onChanged != null) {
                      widget.onChanged!(newValue);
                    }
                  });
                },
                items: departures
                    .map<DropdownMenuItem<int>>((Departure departure) {
                  return DropdownMenuItem<int>(
                    value: departure.id,
                    child: Text(
                      '${departure.name}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        Row(
          children: [],
        ),
      ],
    );
  }
}
