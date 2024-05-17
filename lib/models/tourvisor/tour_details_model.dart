import 'dart:convert';

class TourDetailsResponse {
  final TourDetailsData? data;
  final bool? error;
  final bool? fromCache;

  TourDetailsResponse({
    this.data,
    this.error,
    this.fromCache,
  });

  factory TourDetailsResponse.fromJson(Map<String, dynamic> json) {
    return TourDetailsResponse(
      data:
          json['data'] != null ? TourDetailsData.fromJson(json['data']) : null,
      error: json['error'] ?? false,
      fromCache: json['fromcache'] ?? false,
    );
  }
}

class TourDetailsData {
  final Tour? tour;
  final Client? client;
  final Result? result;
  final bool? contentsAuto;
  final String? engine;
  final Price? cleanPrice;
  final Hotel? hotel;

  TourDetailsData({
    this.tour,
    this.client,
    this.result,
    this.contentsAuto,
    this.engine,
    this.cleanPrice,
    this.hotel,
  });

  factory TourDetailsData.fromJson(Map<String, dynamic> json) {
    return TourDetailsData(
      tour: json['tour'] != null
          ? Tour.fromJson(json['tour'])
          : null, // тут ошибка
      // client: json['client'] != null ? Client.fromJson(json['client']) : null, // тут ошибка
      result: json['result'] != null ? Result.fromJson(json['result']) : null,
      contentsAuto: json['contentsauto'] ?? true,
      engine: json['engine'] ?? '',
      cleanPrice: json['cleanprice'] != null
          ? Price.fromJson(json['cleanprice'])
          : null,
      hotel: json['hotel'] != null ? Hotel.fromJson(json['hotel']) : null,
    );
  }
}

class Tour {
  final String? tourId;
  final String? hotelCode;
  final String? hotelName;
  final int? hotelStars;
  final String? hotelRegionCode;
  final String? hotelRegionName;
  final int? hotelAcType;
  final String? hotelAcTypeName;
  final String? countryCode;
  final String? countryName;
  final String? departureCode;
  final String? departureName;
  final String? departureNameFrom;
  final String? operatorCode;
  final String? operatorName;
  final String? operatorLogo;
  final String? flyDate;
  final int? nights;
  final int? nightsInFlight;
  final String? meal;
  final int? mealCode;
  final String? room;
  final int? roomCode;
  final String? tourName;
  final int? tourNameCode;
  final String? placement;
  final int? adults;
  final int? child;
  final String? price;
  final String? cleanPrice;
  final String? fuelCharge;
  final String? currency;
  final String? curue;
  final String? originalPrice;
  final String? originalCurrency;
  final String? visaCharge;
  final int? regular;
  final String? infantAddrub;
  final String? cityTo;
  final String? hotelPictureSmall;
  final String? hotelPictureMedium;
  final String? fullDescLink;
  final int? shortId;
  final Share? share;

  Tour({
    this.tourId,
    this.hotelCode,
    this.hotelName,
    this.hotelStars,
    this.hotelRegionCode,
    this.hotelRegionName,
    this.hotelAcType,
    this.hotelAcTypeName,
    this.countryCode,
    this.countryName,
    this.departureCode,
    this.departureName,
    this.departureNameFrom,
    this.operatorCode,
    this.operatorName,
    this.operatorLogo,
    this.flyDate,
    this.nights,
    this.nightsInFlight,
    this.meal,
    this.mealCode,
    this.room,
    this.roomCode,
    this.tourName,
    this.tourNameCode,
    this.placement,
    this.adults,
    this.child,
    this.price,
    this.cleanPrice,
    this.fuelCharge,
    this.currency,
    this.curue,
    this.originalPrice,
    this.originalCurrency,
    this.visaCharge,
    this.regular,
    this.infantAddrub,
    this.cityTo,
    this.hotelPictureSmall,
    this.hotelPictureMedium,
    this.fullDescLink,
    this.shortId,
    this.share,
  });

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
      tourId: json['tourid'],
      hotelCode: json['hotelcode'],
      hotelName: json['hotelname'],
      hotelStars: json['hotelstars'],
      hotelRegionCode: json['hotelregioncode'],
      hotelRegionName: json['hotelregionname'],
      hotelAcType: json['hotelactype'],
      hotelAcTypeName: json['hotelactypename'],
      countryCode: json['countrycode'],
      countryName: json['countryname'],
      departureCode: json['departurecode'],
      departureName: json['departurename'],
      departureNameFrom: json['departurenamefrom'],
      operatorCode: json['operatorcode'],
      operatorName: json['operatorname'],
      operatorLogo: json['operatorlogo'],
      flyDate: json['flydate'],
      nights: json['nights'],
      nightsInFlight: json['nightsinflight'],
      meal: json['meal'],
      mealCode: json['mealcode'],
      room: json['room'],
      roomCode: json['roomcode'],
      tourName: json['tourname'],
      tourNameCode: json['tournamecode'],
      placement: json['placement'],
      adults: json['adults'],
      child: json['child'],
      price: json['price'],
      cleanPrice: json['cleanprice'],
      fuelCharge: json['fuelcharge'],
      currency: json['currency'],
      curue: json['curue'],
      originalPrice: json['originalprice'],
      originalCurrency: json['originalcurrency'],
      visaCharge: json['visacharge'],
      regular: json['regular'],
      infantAddrub: json['infantaddrub'],
      cityTo: json['city_to'],
      hotelPictureSmall: json['hotelpicturesmall'],
      hotelPictureMedium: json['hotelpicturemedium'],
      fullDescLink: json['fulldesclink'],
      shortId: json['shortid'],
      share: json['share'] != null ? Share.fromJson(json['share']) : null,
    );
  }
}

