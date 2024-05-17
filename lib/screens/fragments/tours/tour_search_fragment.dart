import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class TourSearchFragment extends StatefulWidget {
  final ScrollController controller;

  const TourSearchFragment({super.key, required this.controller});

  @override
  State<TourSearchFragment> createState() => _TourSearchFragment();
}

class _TourSearchFragment extends State<TourSearchFragment> {
  @override
  Widget build(BuildContext context) {
    return Text("Search");
  }
}
