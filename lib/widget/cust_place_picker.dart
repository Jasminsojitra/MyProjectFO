import 'dart:async';
import 'dart:convert';
import 'package:festum_evento/widget/small_text.dart';
import 'package:festum_evento/widget/uuid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

import '../utils/AppColors.dart';


/// The result returned after completing location selection.
class LocationResult {
  /// The human readable name of the location. This is primarily the
  /// name of the road. But in cases where the place was selected from Nearby
  /// places list, we use the <b>name</b> provided on the list item.
  String? name; // or road

  /// The human readable locality of the location.
  String? locality;

  /// Latitude/Longitude of the selected location.
  LatLng? latLng;

  /// Formatted address suggested by Google
  String? formattedAddress = "";

  String? placeId;

  String? state;

  String? city;

  String? pinCode;

  String? country;

  setLatLng(double lat, double lng) {
    this.latLng = new LatLng(lat, lng);
  }
}

/// Nearby place data will be deserialized into this model.
class NearbyPlace {
  /// The human-readable name of the location provided. This value is provided
  /// for [LocationResult.name] when the user selects this nearby place.
  String? name;

  /// The icon identifying the kind of place provided. Eg. lodging, chapel,
  /// hospital, etc.
  String? icon;

  // Latitude/Longitude of the provided location.
  LatLng? latLng;
}

/// Autocomplete results item returned from Google will be deserialized
/// into this model.
class AutoCompleteItem {
  /// The id of the place. This helps to fetch the lat,lng of the place.
  String? id;

  /// The text (name of place) displayed in the autocomplete suggestions list.
  String? text;

  /// Assistive index to begin highlight of matched part of the [text] with
  /// the original query
  int? offset;

  /// Length of matched part of the [text]
  int? length;
}

/// Place picker widget made with map widget from
/// [google_maps_flutter](https://github.com/flutter/plugins/tree/master/packages/google_maps_flutter)
/// and other API calls to [Google Places API](https://developers.google.com/places/web-service/int?ro)
///
/// API key provided should have `Maps SDK for Android`, `Maps SDK for iOS`
/// and `Places API`  enabled for it
class PlacePicker extends StatefulWidget {
  /// API key generated from Google Cloud Console. You can get an API key
  /// [here](https://cloud.google.com/maps-platform/)
  final String? apiKey;

  /// Location to be displayed when screen is showed. If this is set or not null, the
  /// map does not pan to the user's current location.
  final LatLng? displayLocation;

  PlacePicker(this.apiKey, {this.displayLocation});

  @override
  State<StatefulWidget> createState() {
    return PlacePickerState();
  }
}

/// Place picker state
class PlacePickerState extends State<PlacePicker> {
  final Completer<GoogleMapController> mapController = Completer();

  /// Indicator for the selected location
  final Set<Marker> markers = Set();

  /// Result returned after user completes selection
  LocationResult? locationResult;

  /// Overlay to display autocomplete suggestions
  OverlayEntry? overlayEntry;

  List<NearbyPlace> nearbyPlaces = [];

  /// Session token required for autocomplete API call
  String? sessionToken = Uuid().generateV4();

  GlobalKey appBarKey = GlobalKey();

  bool hasSearchTerm = false;

  String previousSearchTerm = '';

  // constructor
  // PlacePickerState();

  void onMapCreated(GoogleMapController controller) {
    this.mapController.complete(controller);
    moveToCurrentUserLocation();
  }