class Share {
  final String? searchLink;
  final String? vk;
  final String? facebook;
  final String? twitter;

  Share({
    this.searchLink,
    this.vk,
    this.facebook,
    this.twitter,
  });

  factory Share.fromJson(Map<String, dynamic> json) {
    return Share(
      searchLink: json['searchlink'],
      vk: json['vk'],
      facebook: json['facebook'],
      twitter: json['twitter'],
    );
  }
}

class Client {
  final String? online;
  final int? customerAddressEnabled;
  final int? customerPassportEnabled;
  final int? showRequest;
  final int? showRequestOffice;
  final String? fuelDisable;
  final String? detailed;
  final int? multiOffice;
  final int? cart;
  final int? recommend;
  final int? russianPassport;

  Client({
    this.online,
    this.customerAddressEnabled,
    this.customerPassportEnabled,
    this.showRequest,
    this.showRequestOffice,
    this.fuelDisable,
    this.detailed,
    this.multiOffice,
    this.cart,
    this.recommend,
    this.russianPassport,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      online: json['online'],
      customerAddressEnabled: json['customer_address_enabled'],
      customerPassportEnabled: json['customer_passport_enabled'],
      showRequest: json['showrequest'],
      showRequestOffice: json['showrequestoffice'],
      fuelDisable: json['fueldisable'],
      detailed: json['detailed'],
      multiOffice: json['multioffice'],
      cart: json['cart'],
      recommend: json['recommend'],
      russianPassport: json['russianpassport'],
    );
  }
}

class Result {
  final List<String>? contents;
  final Flights? flights;
  final Conditions? conditions;
  final String? agencyLink;
  final bool? contentsAuto;
  final String? engine;
  final Price? cleanPrice;

  Result({
    this.contents,
    this.flights,
    this.conditions,
    this.agencyLink,
    this.contentsAuto,
    this.engine,
    this.cleanPrice,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      contents:
          json['contents'] != null ? List<String>.from(json['contents']) : null,
      flights:
          json['flights'] != null ? Flights.fromJson(json['flights']) : null,
      conditions: json['conditions'] != null
          ? Conditions.fromJson(json['conditions'])
          : null,
      agencyLink: json['agencyLink'],
      contentsAuto: json['contentsauto'] ?? true,
      engine: json['engine'] ?? '',
      cleanPrice: json['cleanprice'] != null
          ? Price.fromJson(json['cleanprice'])
          : null,
    );
  }
}

class Flights {
  final DefaultSet? defaultSet;
  final bool? extraQuery;
  final List<ExtraSet>? extraSet;

  Flights({
    this.defaultSet,
    this.extraQuery,
    this.extraSet,
  });

  factory Flights.fromJson(Map<String, dynamic> json) {
    return Flights(
      defaultSet: json['defaultSet'] != null
          ? DefaultSet.fromJson(json['defaultSet'])
          : null,
      extraQuery: json['extraQuery'] ?? false,
      extraSet: json['extraSet'] != null
          ? List<ExtraSet>.from(
              json['extraSet'].map((x) => ExtraSet.fromJson(x)))
          : null,
    );
  }
}

