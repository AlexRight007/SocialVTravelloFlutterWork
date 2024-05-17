class TravelOffer {
  final String? departure;
  final int? departureCode;
  final String? country;
  final int? countryCode;
  final int? price;
  final String? flyDate;
  final int? nights;
  final int? stars;
  final int? operator;
  final String? link;
  final String? currency;
  final String? picture;
  final String? picHorizontal;
  final int? pictureId;
  final String? pictureData; // Поле для хранения данных из "picturedata"

  TravelOffer({
    this.departure,
    this.departureCode,
    this.country,
    this.countryCode,
    this.price,
    this.flyDate,
    this.nights,
    this.stars,
    this.operator,
    this.link,
    this.currency,
    this.picture,
    this.picHorizontal,
    this.pictureId,
    this.pictureData,
  });

  factory TravelOffer.fromJson(Map<String, dynamic> json) {
    return TravelOffer(
      departure: json['departure'] as String?,
      departureCode: json['departurecode'] as int?,
      country: json['country'] as String?,
      countryCode: json['countrycode'] as int?,
      price: json['price'] as int?,
      flyDate: json['flydate'] as String?,
      nights: json['nights'] as int?,
      stars: json['stars'] as int?,
      operator: json['operator'] as int?,
      link: json['link'] as String?,
      currency: json['currency'] as String?,
      picture: json['picture'] as String?,
      picHorizontal: json['pic_horizontal'] as String?,
      pictureId: json['pictureid'] as int?,
      pictureData: json['picturedata'] as String?,
    );
  }
}