  @override
  void setState(fn) {
    if (this.mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    markers.add(Marker(
      position: widget.displayLocation ?? LatLng(5.6037, 0.1870),
      markerId: MarkerId("selected-location"),
    ));
  }

  @override
  void dispose() {
    this.overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          key: this.appBarKey,
          title: SearchInput((it) {
            searchPlace(it);
          }),
          centerTitle: true,
          leading: null,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.appColor),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: widget.displayLocation ?? LatLng(5.6037, 0.1870),
                zoom: 15,
              ),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onMapCreated: onMapCreated,
              onTap: (latLng) {
                clearOverlay();
                moveToLocation(latLng);
              },
              markers: markers,
            ),
          ),
          this.hasSearchTerm
              ? SizedBox()
              : Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SelectPlaceAction(getLocationName(), () {
                  Navigator.of(context).pop(this.locationResult);
                }),
                Divider(
                  height: 8,
                ),
                Expanded(
                  child: ListView(
                    children: this
                        .nearbyPlaces
                        .map((it) => NearbyPlaceItem(it, () {
                      moveToLocation(it.latLng!);
                    }))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Hides the autocomplete overlay
  void clearOverlay() {
    if (this.overlayEntry != null) {
      this.overlayEntry!.remove();
      this.overlayEntry = null;
    }
  }

  /// Begins the search process by displaying a "wait" overlay then
  /// proceeds to fetch the autocomplete list. The bottom "dialog"
  /// is hidden so as to give more room and better experience for the
  /// autocomplete list overlay.
  void searchPlace(String place) {
    // on keyboard dismissal, the search was being triggered again
    // this is to cap that.
    if (place == this.previousSearchTerm) {
      return;
    } else {
      previousSearchTerm = place;
    }

    if (context == null) {
      return;
    }

    clearOverlay();

    setState(() {
      hasSearchTerm = place.length > 0;
    });

    if (place.length < 1) {
      return;
    }

    final RenderBox renderBox = context.findRenderObject()as RenderBox;
    Size size = renderBox!.size;

    final RenderBox appBarBox =
    this.appBarKey.currentContext!.findRenderObject() as RenderBox;

    this.overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: appBarBox.size.height,
        width: size.width,
        child: Material(
          elevation: 1,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 24,
                ),
                // Expanded(
                //   child: UxText(
                //       text:"Finding place...".tr(), size:19, fw:FontWeight.w200, color:Palette.second),
                // )
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)!.insert(this.overlayEntry!);

    autoCompleteSearch(place);
  }

  /// Fetches the place autocomplete list with the query [place].
  void autoCompleteSearch(String place) {
    place = place.replaceAll(" ", "+");
    var endpoint =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?" +
            "key=${widget.apiKey}&" +
            "input={$place}&sessiontoken=${this.sessionToken}";

    if (this.locationResult != null) {
      endpoint += "&location=${this.locationResult!.latLng!.latitude}," +
          "${this.locationResult!.latLng!.longitude}";
    }
    http.get(Uri.parse(endpoint)).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> predictions = data['predictions'];

        List<RichSuggestion> suggestions = [];

        if (predictions.isEmpty) {
          AutoCompleteItem aci = AutoCompleteItem();
          aci.text = "No result found".tr;
          aci.offset = 0;
          aci.length = 0;

          suggestions.add(RichSuggestion(aci, () {}));
        } else {
          for (dynamic t in predictions) {
            AutoCompleteItem aci = AutoCompleteItem();

            aci.id = t['place_id'];
            aci.text = t['description'];
            aci.offset = t['matched_substrings'][0]['offset'];
            aci.length = t['matched_subString?s'][0]['length'];

            suggestions.add(RichSuggestion(aci, () {
              FocusScope.of(context).requestFocus(FocusNode());
              decodeAndSelectPlace(aci.id);
            }));
          }
        }

        displayAutoCompleteSuggestions(suggestions);
      }
    }).catchError((error) {
      print(error);
    });
  }

  /// To navigate to the selected place from the autocomplete list to the map,
  /// the lat,lng is required. This method fetches the lat,lng of the place and
  /// proceeds to moving the map to that location.
  void decodeAndSelectPlace(String? placeId) {
    clearOverlay();

    String endpoint =
        "https://maps.googleapis.com/maps/api/place/details/json?key=${widget.apiKey}" +
            "&placeid=$placeId";

    http.get(Uri.parse(endpoint)).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> location =
        jsonDecode(response.body)['result']['geometry']['location'];

        LatLng latLng = LatLng(location['lat'], location['lng']);

        moveToLocation(latLng);
      }
    }).catchError((error) {
      print(error);
    });
  }

  /// Display autocomplete suggestions with the overlay.
  void displayAutoCompleteSuggestions(List<RichSuggestion> suggestions) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;

    final RenderBox appBarBox =
    this.appBarKey.currentContext!.findRenderObject() as RenderBox;

    clearOverlay();

    this.overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        top: appBarBox.size.height,
        child: Material(
          elevation: 1,
          color: Colors.white,
          child: Column(
            children: suggestions,
          ),
        ),
      ),
    );

    Overlay.of(context)!.insert(this.overlayEntry!);
  }

  /// Utility function to get clean readable name of a location. First checks
  /// for a human-readable name from the nearby list. This helps in the cases
  /// that the user selects from the nearby list (and expects to see that as a
  /// result, instead of road name). If no name is found from the nearby list,
  /// then the road name returned is used instead.
  String getLocationName() {
    if (this.locationResult == null) {
      return "Unnamed location";
    }

    for (NearbyPlace np in this.nearbyPlaces) {
      if (np.latLng == this.locationResult!.latLng &&
          np.name != this.locationResult!.locality) {
        this.locationResult!.name = np.name;
        return "${np.name}, ${this.locationResult!.locality}";
      }
    }

    return "${this.locationResult!.name}, ${this.locationResult!.locality}";
  }

  /// Moves the marker to the indicated lat,lng
  void setMarker(LatLng latLng) {
    // markers.clear();
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

  /// Fetches and updates the nearby places to the provided lat,lng
  void getNearbyPlaces(LatLng latLng) {
    http
        .get(Uri.parse("https://maps.googleapis.com/maps/api/place/nearbysearch/json?" +
        "key=${widget.apiKey}&" +
        "location=${latLng.latitude},${latLng.longitude}&radius=150"))
        .then((response) {
      if (response.statusCode == 200) {
        this.nearbyPlaces.clear();
        for (Map<String, dynamic> item
        in jsonDecode(response.body)['results']) {
          NearbyPlace nearbyPlace = NearbyPlace();

          nearbyPlace.name = item['name'];
          nearbyPlace.icon = item['icon'];
          double latitude = item['geometry']['location']['lat'];
          double longitude = item['geometry']['location']['lng'];

          LatLng _latLng = LatLng(latitude, longitude);

          nearbyPlace.latLng = _latLng;

          this.nearbyPlaces.add(nearbyPlace);
        }
      }

      // to update the nearby places
      setState(() {
        // this is to require the result to show
        this.hasSearchTerm = false;
      });
    }).catchError((error) {});
  }

  String findResult(dynamic results, key) {
    for (int i = 0; i < results.length; i++) {
      for (int j = 0; j < results[i]["types"].length; j++) {
        if (results[i]["types"][j] == key) {
          return results[i]["long_name"];
        }
      }
    }
    return "";
  }

  /// This method gets the human readable name of the location. Mostly appears
  /// to be the road name and the locality.
  void reverseGeocodeLatLng(LatLng latLng) {
    http
        .get(Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?" +
        "latlng=${latLng.latitude},${latLng.longitude}&" +
        "key=${widget.apiKey}"))
        .then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = jsonDecode(response.body);

        final result = responseJson['results'][0];

        String? road = result['address_components'][0]['short_name'];
        String? locality = result['address_components'][1]['short_name'];
        String? state = findResult(
            result['address_components'], "administrative_area_level_1");
        String? city = findResult(
            result['address_components'], "administrative_area_level_2");
        String? pinCode =
        findResult(result['address_components'], "postal_code");
        String? country = findResult(result['address_components'], "country");

        setState(() {
          this.locationResult = LocationResult();
          this.locationResult!.name = road;
          this.locationResult!.locality = locality;
          this.locationResult!.latLng = latLng;
          this.locationResult!.formattedAddress = result['formatted_address'];
          this.locationResult!.placeId = result['place_id'];
          this.locationResult!.state = state;
          this.locationResult!.city = city;
          this.locationResult!.pinCode = pinCode;
          this.locationResult!.country = country;
        });
      }
    }).catchError((error) {
      //throw(error);
      print(error);
    });
  }

  /// Moves the camera to the provided location and updates other UI features to
  /// match the location.
  void moveToLocation(LatLng? latLng) {
    this.mapController.future.then((controller) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: latLng!,
            zoom: 15.0,
          ),
        ),
      );
    });

    setMarker(latLng!);

    reverseGeocodeLatLng(latLng);

    getNearbyPlaces(latLng);
  }

  void moveToCurrentUserLocation() {
    if (widget.displayLocation != null) {
      moveToLocation(widget.displayLocation);
      return;
    }

    var location = Location();
    location.getLocation().then((locationData) {
      LatLng target = LatLng(locationData.latitude!, locationData.longitude!);
      moveToLocation(target);
    }).catchError((error) {
      print(error);
    });
  }
}

