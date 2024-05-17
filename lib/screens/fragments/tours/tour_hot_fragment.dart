import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/components/loading_widget.dart';
import 'package:socialv/models/tourvisor/tour_offer_model.dart';
import 'package:socialv/services/tourvisorService.dart';
import 'package:socialv/widgets/hotel_list_view.dart';

class TourHotFragment extends StatefulWidget {
  final ScrollController controller;

  const TourHotFragment({super.key, required this.controller});

  @override
  State<TourHotFragment> createState() => _TourHotFragmentState();
}

class _TourHotFragmentState extends State<TourHotFragment>
    with TickerProviderStateMixin {
  List<TourOffer> listHotTour = [];
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
    loadHotTour();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  Future<void> loadHotTour() async {
    try {
      final tourvisorService = TourvisorService();
      listHotTour = await tourvisorService.getHotTours();
      setState(() {});
    } catch (e) {
      log('Error loading departures: $e');
      // Обработайте ошибку, например, отобразите сообщение об ошибке
    }
  }

  @override
  Widget build(BuildContext context) {
    return listHotTour.isNotEmpty
        ? Column(
            children: listHotTour.asMap().entries.map((entry) {
              final int index = entry.key;
              final tour = entry.value;
              final int count =
                  listHotTour.length > 10 ? 10 : listHotTour.length;
              final Animation<double> animation = Tween<double>(
                begin: index / count, // Изменено начальное значение анимации
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
          )
        : const LoadingWidget();
  }
}