class DefaultSet {
  final List<Forward>? forward;
  final List<Reverse>? reverse;
  final ForwardDate? forwardDate;
  final ReverseDate? reverseDate;
  final Price? price;
  final FuelCharge? fuelCharge;
  final dynamic additional;
  final dynamic regularCharge;
  final bool? isDefault;
  final int? flightDurationForward;
  final int? flightDurationReverse;
  final bool? isDummy;

  DefaultSet({
    this.forward,
    this.reverse,
    this.forwardDate,
    this.reverseDate,
    this.price,
    this.fuelCharge,
    this.additional,
    this.regularCharge,
    this.isDefault,
    this.flightDurationForward,
    this.flightDurationReverse,
    this.isDummy,
  });

  factory DefaultSet.fromJson(Map<String, dynamic> json) {
    return DefaultSet(
      forward: json['forward'] != null
          ? List<Forward>.from(json['forward'].map((x) => Forward.fromJson(x)))
          : null,
      reverse: json['reverse'] != null
          ? List<Reverse>.from(json['reverse'].map((x) => Reverse.fromJson(x)))
          : null,
      forwardDate: json['forwardDate'] != null
          ? ForwardDate.fromJson(json['forwardDate'])
          : null,
      reverseDate: json['reverseDate'] != null
          ? ReverseDate.fromJson(json['reverseDate'])
          : null,
      price: json['price'] != null ? Price.fromJson(json['price']) : null,
      fuelCharge: json['fuelCharge'] != null
          ? FuelCharge.fromJson(json['fuelCharge'])
          : null,
      additional: json['additional'],
      regularCharge: json['regularCharge'],
      isDefault: json['isDefault'] ?? false,
      flightDurationForward: json['flightDurationForward'] ?? 0,
      flightDurationReverse: json['flightDurationReverse'] ?? 0,
      isDummy: json['isDummy'] ?? false,
    );
  }
}

class ExtraSet {
  final List<Forward>? forward;
  final List<Reverse>? reverse;
  final ForwardDate? forwardDate;
  final ReverseDate? reverseDate;
  final Price? price;
  final FuelCharge? fuelCharge;
  final dynamic additional;
  final dynamic regularCharge;
  final bool? isDefault;
  final int? flightDurationForward;
  final int? flightDurationReverse;
  final bool? isDummy;

  ExtraSet({
    this.forward,
    this.reverse,
    this.forwardDate,
    this.reverseDate,
    this.price,
    this.fuelCharge,
    this.additional,
    this.regularCharge,
    this.isDefault,
    this.flightDurationForward,
    this.flightDurationReverse,
    this.isDummy,
  });

  factory ExtraSet.fromJson(Map<String, dynamic> json) {
    return ExtraSet(
      forward: json['forward'] != null
          ? List<Forward>.from(json['forward'].map((x) => Forward.fromJson(x)))
          : null,
      reverse: json['reverse'] != null
          ? List<Reverse>.from(json['reverse'].map((x) => Reverse.fromJson(x)))
          : null,
      forwardDate: json['forwardDate'] != null
          ? ForwardDate.fromJson(json['forwardDate'])
          : null,
      reverseDate: json['reverseDate'] != null
          ? ReverseDate.fromJson(json['reverseDate'])
          : null,
      price: json['price'] != null ? Price.fromJson(json['price']) : null,
      fuelCharge: json['fuelCharge'] != null
          ? FuelCharge.fromJson(json['fuelCharge'])
          : null,
      additional: json['additional'],
      regularCharge: json['regularCharge'],
      isDefault: json['isDefault'] ?? false,
      flightDurationForward: json['flightDurationForward'] ?? 0,
      flightDurationReverse: json['flightDurationReverse'] ?? 0,
      isDummy: json['isDummy'] ?? false,
    );
  }
}

class Forward {
  final String? number;
  final Company? company;
  final FuelCharge? fuelCharges;
  final String? plane;
  final String? flightClass;
  final DepartureDate? departure;
  final Arrival? arrival;
  final bool? onDemand;
  final bool? noPlaces;
  final dynamic baggage;
  final String? carryOn;

  Forward({
    this.number,
    this.company,
    this.fuelCharges,
    this.plane,
    this.flightClass,
    this.departure,
    this.arrival,
    this.onDemand,
    this.noPlaces,
    this.baggage,
    this.carryOn,
  });