/// Custom Search input field, showing the search and clear icons.
class SearchInput extends StatefulWidget {
  final ValueChanged<String> onSearchInput;

  SearchInput(this.onSearchInput);

  @override
  State<StatefulWidget> createState() {
    return SearchInputState();
  }
}

class SearchInputState extends State<SearchInput> {
  TextEditingController editController = TextEditingController();

  Timer? debouncer;

  bool hasSearchEntry = false;


  @override
  void initState() {
    super.initState();
    this.editController.addListener(this.onSearchInputChange);
  }

  @override
  void dispose() {
    this.editController.removeListener(this.onSearchInputChange);
    this.editController.dispose();

    super.dispose();
  }

  void onSearchInputChange() {
    if (this.editController.text.isEmpty) {
      this.debouncer?.cancel();
      widget.onSearchInput(this.editController.text);
      return;
    }

    if (this.debouncer?.isActive ?? false) {
      this.debouncer!.cancel();
    }

    this.debouncer = Timer(Duration(milliseconds: 500), () {
      widget.onSearchInput(this.editController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.search,
            color: Colors.black,
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search place".tr,
                hintStyle: TextStyle(
                    fontFamily: 'Helvetica',
                    fontSize: 15,
                    color: AppColors.greyColor),
                border: InputBorder.none,
              ),
              controller: this.editController,
              style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontSize: 15,
                  color: AppColors.appColor),
              onChanged: (value) {
                setState(() {
                  this.hasSearchEntry = value.isNotEmpty;
                });
              },
            ),
          ),
          SizedBox(
            width: 8,
          ),
          this.hasSearchEntry
              ? GestureDetector(
            child: Icon(
              Icons.clear,
            ),
            onTap: () {
              this.editController.clear();
              setState(() {
                this.hasSearchEntry = false;
              });
            },
          )
              : SizedBox(),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[100],
      ),
    );
  }
}

