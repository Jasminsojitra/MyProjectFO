import 'dart:async';
import 'package:festum_evento/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart' as loc;
import 'package:dio/dio.dart';
import 'package:festum_evento/screen/DeshboardEvent/screen/event_gallery.dart';
import 'package:festum_evento/utils/AppColors.dart';
import 'package:festum_evento/widget/bottom_button_widgets.dart';
import 'package:festum_evento/widget/edittext_widget.dart';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/toolbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../repository/arrangement_item_repository/location_repository.dart';
import '../../../view_models/controller/arragement_item/location_controller.dart';
import '../../../widget/cust_place_picker.dart';
import '../../../widget/uuid.dart';
import '../../LoadingComponent.dart';


class EventAddressScreen extends StatefulWidget {
  const EventAddressScreen({Key? key}) : super(key: key);

  @override
  State<EventAddressScreen> createState() => _EventAddressScreenState();
}

class _EventAddressScreenState extends State<EventAddressScreen> {


  final locationController = Get.put(LocationController());

  final locationKey = GlobalKey<FormState>();

  double? lat;

  double? long;

  String address = "";

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getLatLong() async {
    Future<Position> data = _determinePosition();
    data.then((value) {
      print("value $value");
      setState(() {
        lat = value.latitude;
        long = value.longitude;
      });
      moveToLocation(LatLng(lat!, long!));
      getAddress(value.latitude, value.longitude);
    }).catchError((error) {
      print("Error $error");
    });
  }

  //For convert lat long to address
  getAddress(lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    setState(() {
      address =
          '${placemarks[0].street}, ${placemarks[0].subLocality},${placemarks[0].subAdministrativeArea}, ${placemarks[0].postalCode}';

    });

    for (int i = 0; i < placemarks.length; i++) {
      print("INDEX $i ${placemarks[i]}");
    }
  }


  final Completer<GoogleMapController> mapController = Completer();
  LocationResult locationResult = new LocationResult();
  List<RichSuggestion> searchSuggestions = [];
  TextEditingController searchController = TextEditingController();
  String sessionToken = Uuid().generateV4();
  final Set<Marker> markers = Set();

  loc.LocationData? currentLocation;

