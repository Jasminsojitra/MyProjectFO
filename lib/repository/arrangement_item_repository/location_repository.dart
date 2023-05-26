
import 'package:http/http.dart' as http;

import '../../data/network/network_api_services.dart';
import '../../model/arrangement_item_model/location_model.dart';
import '../../screen/DeshboardEvent/Model/LocationModel.dart';
import '../../utils/app_url.dart';
import '../../utils/utils.dart';
import '../../widget/cust_place_picker.dart';

class LocationRepository
{
  final api = NetworkApiServices();
  static Future reverseGeocodeLatLng(double lat, double lng) async {

    LocationResult locationResult = new LocationResult();
    http.Response response = await http.get(
      Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?" + "latlng=$lat,$lng&" + "key=${Utils.mapKey}"),
    );
    LocationResponseModel data = locationResponseModelFromJson(response.body);
    String? road = data.results!.first.addressComponents!.first.shortName;
    String? locality = data.results!.first.addressComponents!.first.shortName;
    String? state = Utils.findResult(data.results!.first!.addressComponents!, "administrative_area_level_1");
    String? city = Utils.findResult(data.results!.first!.addressComponents!, "administrative_area_level_2");
    String? pinCode = Utils.findResult(data.results!.first!.addressComponents!, "postal_code");
    String? country = Utils.findResult(data.results!.first!.addressComponents!, "country");

    locationResult = LocationResult();
    locationResult.name = road;
    locationResult.locality = locality;
    locationResult.setLatLng(lat, lng);
    locationResult.formattedAddress = data.results!.first.formattedAddress;
    locationResult.placeId = data.results!.first.placeId;
    locationResult.state = state;
    locationResult.city = city;
    locationResult.pinCode = pinCode;
    locationResult.country = country;
    Utils.locationResult = locationResult;
    return locationResult;
  }

  Future<LocationModel> getLocationRepo(id) async {
    var response = await api.getApiWithToken(AppUrl.getEventLocation+id);
    return LocationModel.fromJson(response.toJson());
  }

  //Add Arrangment
  Future<dynamic> postLocationRepo(var data) async {
    final response = await api.postApiWithToken(data, AppUrl.postEventLocation);
    return response;
  }

}