import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/components/loading_widget.dart';
import 'package:socialv/models/tourvisor/tour_offer_model.dart';
import 'package:socialv/services/tourvisorService.dart';
import 'package:socialv/utils/constants.dart';
import 'package:socialv/widgets/hotel_list_view.dart';
import 'package:socialv/widgets/search_form.dart';

class TourSearchFragment extends StatefulWidget {
  final ScrollController controller;

  const TourSearchFragment({super.key, required this.controller});

  @override
  State<TourSearchFragment> createState() => _TourSearchFragment();
}

class _TourSearchFragment extends State<TourSearchFragment>
    with TickerProviderStateMixin {
  List<TourOffer> listHotTour = [];
  AnimationController? animationController;
  bool isLoaded = true;
  int progress = 0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  Future<void> loadHotTour() async {
    setState(() {
      isLoaded = false;
    });

    final tourvisorService = TourvisorService();
    final requestid = await tourvisorService.getSearchId(
      datefrom: DateFormat('dd.MM.yyyy').format(globalDepartureDateFrom!),
      dateto: DateFormat('dd.MM.yyyy').format(globalDepartureDateTo!),
      departure: globalSelectedCityFrom.toString(),
      country: globalSelectedCityTo.toString(),
      adults: globalAdultsCount.toString(),
      child: globalChildrenCount.toString(),
      nightsFrom: globalNightsFrom.toString(),
      nightsTo: globalNightsTo.toString(),
      mealType: globalMealType.toString(),
      ratingType: globalRatingType.toString(),
      minBudget: globalMinBudget.toString(),
      maxBudget: globalMaxBudget.toString(),
      hotelTypes: globalHotelTypes.join(','),
    );

    int count = 0;
    while (true) {
      count++;
      final listTour =
          (await tourvisorService.getListTours(requestid: requestid!))!;
      if (listTour != null) {
        listHotTour = tourvisorService.getTourOfApiResponse(listTour);
      }
      progress = listTour.data != null
          ? listTour.data!.status != null
              ? listTour.data!.status!.progress ?? 0
              : 0
          : 0;
      if (progress > 0) {
        isLoaded = true;
      }
      if (progress == 100) {
        setState(() {});
        break;
      }
      if (count > 20) {
        progress = 100;
        isLoaded = true;
        setState(() {});
        break;
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? Column(
            children: [
              SearchFormWidget(
                onPressed: () => loadHotTour(),
              ),
              if (listHotTour.isNotEmpty)
                Column(
                  children: listHotTour.asMap().entries.map((entry) {
                    final int index = entry.key;
                    final tour = entry.value;
                    final int count =
                        listHotTour.length > 10 ? 10 : listHotTour.length;
                    final Animation<double> animation = Tween<double>(
                      begin:
                          index / count, // Изменено начальное значение анимации
                      end: 1.0,
                    ).animate(
                      CurvedAnimation(
                        parent: animationController!,
                        curve: Curves.fastOutSlowIn,
                      ),
                    );
                    animationController?.forward();

                    return HotelListView(
                      callback: () {},
                      hotelData: tour,
                      animation: animation,
                      animationController: animationController!,
                    );
                  }).toList(),
                ),
            ],
          )
        : const LoadingWidget();
  }
}
