import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:socialv/models/tourvisor/tour_details_model.dart';
import 'package:socialv/services/tourvisorService.dart';
import 'package:socialv/utils/colors.dart';
import 'package:socialv/utils/constants.dart';

class HotelDetailsScreen extends StatefulWidget {
  final String tourId;
  const HotelDetailsScreen({
    Key? key,
    required this.tourId,
  }) : super(key: key);

  static const routeName = '/hotel-details';

  @override
  State<HotelDetailsScreen> createState() => DdetailsState();
}

class DdetailsState extends State<HotelDetailsScreen> {
  bool isLoaded = false;
  late TourDetailsResponse? tourDetails;
  final _controller = ScrollController();
  ScrollPhysics _physics = ClampingScrollPhysics();
  bool appBarVAR = false;
  bool bottomBarImagesVAR = false;

  Future run() async {
    await Future.delayed(Duration(milliseconds: 350));
    setState(() {
      appBarVAR = true;
      bottomBarImagesVAR = true;
    });
  }

  @override
  void initState() {
    super.initState();
    try {
      run();
    } catch (e) {
      debugPrint("$e");
    }
    _controller.addListener(() {
      if (_controller.position.pixels <= 100) {
        setState(() => _physics = ClampingScrollPhysics());
      } else {
        setState(() => _physics = BouncingScrollPhysics());
      }
    });
    loadTourDetails();
  }

  Future<void> loadTourDetails() async {
    try {
      final tourvisorService = TourvisorService();
      tourDetails =
          await tourvisorService.getTourDetails(tourId: widget.tourId);
      // tourDetails =
      //     await tourvisorService.getTourDetails(tourId: "99276579882834");
      isLoaded = true;
      setState(() {});
    } catch (e) {
      log('Error loading departures: $e');
      // Обработайте ошибку, например, отобразите сообщение об ошибке
    }
  }

