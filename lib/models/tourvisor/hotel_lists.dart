class Hotel {
  int? id;
  String? name;
  int? stars;
  int? region;
  String? rating;
  Coord? coord;
  int? regionCode;
  int? subRegionCode;
  String? types;
  int? actype;
  String? services;

  Hotel({
    this.id,
    this.name,
    this.stars,
    this.region,
    this.rating,
    this.coord,
    this.regionCode,
    this.subRegionCode,
    this.types,
    this.actype,
    this.services,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'],
      name: json['name'],
      stars: json['stars'],
      region: json['region'],
      rating: json['rating'],
      coord: json['coord'] != null ? Coord.fromJson(json['coord']) : null,
      regionCode: json['regioncode'],
      subRegionCode: json['subregioncode'],
      types: json['types'],
      actype: json['actype'],
      services: json['services'],
    );
  }
}

class Coord {
  String? lat;
  String? lng;

  Coord({
    this.lat,
    this.lng,
  });

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}

class HotelList {
  List<Hotel>? hotel;

  HotelList({
    this.hotel,
  });

  factory HotelList.fromJson(Map<String, dynamic> json) {
    return HotelList(
      hotel: json['hotel'] != null
          ? List<Hotel>.from(json['hotel'].map((x) => Hotel.fromJson(x)))
          : null,
    );
  }
}

class Lists {
  HotelList? hotels;

  Lists({
    this.hotels,
  });

  factory Lists.fromJson(Map<String, dynamic> json) {
    return Lists(
      hotels:
          json['hotels'] != null ? HotelList.fromJson(json['hotels']) : null,
    );
  }
}

class HotelListDepartureModel {
  int? departure;
  Lists? lists;
  String? currency;

  HotelListDepartureModel({
    this.departure,
    this.lists,
    this.currency,
  });

  factory HotelListDepartureModel.fromJson(Map<String, dynamic> json) {
    return HotelListDepartureModel(
      departure: json['departure'],
      lists: json['lists'] != null ? Lists.fromJson(json['lists']) : null,
      currency: json['currency'],
    );
  }
}
