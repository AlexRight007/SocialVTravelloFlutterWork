class ApiResponse {
  Data? data;
  Debug? debug;

  ApiResponse({this.data, this.debug});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      debug: json['debug'] != null ? Debug.fromJson(json['debug']) : null,
    );
  }
}

class Data {
  List<Block>? block;
  Decode? decode;
  List<Operator>? operators;
  Status? status;

  Data({this.block, this.decode, this.operators, this.status});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      block: json['block'] != null
          ? List<Block>.from(
              json['block'].map((block) => Block.fromJson(block)))
          : null,
      decode: json['decode'] != null ? Decode.fromJson(json['decode']) : null,
      operators: json['operators'] != null
          ? List<Operator>.from(
              json['operators'].map((operator) => Operator.fromJson(operator)))
          : null,
      status: json['status'] != null ? Status.fromJson(json['status']) : null,
    );
  }
}

class Block {
  int? id;
  int? operator;
  List<Hotel>? hotel;
  int? minPrice;

  Block({this.id, this.operator, this.hotel, this.minPrice});

  factory Block.fromJson(Map<String, dynamic> json) {
    return Block(
      id: json['id'],
      operator: json['operator'],
      hotel: json['hotel'] != null
          ? List<Hotel>.from(
              json['hotel'].map((hotel) => Hotel.fromJson(hotel)))
          : null,
      minPrice: json['minprice'],
    );
  }
}

class Hotel {
  int? id;
  int? price;
  List<Tour>? tour;

  Hotel({this.id, this.price, this.tour});

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'],
      price: json['price'],
      tour: json['tour'] != null
          ? List<Tour>.from(json['tour'].map((tour) => Tour.fromJson(tour)))
          : null,
    );
  }
}

class Tour {
  String? op;
  String? dt;
  int? nt;
  int? ntf;
  int? pl;
  int? pr;
  int? prfuel;
  int? prclean;
  String? tourId;
  int? nm;
  int? ml;
  double? prue;
  int? reg;
  int? ct;
  int? rm;
  int? mf;

  Tour({
    this.op,
    this.dt,
    this.nt,
    this.ntf,
    this.pl,
    this.pr,
    this.prfuel,
    this.prclean,
    this.tourId,
    this.nm,
    this.ml,
    this.prue,
    this.reg,
    this.ct,
    this.rm,
    this.mf,
  });

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
      op: json['op'].toString(),
      dt: json['dt'],
      nt: json['nt'],
      ntf: json['ntf'],
      pl: json['pl'],
      pr: json['pr'],
      prfuel: json['prfuel'],
      prclean: json['prclean'],
      tourId: json['id'],
      nm: json['nm'],
      ml: json['ml'],
      prue: json['prue'] is double
          ? json['prue']
          : double.parse(json['prue'].toString()),
      reg: json['reg'],
      ct: json['ct'],
      rm: json['rm'],
      mf: json['mf'],
    );
  }
}

class Decode {
  Map<String, HotelDetails>? hotels;
  Map<String, Room>? rooms;
  Map<String, Place>? place;
  Map<String, TourName>? tourname;
  Map<String, Meal>? meal;
  Map<String, CityTo>? cityto;

  Decode({
    this.hotels,
    this.rooms,
    this.place,
    this.tourname,
    this.meal,
    this.cityto,
  });

  factory Decode.fromJson(Map<String, dynamic> json) {
    return Decode(
      hotels: json['hotels'] != null
          ? Map.from(json['hotels'])
              .map((key, value) => MapEntry(key, HotelDetails.fromJson(value)))
          : null,
      rooms: json['rooms'] != null
          ? Map.from(json['rooms'])
              .map((key, value) => MapEntry(key, Room.fromJson(value)))
          : null,
      place: json['place'] != null
          ? Map.from(json['place'])
              .map((key, value) => MapEntry(key, Place.fromJson(value)))
          : null,
      tourname: json['tourname'] != null
          ? Map.from(json['tourname'])
              .map((key, value) => MapEntry(key, TourName.fromJson(value)))
          : null,
      meal: json['meal'] != null
          ? Map.from(json['meal'])
              .map((key, value) => MapEntry(key, Meal.fromJson(value)))
          : null,
      cityto: json['cityto'] != null
          ? Map.from(json['cityto'])
              .map((key, value) => MapEntry(key, CityTo.fromJson(value)))
          : null,
    );
  }
}

class HotelDetails {
  String? name;
  String? desc;
  String? rating;
  String? pop;
  String? stars;
  int? actype;
  double? lat;
  double? lng;
  int? reviews;
  int? details;
  Detail? detail;
  String? link;
  int? seadistance;
  String? types;
  String? services;
  String? regioncode;
  String? region;
  String? subregioncode;
  String? subregion;
  String? countrycode;
  String? country;
  String? pic;
  int? pict;
  RoomInfo? roominfo;

