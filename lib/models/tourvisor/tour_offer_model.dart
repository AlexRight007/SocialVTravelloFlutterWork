class TourOffer {
  final String? price;
  final String? priceOld;
  final String? tourId;
  final String? tourId2;
  final String? countryName;
  final String? departure;
  final String? departureFrom;
  final String? hotelCode;
  final String? hotelName;
  final String? hotelStars;
  final String? hotelRegionCode;
  final String? hotelRegionName;
  final int? hotelAcType;
  final String? hotelAcTypeName;
  final String? hotelPicture;
  final String? flyDate;
  final String? nights;
  final String? meal;
  final String? currency;

  TourOffer({
    this.price,
    this.priceOld,
    this.tourId,
    this.tourId2,
    this.countryName,
    this.departure,
    this.departureFrom,
    this.hotelCode,
    this.hotelName,
    this.hotelStars,
    this.hotelRegionCode,
    this.hotelRegionName,
    this.hotelAcType,
    this.hotelAcTypeName,
    this.hotelPicture,
    this.flyDate,
    this.nights,
    this.meal,
    this.currency,
  });

  factory TourOffer.fromJson(Map<String, dynamic> json) {
    return TourOffer(
      price: json['price'] as String?,
      priceOld: json['priceold'] as String?,
      tourId: json['tourid'] as String?,
      tourId2: json['tourid2'] as String?,
      countryName: json['countryname'] as String?,
      departure: json['departure'] as String?,
      departureFrom: json['departurefrom'] as String?,
      hotelCode: json['hotelcode'] as String?,
      hotelName: json['hotelname'] as String?,
      hotelStars: json['hotelstars'] as String?,
      hotelRegionCode: json['hotelregioncode'] as String?,
      hotelRegionName: json['hotelregionname'] as String?,
      hotelAcType: json['hotelactype'] as int?,
      hotelAcTypeName: json['hotelactypename'] as String?,
      hotelPicture: json['hotelpicture'] as String?,
      flyDate: json['flydate'] as String?,
      nights: json['nights'] as String?,
      meal: json['meal'] as String?,
      currency: json['currency'] as String?,
    );
  }
}
