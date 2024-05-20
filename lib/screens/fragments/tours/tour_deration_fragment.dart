import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/components/loading_widget.dart';
import 'package:socialv/models/tourvisor/travel_offer_model.dart';
import 'package:socialv/screens/fragments/tours/explore_item_widget.dart';
import 'package:socialv/screens/fragments/tours/loaction_dropdown_widgets.dart';
import 'package:socialv/services/tourvisorService.dart';
import 'package:socialv/utils/constants.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TourDerectionFragment extends StatefulWidget {
  final ScrollController controller;
  TabController tabController;

  TourDerectionFragment(
      {super.key, required this.controller, required this.tabController});

  @override
  State<TourDerectionFragment> createState() => _TourDeractionFragment();
}

class _TourDeractionFragment extends State<TourDerectionFragment>
    with TickerProviderStateMixin {
  late List<TravelOffer> travelOffer = [];
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
    loadTravelOffer();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  Future<void> loadTravelOffer() async {
    try {
      final tourvisorService = TourvisorService();
      travelOffer = await tourvisorService.getTravelOffers(
          cityCode: globalSelectedCityFrom);
      setState(() {});
    } catch (e) {
      log('Error loading departures: $e');
      // Обработайте ошибку, например, отобразите сообщение об ошибке
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 10,
            bottom: 0,
          ),
          child: LocationDropdownWidget(
            onChanged: (p0) => loadTravelOffer(),
          ), // Используем новый виджет
        ),
        travelOffer.isNotEmpty ? getPlaces() : const LoadingWidget(),
      ],
    );
  }

  getPlaces() {
    return new MasonryGridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      itemCount: travelOffer.length,
      itemBuilder: (BuildContext context, int index) => ExploreItemWidget(
          data: travelOffer[index],
          onTap: () {
            globalSelectedCityTo = travelOffer[index].countryCode!;
            currentIndex = 2;
            widget.tabController.animateTo(2);
            setState(() {});
            // Navigator.popAndPushNamed(context, HomeScreen.routeName);
          }),
      // staggeredTileBuilder: (int index) =>
      //     new StaggeredTile.count(2, index.isEven ? 3 : 2),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
    );
  }
}