  HotelDetails({
    this.name,
    this.desc,
    this.rating,
    this.pop,
    this.stars,
    this.actype,
    this.lat,
    this.lng,
    this.reviews,
    this.details,
    this.detail,
    this.link,
    this.seadistance,
    this.types,
    this.services,
    this.regioncode,
    this.region,
    this.subregioncode,
    this.subregion,
    this.countrycode,
    this.country,
    this.pic,
    this.pict,
    this.roominfo,
  });

  factory HotelDetails.fromJson(Map<String, dynamic> json) {
    return HotelDetails(
      name: json['name'],
      desc: json['desc'],
      rating: json['rating'],
      pop: json['pop'],
      stars: json['stars'],
      actype: json['actype'],
      lat: json['lat'],
      lng: json['lng'],
      reviews: json['reviews'],
      details: json['details'],
      detail: json['detail'] != null ? Detail.fromJson(json['detail']) : null,
      link: json['link'],
      seadistance: json['seadistance'],
      types: json['types'],
      services: json['services'],
      regioncode: json['regioncode'],
      region: json['region'],
      subregioncode: json['subregioncode'],
      subregion: json['subregion'],
      countrycode: json['countrycode'],
      country: json['country'],
      pic: json['pic'],
      pict: json['pict'],
      roominfo:
          json['roominfo'] != null ? RoomInfo.fromJson(json['roominfo']) : null,
    );
  }
}

class Detail {
  int? desc;
  int? foto;
  int? reviews;

  Detail({this.desc, this.foto, this.reviews});

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      desc: json['desc'],
      foto: json['foto'],
      reviews: json['reviews'],
    );
  }
}

class RoomInfo {
  Map<String, int>? rooms;

  RoomInfo({this.rooms});

  factory RoomInfo.fromJson(Map<String, dynamic> json) {
    return RoomInfo(
      rooms: json['rooms'] != null
          ? Map<String, int>.from(json['rooms'])
              .map((key, value) => MapEntry(key, value))
          : null,
    );
  }
}

class Room {
  String? name;

  Room({this.name});

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      name: json['name'],
    );
  }
}

class Place {
  String? name;
  String? adults;
  String? child;

  Place({this.name, this.adults, this.child});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'],
      adults: json['adults'],
      child: json['child'],
    );
  }
}

class TourName {
  String? name;

  TourName({this.name});

  factory TourName.fromJson(Map<String, dynamic> json) {
    return TourName(
      name: json['name'],
    );
  }
}

class Meal {
  String? name;
  String? nameShort;
  int? ourId;

  Meal({this.name, this.nameShort, this.ourId});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      name: json['name'],
      nameShort: json['nameshort'],
      ourId: json['ourid'],
    );
  }
}

class CityTo {
  String? name;
  String? areaName;
  int? tempAir;
  int? tempWater;
  Coord? coord;
  List<int>? regions;

  CityTo({
    this.name,
    this.areaName,
    this.tempAir,
    this.tempWater,
    this.coord,
    this.regions,
  });

  factory CityTo.fromJson(Map<String, dynamic> json) {
    return CityTo(
      name: json['name'],
      areaName: json['areaname'],
      tempAir: json['tempair'],
      tempWater: json['tempwater'],
      coord: json['coord'] != null ? Coord.fromJson(json['coord']) : null,
      regions: json['regions'] != null ? List<int>.from(json['regions']) : null,
    );
  }
}

class Coord {
  double? lat;
  double? lng;

  Coord({this.lat, this.lng});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lat: json['lat'] is double
          ? json['lat']
          : double.parse(json['lat'].toString()),
      lng: json['lng'] is double
          ? json['lng']
          : double.parse(json['lng'].toString()),
    );
  }
}

class Operator {
  int? id;
  int? status;
  String? name;
  String? minPrice;

  Operator({this.id, this.status, this.name, this.minPrice});

  factory Operator.fromJson(Map<String, dynamic> json) {
    return Operator(
      id: json['id'],
      status: json['status'],
      name: json['name'],
      minPrice: json['minprice'],
    );
  }
}

class Status {
  int? progress;
  int? finished;
  int? requestId;

  Status({this.progress, this.finished, this.requestId});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      progress: json['progress'] != null
          ? json['progress'] is String
              ? int.parse(json['progress'])
              : json['progress']
          : 0,
      finished: json['finished'],
      requestId: json['requestid'],
    );
  }
}

class Debug {
  double? totalTime;
  String? rServer;
  String? zip;
  int? isBack;
  String? reqOnServer;
  int? reqTtl;
  String? rState;
  String? serId;

  Debug({
    this.totalTime,
    this.rServer,
    this.zip,
    this.isBack,
    this.reqOnServer,
    this.reqTtl,
    this.rState,
    this.serId,
  });

  factory Debug.fromJson(Map<String, dynamic> json) {
    return Debug(
      totalTime: json['totaltime'],
      rServer: json['rserver'],
      zip: json['zip'],
      isBack: json['isback'],
      reqOnServer: json['reqonserver'],
      reqTtl: json['reqttl'],
      rState: json['rstate'],
      serId: json['serid'],
    );
  }
}