  factory Forward.fromJson(Map<String, dynamic> json) {
    return Forward(
      number: json['number'],
      company:
          json['company'] != null ? Company.fromJson(json['company']) : null,
      fuelCharges: json['fuelCharges'] != null
          ? FuelCharge.fromJson(json['fuelCharges'])
          : null,
      plane: json['plane'],
      flightClass: json['class'],
      departure: json['departure'] != null
          ? DepartureDate.fromJson(json['departure'])
          : null,
      arrival:
          json['arrival'] != null ? Arrival.fromJson(json['arrival']) : null,
      onDemand: json['onDemand'] ?? false,
      noPlaces: json['noPlaces'] ?? false,
      baggage: json['baggage'],
      carryOn: json['carryOn'],
    );
  }
}

class Company {
  final String? id;
  final String? name;
  final String? thumb;
  final String? logo;

  Company({
    this.id,
    this.name,
    this.thumb,
    this.logo,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
      thumb: json['thumb'],
      logo: json['logo'],
    );
  }
}

class FuelCharge {
  final int? value;
  final String? currency;
  final bool? perPerson;

  FuelCharge({
    this.value,
    this.currency,
    this.perPerson,
  });

  factory FuelCharge.fromJson(Map<String, dynamic> json) {
    return FuelCharge(
      value: json['value'],
      currency: json['currency'],
      perPerson: json['perPerson'] ?? false,
    );
  }
}

class DepartureDate {
  final String? date;
  final String? time;
  final Port? port;

  DepartureDate({
    this.date,
    this.time,
    this.port,
  });

  factory DepartureDate.fromJson(Map<String, dynamic> json) {
    return DepartureDate(
      date: json['date'],
      time: json['time'],
      port: json['port'] != null ? Port.fromJson(json['port']) : null,
    );
  }
}

class Port {
  final String? id;
  final String? name;
  final String? shortName;
  final String? timeZone;

  Port({
    this.id,
    this.name,
    this.shortName,
    this.timeZone,
  });

  factory Port.fromJson(Map<String, dynamic> json) {
    return Port(
      id: json['id'],
      name: json['name'],
      shortName: json['shortName'],
      timeZone: json['timeZone'],
    );
  }
}

class Arrival {
  final String? date;
  final String? time;
  final Port? port;

  Arrival({
    this.date,
    this.time,
    this.port,
  });

  factory Arrival.fromJson(Map<String, dynamic> json) {
    return Arrival(
      date: json['date'],
      time: json['time'],
      port: json['port'] != null ? Port.fromJson(json['port']) : null,
    );
  }
}

class Reverse {
  final String? number;
  final Company? company;
  final FuelCharge? fuelCharges;
  final String? plane;
  final String? flightClass;
  final DepartureDate? departure;
  final Arrival? arrival;
  final bool? onDemand;
  final bool? noPlaces;
  final dynamic baggage;
  final String? carryOn;

  Reverse({
    this.number,
    this.company,
    this.fuelCharges,
    this.plane,
    this.flightClass,
    this.departure,
    this.arrival,
    this.onDemand,
    this.noPlaces,
    this.baggage,
    this.carryOn,
  });

  factory Reverse.fromJson(Map<String, dynamic> json) {
    return Reverse(
      number: json['number'],
      company:
          json['company'] != null ? Company.fromJson(json['company']) : null,
      fuelCharges: json['fuelCharges'] != null
          ? FuelCharge.fromJson(json['fuelCharges'])
          : null,
      plane: json['plane'],
      flightClass: json['class'],
      departure: json['departure'] != null
          ? DepartureDate.fromJson(json['departure'])
          : null,
      arrival:
          json['arrival'] != null ? Arrival.fromJson(json['arrival']) : null,
      onDemand: json['onDemand'] ?? false,
      noPlaces: json['noPlaces'] ?? false,
      baggage: json['baggage'],
      carryOn: json['carryOn'],
    );
  }
}

class ForwardDate {
  final int? day;
  final int? month;
  final int? year;
  final bool? valid;
  final String? formed;
  final String? dayStr;
  final String? monthStr;

  ForwardDate({
    this.day,
    this.month,
    this.year,
    this.valid,
    this.formed,
    this.dayStr,
    this.monthStr,
  });

