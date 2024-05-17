import 'package:flutter/material.dart';
import 'package:socialv/models/tourvisor/travel_offer_model.dart';

class ExploreItemWidget extends StatelessWidget {
  const ExploreItemWidget(
      {Key? key, required this.data, this.onTap, this.raduis = 10})
      : super(key: key);
  final TravelOffer data;
  final double raduis;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 150,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(raduis),
            image: DecorationImage(
                image: NetworkImage(data.picture!), fit: BoxFit.cover)),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(raduis),
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(.5),
                        Colors.white.withOpacity(.01),
                      ])),
            ),
            Positioned(
              bottom: 12,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${data.country}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