  Map<String, String> mealTypesMap = {
    "BB": "Только завтрак",
    "HB": "Завтрак и ужин",
    "FB": "Завтрак, обед и ужин",
    "AI": "Все включено",
    "RO": "Без питания",
    // Добавьте другие значения при необходимости
  };

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SafeArea(
              child: ListView(
            children: [
              (tourDetails != null &&
                      tourDetails!.data != null &&
                      tourDetails!.data!.hotel != null &&
                      tourDetails!.data!.hotel!.images != null)
                  ? Material(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                      elevation: 4,
                      child: Hero(
                        tag: const SizedBox(), // widget.hero,
                        child: Container(
                          height:
                              (displayWidth * 534) / 800, //displayHeight / 2
                          width: displayWidth,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(40),
                                  bottomRight: Radius.circular(40),
                                ),
                                child: PhotoViewGallery.builder(
                                  itemCount: (tourDetails != null &&
                                          tourDetails!.data != null &&
                                          tourDetails!.data!.hotel != null &&
                                          tourDetails!.data!.hotel!.images !=
                                              null)
                                      ? tourDetails!.data!.hotel!.images!.length
                                      : 0,
                                  builder: (context, index) {
                                    return PhotoViewGalleryPageOptions(
                                      imageProvider: NetworkImage(
                                        tourDetails!
                                            .data!.hotel!.images![index].big!,
                                      ),
                                      maxScale:
                                          PhotoViewComputedScale.covered * 4,
                                      minScale: PhotoViewComputedScale.covered,
                                    );
                                  },
                                  scrollPhysics: const BouncingScrollPhysics(),
                                  pageController: PageController(),
                                  onPageChanged: (index) {
                                    // Обработка смены страницы
                                  },
                                ),
                              ),
                              AnimatedCrossFade(
                                firstChild: Container(),
                                secondChild: appBar(),
                                crossFadeState: appBarVAR
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: Duration(milliseconds: 400),
                              ),
                              AnimatedCrossFade(
                                firstChild: Container(),
                                secondChild: SizedBox(), //bottomBarImages(),
                                crossFadeState: appBarVAR
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: Duration(milliseconds: 600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : appBar(),
              SizedBox(height: 15),
              Container(
                width: displayWidth,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${tourDetails!.data!.tour!.hotelName}",
                            style: TextStyle(
                              // color: Theme.of(context).colorScheme.onBackground,
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "${tourDetails!.data!.tour!.countryName}, ${tourDetails!.data!.tour!.hotelRegionName}",
                            style: TextStyle(
                              // color: Theme.of(context).colorScheme.onBackground,
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${insertSpaceEveryNCharacters((tourDetails != null && tourDetails!.data != null && tourDetails!.data!.tour != null && tourDetails!.data!.tour!.price != null) ? tourDetails!.data!.tour!.price! : '', 3)} тг.",
                          style: TextStyle(
                            // color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 24,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "${tourDetails!.data!.tour!.placement}",
                          style: TextStyle(
                            // color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.black38.withOpacity(0.2),
                endIndent: 20,
                indent: 20,
                height: 4,
              ),
              (tourDetails != null &&
                      tourDetails!.data != null &&
                      tourDetails!.data!.hotel != null &&
                      tourDetails!.data!.hotel!.hotelDescription != '')
                  ? Column(
                      children: [
                        Container(
                          width: displayWidth,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${tourDetails!.data!.hotel!.hotelDescription}",
                                      style: TextStyle(
                                        // color: Theme.of(context)
                                        //     .colorScheme
                                        //     .onBackground,
                                        fontSize: 15,
                                        fontFamily: 'Montserrat',
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black38.withOpacity(0.2),
                          endIndent: 20,
                          indent: 20,
                          height: 4,
                        ),
                      ],
                    )
                  : const SizedBox(),
              SizedBox(height: 15),
              ListTile(
                isThreeLine: false,
                leading: CircleAvatar(
                  // backgroundColor:
                  //     Theme.of(context).colorScheme.secondaryContainer,
                  radius: 26,
                  child: Icon(
                    Icons.location_pin,
                    // color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: Text(
                  "${tourDetails!.data!.tour!.countryName}",
                  style: TextStyle(
                    // color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                  ),
                ),
                subtitle: Text(
                  "из ${tourDetails!.data!.tour!.departureNameFrom}",
                  style: TextStyle(
                    // color: Theme.of(context)
                    //     .colorScheme
                    //     .onBackground
                    //     .withOpacity(0.4),
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "",
                      style: TextStyle(
                        // color: Colors.blue,
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                isThreeLine: false,
                leading: CircleAvatar(
                  // backgroundColor:
                  //     Theme.of(context).colorScheme.secondaryContainer,
                  radius: 26,
                  child: Icon(
                    Icons.calendar_month,
                    // color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: Text(
                  "${tourDetails!.data!.tour!.flyDate}",
                  style: TextStyle(
                    // color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                  ),
                ),
                subtitle: Text(
                  "${tourDetails!.data!.tour!.nights} ночей",
                  style: TextStyle(
                    // color: Theme.of(context)
                    //     .colorScheme
                    //     .onBackground
                    //     .withOpacity(0.4),
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "",
                      style: TextStyle(
                        // color: Colors.blue,
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                isThreeLine: false,
                leading: CircleAvatar(
                  // backgroundColor:
                  //     Theme.of(context).colorScheme.secondaryContainer,
                  radius: 26,
                  child: Icon(
                    Icons.restaurant_sharp,
                    // color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: Text(
                  "Питание",
                  style: TextStyle(
                    // color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                  ),
                ),
                subtitle: Text(
                  "${tourDetails!.data!.tour!.meal} - ${mealTypesMap[tourDetails!.data!.tour!.meal] ?? "Другой тип питания"}",
                  style: TextStyle(
                    // color: Theme.of(context)
                    //     .colorScheme
                    //     .onBackground
                    //     .withOpacity(0.4),
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "",
                      style: TextStyle(
                        // color: Colors.blue,
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                isThreeLine: false,
                leading: CircleAvatar(
                  // backgroundColor:
                  //     Theme.of(context).colorScheme.secondaryContainer,
                  radius: 26,
                  child: Icon(
                    Icons.bed,
                    // color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: Text(
                  "${tourDetails!.data!.tour!.room}",
                  style: TextStyle(
                    // color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                  ),
                ),
                subtitle: Text(
                  "${tourDetails!.data!.tour!.placement}",
                  style: TextStyle(
                    // color: Theme.of(context)
                    //     .colorScheme
                    //     .onBackground
                    //     .withOpacity(0.4),
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "",
                      style: TextStyle(
                        // color: Colors.blue,
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              ),
              (tourDetails != null &&
                      tourDetails!.data != null &&
                      tourDetails!.data!.result != null &&
                      tourDetails!.data!.result!.contents != null)
                  ? ListTile(
                      isThreeLine: false,
                      leading: CircleAvatar(
                        // backgroundColor:
                        //     Theme.of(context).colorScheme.secondaryContainer,
                        radius: 26,
                        child: Icon(
                          Icons.settings,
                          // color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        "Услуги",
                        style: TextStyle(
                          // color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      subtitle: Text(
                        tourDetails!.data!.result!.contents!.join(', '),
                        style: TextStyle(
                          // color: Theme.of(context)
                          //     .colorScheme
                          //     .onBackground
                          //     .withOpacity(0.4),
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "",
                            style: TextStyle(
                              // color: Colors.blue,
                              fontSize: 12,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              ListTile(
                leading: CircleAvatar(
                  // backgroundColor:
                  //     Theme.of(context).colorScheme.secondaryContainer,
                  radius: 26,
                  child: Icon(
                    Icons.info,
                    // color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: Text(
                  "${tourDetails!.data!.tour!.tourName}",
                  style: TextStyle(
                    // color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              (tourDetails != null &&
                      tourDetails!.data != null &&
                      tourDetails!.data!.result != null)
                  ? Column(
                      children: [
                        Divider(
                          // color: Colors.black38.withOpacity(0.2),
                          endIndent: 20,
                          indent: 20,
                          height: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              for (int i = 0;
                                  i <
                                      tourDetails!.data!.result!.flights!
                                          .defaultSet!.forward!.length;
                                  i++)
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Transform.rotate(
                                              angle: 90 * 3.14 / 180,
                                              child: Icon(
                                                Icons.airplanemode_active,
                                                color: blueTickColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "${tourDetails!.data!.result!.flights!.defaultSet!.forward![i].departure!.time} ${tourDetails!.data!.result!.flights!.defaultSet!.forward![i].departure!.port!.timeZone}",
                                              style: TextStyle(
                                                // color: Theme.of(context)
                                                //     .colorScheme
                                                //     .onBackground,
                                                fontSize: 15,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                            Text(
                                              "${tourDetails!.data!.result!.flights!.defaultSet!.forward![i].departure!.date}",
                                              style: TextStyle(
                                                // color: Theme.of(context)
                                                //     .colorScheme
                                                //     .onBackground
                                                //     .withOpacity(0.4),
                                                fontSize: 15,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "${tourDetails!.data!.result!.flights!.defaultSet!.forward![i].departure!.port!.shortName}",
                                              style: TextStyle(
                                                // color: Theme.of(context)
                                                //     .colorScheme
                                                //     .onBackground,
                                                fontSize: 15,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                            Text(
                                              "${tourDetails!.data!.result!.flights!.defaultSet!.forward![i].arrival!.port!.shortName}",
                                              style: TextStyle(
                                                // color: Theme.of(context)
                                                //     .colorScheme
                                                //     .onBackground
                                                //     .withOpacity(0.4),
                                                fontSize: 15,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "${tourDetails!.data!.result!.flights!.defaultSet!.forward![i].arrival!.time} ${tourDetails!.data!.result!.flights!.defaultSet!.forward![i].arrival!.port!.timeZone}",
                                              style: TextStyle(
                                                // color: Theme.of(context)
                                                //     .colorScheme
                                                //     .onBackground,
                                                fontSize: 15,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                            Text(
                                              "${tourDetails!.data!.result!.flights!.defaultSet!.forward![i].arrival!.date}",
                                              style: TextStyle(
                                                // color: Theme.of(context)
                                                //     .colorScheme
                                                //     .onBackground
                                                //     .withOpacity(0.4),
                                                fontSize: 15,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black38.withOpacity(0.2),
                          endIndent: 20,
                          indent: 20,
                          height: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              for (int i = 0;
                                  i <
                                      tourDetails!.data!.result!.flights!
                                          .defaultSet!.reverse!.length;
                                  i++)
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Transform.rotate(
                                              angle: 270 * 3.14 / 180,
                                              child: Icon(
                                                Icons.airplanemode_active,
                                                color: blueTickColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "${tourDetails!.data!.result!.flights!.defaultSet!.reverse![i].departure!.time} ${tourDetails!.data!.result!.flights!.defaultSet!.reverse![i].departure!.port!.timeZone}",
                                              style: TextStyle(
                                                // color: Theme.of(context)
                                                //     .colorScheme
                                                //     .onBackground,
                                                fontSize: 15,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                            Text(
                                              "${tourDetails!.data!.result!.flights!.defaultSet!.reverse![i].departure!.date}",
                                              style: TextStyle(
                                                // color: Theme.of(context)
                                                //     .colorScheme
                                                //     .onBackground
                                                //     .withOpacity(0.4),
                                                fontSize: 15,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "${tourDetails!.data!.result!.flights!.defaultSet!.reverse![i].departure!.port!.shortName}",
                                              style: TextStyle(
                                                // color: Theme.of(context)
                                                //     .colorScheme
                                                //     .onBackground,
                                                fontSize: 15,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                            Text(
                                              "${tourDetails!.data!.result!.flights!.defaultSet!.reverse![i].arrival!.port!.shortName}",
                                              style: TextStyle(
                                                // color: Theme.of(context)
                                                //     .colorScheme
                                                //     .onBackground
                                                //     .withOpacity(0.4),
                                                fontSize: 15,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "${tourDetails!.data!.result!.flights!.defaultSet!.reverse![i].arrival!.time} ${tourDetails!.data!.result!.flights!.defaultSet!.reverse![i].arrival!.port!.timeZone}",
                                              style: TextStyle(
                                                // color: Theme.of(context)
                                                //     .colorScheme
                                                //     .onBackground,
                                                fontSize: 15,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                            Text(
                                              "${tourDetails!.data!.result!.flights!.defaultSet!.reverse![i].arrival!.date}",
                                              style: TextStyle(
                                                // color: Theme.of(context)
                                                //     .colorScheme
                                                //     .onBackground
                                                //     .withOpacity(0.4),
                                                fontSize: 15,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 100,
              ),
            ],
          )),
          Container(
              margin: EdgeInsets.all(displayWidth * .05),
              height: displayWidth * .155,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: blueTickColor,
                  borderRadius: BorderRadius.all(Radius.circular(35))),
              child: GestureDetector(
                onTap: () => TourvisorService.sendOrder(tourDetails!
                    .data!.tour!.shortId
                    .toString()), //Navigator.of(context).pop()
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Заказать сейчас ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 18,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget appBar() {
    return Row(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Container(
                  width: 48,
                  height: 48,
                  color: blueTickColor,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 16,
                      ),
                      Icon(
                        Icons.arrow_back_ios,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Spacer(),
        // Align(
        //   alignment: Alignment.topRight,
        //   child: Padding(
        //     padding: EdgeInsets.all(12),
        //     child: ClipRRect(
        //       borderRadius: BorderRadius.circular(32),
        //       child: Container(
        //         width: 48,
        //         height: 48,
        //         color: Colors.white,
        //         child: Icon(
        //           Icons.download_outlined,
        //           color: Colors.black87,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        // Align(
        //   alignment: Alignment.topRight,
        //   child: Padding(
        //     padding: EdgeInsets.all(12),
        //     child: ClipRRect(
        //       borderRadius: BorderRadius.circular(32),
        //       child: Container(
        //         width: 48,
        //         height: 48,
        //         color: Colors.white,
        //         child: Icon(
        //           FontAwesomeIcons.heart,
        //           color: Colors.black87,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  // Widget bottomBarImages() {
  //   return Align(
  //     alignment: Alignment.bottomCenter,
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
  //       child: ClipRRect(
  //         borderRadius: BorderRadius.circular(24),
  //         child: BackdropFilter(
  //           filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
  //           child: Container(
  //             height: 90,
  //             color: Theme.of(context).colorScheme.onBackground.withOpacity(0.25),
  //             child: Padding(
  //               padding: EdgeInsets.symmetric(horizontal: 12),
  //               child: Row(
  //                 children: [
  //                   ...List.generate(
  //                       3,
  //                       (index) => Expanded(
  //                             child: Padding(
  //                               padding: EdgeInsets.symmetric(
  //                                   horizontal: 4, vertical: 10),
  //                               child: ClipRRect(
  //                                 borderRadius: BorderRadius.circular(24),
  //                                 child: Stack(
  //                                   children: [
  //                                     Container(
  //                                       decoration: BoxDecoration(
  //                                           borderRadius: BorderRadius.all(
  //                                               Radius.circular(24)),
  //                                           image: DecorationImage(
  //                                               image: AssetImage(
  //                                                   data[index]["image"]),
  //                                               fit: BoxFit.cover)),
  //                                     ),
  //                                     index == (data.length - 1)
  //                                         ? Container(
  //                                             color: Colors.blue.shade800
  //                                                 .withOpacity(0.4),
  //                                             child: Center(
  //                                               child: Text(
  //                                                 "+5",
  //                                                 style: TextStyle(
  //                                                   color: Colors.white,
  //                                                   fontSize: 22,
  //                                                   fontWeight: FontWeight.bold,
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                           )
  //                                         : Container()
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                           ))
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