  factory ForwardDate.fromJson(Map<String, dynamic> json) {
    return ForwardDate(
      day: json['d'],
      month: json['m'],
      year: json['y'],
      valid: json['valid'],
      formed: json['formed'],
      dayStr: json['day'],
      monthStr: json['month'],
    );
  }
}

class ReverseDate {
  final int? day;
  final int? month;
  final int? year;
  final bool? valid;
  final String? formed;
  final String? dayStr;
  final String? monthStr;

  ReverseDate({
    this.day,
    this.month,
    this.year,
    this.valid,
    this.formed,
    this.dayStr,
    this.monthStr,
  });

  factory ReverseDate.fromJson(Map<String, dynamic> json) {
    return ReverseDate(
      day: json['d'],
      month: json['m'],
      year: json['y'],
      valid: json['valid'],
      formed: json['formed'],
      dayStr: json['day'],
      monthStr: json['month'],
    );
  }
}

class Price {
  final int? value;
  final String? currency;

  Price({
    this.value,
    this.currency,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      value: json['value'],
      currency: json['currency'],
    );
  }
}

class Conditions {
  final int? isTransfer;
  final int? isInsurance;

  Conditions({
    this.isTransfer,
    this.isInsurance,
  });

  factory Conditions.fromJson(Map<String, dynamic> json) {
    return Conditions(
      isTransfer: json['isTransfer'],
      isInsurance: json['isInsurance'],
    );
  }
}

class HotelImage {
  final String? preview;
  final int? isVeryBig;
  final String? isVertical;
  final String? width;
  final String? height;
  final String? big;

  HotelImage({
    this.preview,
    this.isVeryBig,
    this.isVertical,
    this.width,
    this.height,
    this.big,
  });

  factory HotelImage.fromJson(Map<String, dynamic> json) {
    return HotelImage(
      preview: json['preview'],
      isVeryBig: json['isverybig'],
      isVertical: json['isvertical'],
      width: json['width'],
      height: json['height'],
      big: json['big'],
    );
  }
}

class Hotel {
  final String? hotelCode;
  final String? hotelName;
  final String? hotelStars;
  final String? hotelRegionCode;
  final String? hotelRegionName;
  final String? countryCode;
  final String? countryName;
  final int? hotelAcType;
  final String? hotelAcTypeName;
  final String? rating;
  final String? hotelDescription;
  final Types? types;
  final String? hotelPictureSmall;
  final String? hotelPictureMedium;
  final String? reviewsCount;
  final List<HotelImage>? images;

  Hotel({
    this.hotelCode,
    this.hotelName,
    this.hotelStars,
    this.hotelRegionCode,
    this.hotelRegionName,
    this.countryCode,
    this.countryName,
    this.hotelAcType,
    this.hotelAcTypeName,
    this.rating,
    this.hotelDescription,
    this.types,
    this.hotelPictureSmall,
    this.hotelPictureMedium,
    this.reviewsCount,
    this.images,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      hotelCode: json['hotelcode'],
      hotelName: json['hotelname'],
      hotelStars: json['hotelstars'],
      hotelRegionCode: json['hotelregioncode'],
      hotelRegionName: json['hotelregionname'],
      countryCode: json['countrycode'],
      countryName: json['countryname'],
      hotelAcType: json['hotelactype'],
      hotelAcTypeName: json['hotelactypename'],
      rating: json['rating'],
      hotelDescription: json['hoteldescription'],
      types: json['types'] != null ? Types.fromJson(json['types']) : null,
      hotelPictureSmall: json['hotelpicturesmall'],
      hotelPictureMedium: json['hotelpicturemedium'],
      reviewsCount: json['reviewscount'],
      images: json['images'] != null
          ? List<HotelImage>.from(
              json['images'].map((x) => HotelImage.fromJson(x)))
          : null,
    );
  }
}

class Types {
  final String? active;
  final String? relax;
  final String? family;
  final String? health;
  final String? city;
  final String? beach;
  final String? deluxe;

  Types({
    this.active,
    this.relax,
    this.family,
    this.health,
    this.city,
    this.beach,
    this.deluxe,
  });

  factory Types.fromJson(Map<String, dynamic> json) {
    return Types(
      active: json['active'],
      relax: json['relax'],
      family: json['family'],
      health: json['health'],
      city: json['city'],
      beach: json['beach'],
      deluxe: json['deluxe'],
    );
  }
}
