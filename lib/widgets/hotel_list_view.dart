import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/models/tourvisor/tour_offer_model.dart';
import 'package:socialv/screens/tourvisor/2.1_hotel_detail_screen.dart';
import 'package:socialv/utils/constants.dart';

class HotelListView extends StatelessWidget {
  const HotelListView(
      {Key? key,
      this.hotelData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final TourOffer? hotelData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  if (callback != null) {
                    callback!();
                  }
                  HotelDetailsScreen(
                    tourId: hotelData!.tourId2!,
                  ).launch(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(10, 10),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 2,
                              child: Image.network(
                                hotelData!.hotelPicture ?? '',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              color: context.accentColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, top: 8, bottom: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            hotelData!.hotelName ?? '',
                                            textAlign: TextAlign.left,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .outline),
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                '${hotelData!.countryName}, ${hotelData!.hotelRegionName}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .outline,
                                                    ),
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                              ),
                                              const Spacer(),
                                              Text(
                                                '${hotelData!.nights} ночей,  ${hotelData!.meal}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .outline,
                                                    ),
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                              ),
                                              const SizedBox(
                                                width: 16,
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 4),
                                            child: Row(
                                              children: <Widget>[
                                                RatingBar(
                                                  initialRating: double.parse(
                                                      hotelData!.hotelStars ??
                                                          '0'),
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 18,
                                                  ratingWidget: RatingWidget(
                                                    full: const Icon(
                                                      Icons.star_rate_rounded,
                                                      color: Colors.amber,
                                                    ),
                                                    half: const Icon(
                                                      Icons.star_half_rounded,
                                                      color: Colors.amber,
                                                    ),
                                                    empty: const Icon(
                                                      Icons.star_border_rounded,
                                                      color: Colors.amber,
                                                    ),
                                                  ),
                                                  itemPadding: EdgeInsets.zero,
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                ),
                                                Spacer(),
                                                Text(
                                                  '  Вылет ${hotelData!.flyDate}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .outline,
                                                      ),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       right: 16, top: 8),
                                  //   child: Column(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.center,
                                  //     crossAxisAlignment:
                                  //         CrossAxisAlignment.end,
                                  //     children: <Widget>[
                                  //       Text(
                                  //         '${hotelData!.price} тг.',
                                  //         textAlign: TextAlign.left,
                                  //         style: const TextStyle(
                                  //           fontWeight: FontWeight.w600,
                                  //           fontSize: 22,
                                  //         ),
                                  //       ),
                                  //       Text(
                                  //         '',
                                  //         style: TextStyle(
                                  //             fontSize: 14,
                                  //             color:
                                  //                 Colors.grey.withOpacity(0.8)),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                //Иконка лайк
                                // child: Icon(
                                //   Icons.favorite_border,
                                //   color: Theme.of(context).primaryColor,
                                // ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: context.accentColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${insertSpaceEveryNCharacters(hotelData!.price ?? '', 3)} тг.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outline,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
