import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:socialv/models/tourvisor/departure_model.dart';
import 'package:socialv/models/tourvisor/hotel_lists.dart';
import 'package:socialv/models/tourvisor/hotel_service_groups.dart';
import 'package:socialv/models/tourvisor/hotel_type.dart';
import 'package:socialv/models/tourvisor/search_travel.dart';
import 'package:socialv/models/tourvisor/tour_details_model.dart';
import 'package:socialv/models/tourvisor/tour_offer_model.dart';
import 'package:socialv/models/tourvisor/travel_offer_model.dart';
import 'package:socialv/utils/constants.dart';

import 'package:url_launcher/url_launcher.dart';

class TourvisorService {
  static const String urlTourAgency = 'https://vv-travel.kz';
  static const String numberWhatsAppTourAgency = '+77073753464';
  static const String baseUrl = 'https://tourvisor.ru/xml/listdev.php';
  static const String offersUrl = 'https://tourvisor.ru/xml/modmin.php';
  static const String hotelsUrl = 'https://tourvisor.ru/xml/modhot.php';
  static const String hotelsAcTypes =
      'https://tourvisor.ru/api/v1.1/hotel-actypes/all';
  static const String hotelServiceGroup =
      'https://tourvisor.ru/api/v1.1/hotel-service-groups/all';
  static const String tourDetailsUrl = 'http://tourvisor.ru/xml/modact.php';
  static const String gerSearchRequest =
      'http://tourvisor.ru/xml/modsearch.php';
  static const String searchTour = 'https://search3.tourvisor.ru/modresult.php';

  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'ORIGIN': urlTourAgency,
    'Referer': urlTourAgency,
  };

  static Future<void> sendOrder(String? tourID) async {
    if (tourID != null) {
      String urlTour = 'https://travello.kz/%23tvtourid=$tourID';
      String url =
          'https://wa.me/$numberWhatsAppTourAgency/?text=Здравствуйте, пишем вам с мобильного приложения, хотели бы уточнить у вас по поводу тура $urlTour';
      await launchUrl(Uri.parse(url));
    }
  }

  Future<List<Departure>> getDepartures() async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl?type=departure,allcountry,country,region,subregions,operator&cndep=60&flydeparture=60&flycountry=0&format=json&referrer=$urlTourAgency'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final Map<String, dynamic>? lists =
          body['lists'] as Map<String, dynamic>?;

      if (lists != null) {
        final Map<String, dynamic>? departures =
            lists['departures'] as Map<String, dynamic>?;

        if (departures != null) {
          final List<dynamic>? data = departures['departure'] as List<dynamic>?;

          if (data != null) {
            return data.map((json) => Departure.fromJson(json)).toList();
          }
        }
      }
    }

    throw Exception('Failed to load departures');
  }

  Future<List<Departure>> getCountries() async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl?type=departure,allcountry,country,region,subregions,operator&cndep=60&flydeparture=60&flycountry=0&format=json&referrer=$urlTourAgency'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final Map<String, dynamic>? lists =
          body['lists'] as Map<String, dynamic>?;

      if (lists != null) {
        final Map<String, dynamic>? departures =
            lists['countries'] as Map<String, dynamic>?;

        if (departures != null) {
          final List<dynamic>? data = departures['country'] as List<dynamic>?;

          if (data != null) {
            return data.map((json) => Departure.fromJson(json)).toList();
          }
        }
      }
    }

    throw Exception('Failed to load departures');
  }

  Future<List<TravelOffer>> getTravelOffers({required int cityCode}) async {
    final response = await http.get(
      Uri.parse(
          '$offersUrl?format=json&city=$cityCode&regular=1&theme=theme2&areatype=1,2&theme=theme2&view=4&referrer=$urlTourAgency'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final Map<String, dynamic>? data = body['data'] as Map<String, dynamic>?;

      if (data != null) {
        final List<dynamic>? minprice = data['minprice'] as List<dynamic>?;

        if (minprice != null) {
          return minprice.map((json) => TravelOffer.fromJson(json)).toList();
        }
      }
    }

    throw Exception('Failed to load travel offers');
  }

  Future<List<TourOffer>> getHotTours() async {
    final response = await http.get(
      Uri.parse(
          '$hotelsUrl?format=json&city=$globalSelectedCityFrom&referrer=$urlTourAgency'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final List<dynamic>? hot = body['hot'] as List<dynamic>?;

      if (hot != null) {
        return hot.map((json) => TourOffer.fromJson(json)).toList();
      }
    }

    throw Exception('Failed to load hotels');
  }

  Future<TourDetailsResponse?> getTourDetails({required String tourId}) async {
    final response = await http.get(
      Uri.parse('$tourDetailsUrl?tourid=$tourId&referrer=$urlTourAgency'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return TourDetailsResponse.fromJson(jsonResponse);
    } else {
      print("Ошибка запроса: ${response.statusCode}");
      return null;
    }
  }

  Future<int?> getSearchId({
    required String datefrom,
    required String dateto,
    required String country,
    required String departure,
    required String adults,
    required String child,
    required String nightsFrom,
    required String nightsTo,
    required String mealType,
    required String ratingType,
    required String minBudget,
    required String maxBudget,
    required String hotelTypes,
  }) async {
    final response = await http.get(
      Uri.parse(
          '$gerSearchRequest?datefrom=$datefrom&dateto=$dateto&adults=$adults&child=$child&country=$country&departure=$departure&referrer=$urlTourAgency&nightsfrom=$nightsFrom&nightsto=$nightsTo&meal=$mealType&rating=$ratingType&pricefrom=$minBudget&priceto=$maxBudget&actype=$hotelTypes'),
      headers: headers,
    );
    print(
        '$gerSearchRequest?datefrom=$datefrom&dateto=$dateto&adults=$adults&child=$child&country=$country&departure=$departure&referrer=$urlTourAgency&nightsfrom=$nightsFrom&nightsto=$nightsTo&meal=$mealType&rating=$ratingType&pricefrom=$minBudget&priceto=$maxBudget&actype=$hotelTypes');
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse['result']['requestid'];
  }

  Future<ApiResponse?> getListTours({
    required int requestid,
  }) async {
    final response = await http.get(
      Uri.parse(
          '$searchTour?json&requestid=$requestid&referrer=$urlTourAgency'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final apiResponse = ApiResponse.fromJson(jsonResponse);
      return apiResponse;
    } else {
      throw Exception('Ошибка запроса');
    }
  }

  List<TourOffer> getTourOfApiResponse(ApiResponse apiResponse) {
    List<TourOffer> listTourOffer = [];
    if (apiResponse.data != null && apiResponse.data!.block != null) {
      for (var blockElement in apiResponse.data!.block!) {
        for (var hotelElement in blockElement.hotel!) {
          listTourOffer.add(TourOffer(
            tourId2: hotelElement.tour?[0].tourId,
            hotelPicture: apiResponse
                .data?.decode?.hotels?[hotelElement.id.toString()]?.pic,
            hotelName: apiResponse
                .data?.decode?.hotels?[hotelElement.id.toString()]?.name,
            countryName: apiResponse
                .data?.decode?.hotels?[hotelElement.id.toString()]?.country,
            hotelRegionName: apiResponse
                .data?.decode?.hotels?[hotelElement.id.toString()]?.region,
            nights: hotelElement.tour?[0].nt.toString(),
            meal: apiResponse
                .data?.decode?.meal?[hotelElement.tour?[0].ml.toString()]?.name,
            hotelStars: apiResponse
                .data?.decode?.hotels?[hotelElement.id.toString()]?.stars,
            flyDate: DateFormat('dd.MM.yyyy')
                .format(DateTime.parse(hotelElement.tour?[0].dt ?? ''))
                .toString(),
            price: hotelElement.tour?[0].pr.toString(),
          ));
        }
      }
    }
    return listTourOffer;
  }

  Future<List<HotelType>> getHotelTypes() async {
    final response = await http.get(
      Uri.parse(
          '$hotelsAcTypes?active=true&sortProp=order&countryId=$globalSelectedCityTo&referrer=$urlTourAgency'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => HotelType.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<List<HotelServiceGroup>> getHotelServiceGroup() async {
    final response = await http.get(Uri.parse(
        '$hotelServiceGroup?sortDir=desc&sortProp=order&countryId=$globalSelectedCityTo&referrer=$urlTourAgency'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => HotelServiceGroup.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load hotel service groups');
    }
  }

  Future<HotelListDepartureModel> getHotelLists() async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl?type=allhotel&hotcountry=$globalSelectedCityTo&format=json&referrer=$urlTourAgency'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final apiResponse = HotelListDepartureModel.fromJson(jsonResponse);
      return apiResponse;
    } else {
      throw Exception('Ошибка запроса');
    }
  }

  // Add other methods for various requests to the Tourvisor API
  // For example, a method to get a list of countries, regions, etc.
}