  getLocation() async {
    try{
      try {
        print("STARTING LOCATION SERVICE");
        var location = loc.Location();
        location.changeSettings(
            interval: 1000, accuracy: loc.LocationAccuracy.high, distanceFilter: 0);
        bool hasPermit = await location.serviceEnabled();
        if (hasPermit != true) {
          await location.requestPermission();
          await location.requestService();
        } else if (hasPermit == false) {
          locationResult.formattedAddress = "Access denied";
        }
        currentLocation = await location.getLocation();
        print(currentLocation);
      }
      on PlatformException catch (e) {
        if (e.code == 'PERMISSION_DENIED') {
          var error = 'please grant permission';
          print(error);
          locationResult.formattedAddress = "Access denied for location Reopen app";
          openAppSettings();
          SystemNavigator.pop();
          return;
        }
        if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
          var error = 'permission denied- please enable it from app settings';
          print(error);
          locationResult.formattedAddress = "Access denied for location Reopen app";
          openAppSettings();
          SystemNavigator.pop();
          return;
        }
      }
      print("111");
      if (locationController.currentLatLng != null) {
        setState(() {
          locationController.currentLatLng = LatLng(locationController.currentLatLng!.latitude, locationController.currentLatLng!.longitude);
          moveToLocation(LatLng(locationController.currentLatLng!.latitude, locationController.currentLatLng!.longitude));
          setMarker(LatLng(locationController.currentLatLng!.latitude, locationController.currentLatLng!.longitude));
        });
        await getLocationData(lat: locationController.currentLatLng!.latitude, lng: locationController.currentLatLng!.longitude);
      }
    }catch(ex){
      print(ex);
    }
  }

  void onMapCreated(GoogleMapController controller) async {
    mapController.complete(controller);
    moveToCurrentUserLocation();
  }

  Future<void> moveToCurrentUserLocation() async {
    var location = loc.Location();
    await location.getLocation().then((locationData) {
      LatLng target = LatLng(locationData.latitude!, locationData.longitude!);
      setState(() {
        locationController.currentLatLng = target;
      });
      moveToLocation(target);
    }).catchError((error) {
      print(error);
    });
  }

  void moveToLocation(LatLng latLng) {
    this.mapController.future.then((controller) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: latLng,
            zoom: 15.0,
          ),
        ),
      );
    });
    setMarker(latLng);

    getLocationData(lat: latLng.latitude, lng: latLng.longitude, );
  }

  void setMarker(LatLng latLng) {
    locationController.currentLatLng=latLng;
    setState(() {
      markers.clear();
      markers.add(
        Marker(
          markerId: MarkerId("selected-location"),
          position: latLng,
        ),
      );
    });
  }

  getLocationData({
    required double lat,
    required double lng,
  }) async {
    LocationResult data = await LocationRepository.reverseGeocodeLatLng(lat, lng);
    setState(() {
      locationResult = data;
      List<String> address = locationResult!.formattedAddress!.split(",");
     locationController.flatNoEditingController.text= address[0];
     locationController.streetNameEditingController.text= address[1];
     locationController.areaNameEditingController.text=  address[2];
     locationController.cityEditingController.text=  locationResult.city!.isEmpty?address[address.length-3]:locationResult.city!;
     locationController.stateEditingController.text=  locationResult.state!;
     locationController.pincodeEditingController.text=  locationResult.pinCode!;
     locationController.locationEditingController.text=  locationResult.formattedAddress!;
    });
    print("222");
    // if (isForNavigator) {
    //   print("333");
    //   Navigator.pushAndRemoveUntil(
    //       context, MaterialPageRoute(builder: (context) => DashboardScreen(locationResult: locationResult)), (route) => false);
    // }
  }

  Future autoCompleteSearch(String place) async {
    print("autoCompleteSearch - " + place);
    place = place.replaceAll(" ", "+");
    var endpoint =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?" + "key=${Utils.mapKey}&" + "input={$place}&sessiontoken=${sessionToken}";

    if (locationResult.latLng != null) {
      endpoint += "&location=${locationResult.latLng!.latitude}," + "${locationResult.latLng!.longitude}";
      LatLng latLng = LatLng(locationResult.latLng!.latitude, locationResult.latLng!.longitude);

      setState(() {
        locationController.currentLatLng = latLng;
        moveToLocation(latLng);
        setMarker(latLng);
      });
    }
    Dio dio = new Dio();

    try {
      var response = await dio.get(endpoint);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        List<dynamic> predictions = data['predictions'];

        List<RichSuggestion> suggestions = [];

        if (predictions.isEmpty) {
          if(searchController.text.isEmpty){
            searchController.text="";
            searchSuggestions=[];
            suggestions.clear();
            searchController.clear();
          }else {
            AutoCompleteItem aci = AutoCompleteItem();
            aci.text = "No result found";
            aci.offset = 0;
            aci.length = 0;

            suggestions.add(RichSuggestion(aci, () {}));
          }
        } else {
          for (dynamic t in predictions) {
            AutoCompleteItem aci = AutoCompleteItem();

            aci.id = t['place_id'];
            aci.text = t['description'];
            aci.offset = t['matched_substrings'][0]['offset'];
            aci.length = t['matched_substrings'][0]['length'];
            if(suggestions.length<3)
            suggestions.add(RichSuggestion(aci, () {
              FocusScope.of(context).requestFocus(FocusNode());
              searchController.text="";
              searchSuggestions=[];
              searchController.clear();
              decodeAndSelectPlace(aci.id!);
            }));
          }
        }
        setState(() {
          searchSuggestions = suggestions;
          print("searchSuggestions" + suggestions.length.toString());
        });

        //displayAutoCompleteSuggestions(suggestions);
      }
    } catch (error) {
      print("PlaceError" + error.toString());
    }
  }

  fetchCurrentLocation() async {

  }

  decodeAndSelectPlace(String placeId) async {
    String endpoint = "https://maps.googleapis.com/maps/api/place/details/json?key=${Utils.mapKey}" + "&placeid=$placeId";

    try {
      Dio dio = new Dio();
      var response = await dio.get(endpoint);
      if (response.statusCode == 200) {
        Map<String, dynamic> location = response.data['result']['geometry']['location'];

        await getLocationData(lat: location['lat'], lng: location['lng'], );
        setState(() {
          locationController.currentLatLng = LatLng(location['lat'], location['lng']);
          moveToLocation(LatLng(location['lat'], location['lng']));
          setMarker(LatLng(location['lat'], location['lng']));
        });
      }
    } catch (error) {
      print("decodeAndSelectPlace" + error.toString());
    }
    ;
  }


  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      locationController.getLocation().then((value) {
        if(value!=200){
          getLatLong();
          getLocation();
        }
        else{
          moveToLocation(LatLng(locationController.currentLatLng!.latitude!, locationController.currentLatLng!.longitude!));
          this.mapController.future.then((controller) {
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: locationController.currentLatLng!,
                  zoom: 15.0,
                ),
              ),
            );
          });
          setMarker(locationController.currentLatLng!);
        }
      });

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingComponent(
        child:Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(0, 0), child: AppBar(elevation: 0)),
      backgroundColor: AppColors.edtBgColor,
      bottomNavigationBar: BottomButtonWidgets(
          onBackPress: () {
            Navigator.pop(context);
          },
          onNextPress: () {
            locationController.addArrangementEventApi();
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => EventGalleryScreen()));
          },
          firstTxt: 'back'.tr,
          secondTxt: 'next'.tr),
      body: Form(
        key: locationKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToolbarWidget(
                text
                    : 'let_create_it'.tr,
                tapCallback: () {
                  Navigator.pop(context);
                }),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SmallText(
                          text: "Address by google map".tr, color: AppColors.greyColor, size: 14),
                      const SizedBox(height: 20),
                      Container(height: 300,
                        child: Stack(

                          children: [
                            Container(
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: locationController.currentLatLng == null ? LatLng(5.67, 6.67) : locationController.currentLatLng!,
                                  zoom: 15,
                                ),
                                myLocationButtonEnabled: true,
                                myLocationEnabled: true,
                                zoomGesturesEnabled: true,
                                tiltGesturesEnabled: false,

                                onCameraMove:(CameraPosition cameraPosition){
                                  print(cameraPosition.zoom);
                                },
                                onMapCreated: onMapCreated,
                                onTap: (latLng) {
                                  moveToLocation(latLng);
                                },
                                markers: markers,
                              ),
                            ),

                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: new BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(color: AppColors.appColor.withAlpha(50))),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                                    child: TextField(
                                      controller: searchController,
                                      onChanged: (String value) {
                                        autoCompleteSearch(value);
                                      },
                                      decoration: InputDecoration(border: InputBorder.none,
                                          hintText: 'Search Location'.tr,
                                          hintStyle: TextStyle(fontSize: 14)),
                                    ),
                                  ),
                                ),
                                ListView(
                                  padding: EdgeInsets.only(bottom: 0),
                                  shrinkWrap: true,
                                  children: searchSuggestions,
                                ),

                              ],
                            ),


                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      EditTextWidget(
                          line: 1,
                          isCompulsoryText: false,
                          text: 'flat_no'.tr,
                          textEditingController: locationController.flatNoEditingController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.name,
                          validator: (value) {

                            return null;
                          },
                          bgColor: Colors.white),
                      const SizedBox(height: 20),
                      EditTextWidget(
                          line: 1,
                          isCompulsoryText: false,
                          text: 'street_name'.tr,
                          textEditingController: locationController.streetNameEditingController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.name,
                          validator: (value) {

                            return null;
                          },
                          bgColor: Colors.white),
                      const SizedBox(height: 20),
                      EditTextWidget(
                          line: 1,
                          isCompulsoryText: false,
                          text: 'area_name'.tr,
                          textEditingController: locationController.areaNameEditingController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter_area_name'.tr;
                            }
                            return null;
                          },
                          bgColor: Colors.white),
                      const SizedBox(height: 20),
                      EditTextWidget(
                          line: 1,
                          enable: false,
                          isCompulsoryText: false,
                          text: 'city'.tr,
                          textEditingController: locationController.cityEditingController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter_city'.tr;
                            }
                            return null;
                          },
                          bgColor: Colors.white),
                      const SizedBox(height: 20),
                      EditTextWidget(
                          line: 1,
                          enable: false,
                          isCompulsoryText: false,
                          text: 'state'.tr,
                          textEditingController: locationController.stateEditingController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter_state'.tr;
                            }
                            return null;
                          },
                          bgColor: Colors.white),
                      const SizedBox(height: 20),
                      EditTextWidget(
                          line: 1,
                          enable: false,
                          isCompulsoryText: false,
                          text: 'pincode'.tr,
                          textEditingController: locationController.pincodeEditingController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter pincode'.tr;
                            }
                            return null;
                          },
                          bgColor: Colors.white),
                      const SizedBox(height: 20),
                      Text('Manual address ( If address from the google map is not accurate, you can write it manually. )'.tr,
                          style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: AppColors.greyColor)),
                      const SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: locationController.locationEditingController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5),
                                  hintText: 'type_here_address'.tr,
                                  helperStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide.none)),
                              textAlign: TextAlign.start,
                              maxLines: 3,
                              textAlignVertical: TextAlignVertical.top,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
