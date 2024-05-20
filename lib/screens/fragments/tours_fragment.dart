import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/screens/fragments/tours/tour_deration_fragment.dart';
import 'package:socialv/screens/fragments/tours/tour_hot_fragment.dart';
import 'package:socialv/screens/fragments/tours/tour_search_fragment.dart';

import '../../utils/app_constants.dart';

class ToursFragment extends StatefulWidget {
  final ScrollController controller;

  const ToursFragment({super.key, required this.controller});

  @override
  State<ToursFragment> createState() => _ToursFragmentState();
}

class _ToursFragmentState extends State<ToursFragment>
    with TickerProviderStateMixin {
  late TabController tabController;
  List<Widget> appTourSearchFragments = [];
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.index = 0;

    tabController.addListener(() {
      setState(() {});
    });

    appTourSearchFragments.addAll([
      TourDerectionFragment(
        controller: _controller,
        tabController: tabController,
      ),
      TourHotFragment(controller: _controller),
      TourSearchFragment(controller: _controller),
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        TabBar(
          indicatorColor: context.primaryColor,
          controller: tabController,
          onTap: (val) async {
            setState(() {});
          },
          tabs: [
            Tooltip(
              richMessage: TextSpan(
                  text: language.home,
                  style: secondaryTextStyle(color: Colors.white)),
              child: Image.asset(
                tabController.index == 0 ? ic_direction_selected : ic_direction,
                height: 24,
                width: 24,
                fit: BoxFit.cover,
                color: tabController.index == 0
                    ? context.primaryColor
                    : context.iconColor,
              ).paddingSymmetric(vertical: 11),
            ),
            Tooltip(
              richMessage: TextSpan(
                  text: language.home,
                  style: secondaryTextStyle(color: Colors.white)),
              child: Image.asset(
                tabController.index == 1 ? ic_hot_selected : ic_hot,
                height: 24,
                width: 24,
                fit: BoxFit.cover,
                color: tabController.index == 1
                    ? context.primaryColor
                    : context.iconColor,
              ).paddingSymmetric(vertical: 11),
            ),
            Tooltip(
              richMessage: TextSpan(
                  text: language.home,
                  style: secondaryTextStyle(color: Colors.white)),
              child: Image.asset(
                ic_search_tour,
                height: 24,
                width: 24,
                fit: BoxFit.cover,
                color: tabController.index == 2
                    ? context.primaryColor
                    : context.iconColor,
              ).paddingSymmetric(vertical: 11),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        appTourSearchFragments[tabController.index],
      ],
    );
  }
}
