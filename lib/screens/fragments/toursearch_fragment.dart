import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';

import '../../utils/app_constants.dart';

class TourSearchFragment extends StatefulWidget {
  final ScrollController controller;

  const TourSearchFragment({super.key, required this.controller});

  @override
  State<TourSearchFragment> createState() => _TourSearchFragmentState();
}

class _TourSearchFragmentState extends State<TourSearchFragment>
    with TickerProviderStateMixin {
  late TabController tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.index = 0;
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
        TabBar(
          indicatorColor: context.primaryColor,
          controller: tabController,
          onTap: (val) async {
            selectedIndex = val;
            setState(() {});
          },
          tabs: [
            Tooltip(
              richMessage: TextSpan(
                  text: language.home,
                  style: secondaryTextStyle(color: Colors.white)),
              child: Image.asset(
                selectedIndex == 0 ? ic_direction_selected : ic_direction,
                height: 24,
                width: 24,
                fit: BoxFit.cover,
                color: selectedIndex == 0
                    ? context.primaryColor
                    : context.iconColor,
              ).paddingSymmetric(vertical: 11),
            ),
            Tooltip(
              richMessage: TextSpan(
                  text: language.home,
                  style: secondaryTextStyle(color: Colors.white)),
              child: Image.asset(
                selectedIndex == 1 ? ic_hot_selected : ic_hot,
                height: 24,
                width: 24,
                fit: BoxFit.cover,
                // color: selectedIndex == 1
                //     ? context.primaryColor
                //     : context.iconColor,
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
                color: selectedIndex == 2
                    ? context.primaryColor
                    : context.iconColor,
              ).paddingSymmetric(vertical: 11),
            ),
          ],
        ),
      ],
    );
  }
}