class SelectPlaceAction extends StatelessWidget {
  final String? locationName;
  final VoidCallback onTap;

  SelectPlaceAction(this.locationName, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          this.onTap();
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SmallText(
                        text: locationName!, size: 16, color: AppColors.appColor),
                    //UxText(text:locationName!, size:16, fw:FontWeight.w500, color:AppColors.appColor),
                    SmallText(
                        text: "Tap to select this location".tr, size: 16, color: AppColors.appColor,fontWeight: FontWeight.w200),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NearbyPlaceItem extends StatelessWidget {
  final NearbyPlace nearbyPlace;
  final VoidCallback onTap;

  NearbyPlaceItem(this.nearbyPlace, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            child: Row(
              children: <Widget>[
                Image.network(
                  nearbyPlace.icon!,
                  width: 16,
                ),
                SizedBox(
                  width: 24,
                ),
                Expanded(
                  child: SmallText(
                      text: "${nearbyPlace.name}", size: 16,
                      color: AppColors.appColor,fontWeight: FontWeight.w500,),
                )
              ],
            )),
      ),
    );
  }
}

class RichSuggestion extends StatelessWidget {
  final VoidCallback onTap;
  final AutoCompleteItem autoCompleteItem;

  RichSuggestion(this.autoCompleteItem, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RichText(
                    text: TextSpan(children: getStyledTexts(context)),
                  ),
                )
              ],
            )),
        onTap: this.onTap,
      ),
    );
  }

  List<TextSpan> getStyledTexts(BuildContext context) {
    final List<TextSpan> result = [];

    String? startText =
    this.autoCompleteItem.text!.substring(0, this.autoCompleteItem.offset);
    if (startText.isNotEmpty) {
      result.add(
        TextSpan(
          text: startText,
          style: TextStyle(
            color: AppColors.appColor,
            fontWeight: FontWeight.w200,
            fontSize: 15,
          ),
        ),
      );
    }

    String? boldText = this.autoCompleteItem.text!.substring(
        this.autoCompleteItem.offset!,
        this.autoCompleteItem.offset! + this.autoCompleteItem.length!);

    result.add(TextSpan(
      text: boldText,
      style: TextStyle(
        color: AppColors.appColor,
        fontSize: 15,
      ),
    ));

    String remainingText = this
        .autoCompleteItem
        .text!
        .substring(this.autoCompleteItem.offset! + this.autoCompleteItem.length!);
    result.add(
      TextSpan(
        text: remainingText,
        style: TextStyle(
          fontFamily: 'Helvetica',
          color: AppColors.appColor,
          fontWeight: FontWeight.w200,
          fontSize: 15,
        ),
      ),
    );

    return result;
  }
}
