import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:oraxproperty/data/api-request/countries_requests.dart';
import 'package:oraxproperty/presentation/my_ads/edit_my_ads/confirm_before_seding/viewmodel/edit_confirm_before_send_viewmodel.dart';

class EditChooseLocationViewModel extends ChangeNotifier {
  MapController adLocationMapController = MapController();

  double minZoomLevel = 5.0;
  double maxZoomLevel = 25.0;
  double initZoomLevel = 12.0;
  LatLng initialCenter = const LatLng(24.7213229, 46.718309);

  double currentCenterLat = 24.7213229;
  double currentCenterLng = 46.718309;

  List<String> mapStyles = [
    'https://api.maptiler.com/maps/streets-v2/{z}/{x}/{y}.png?key=wQyBzssE7OqQU2piVZdC',
  ];

  List<Placemark> placemarks = [];

  String mapEvent = '';

  bool? isCurrentChosenCountryAllowed;
  int? currentCountryId;

  // List allowedCountries = [];

  TextEditingController locationSearchController = TextEditingController();

  toggleNotifyListener() {
    notifyListeners();
  }

  void disposeModel() {
    adLocationMapController.dispose();
    super.dispose();
  }

  Future getGeoLocationFromCoordinates() async {
    placemarks = await placemarkFromCoordinates(
        currentCenterLat, currentCenterLng,
        /*localeIdentifier: 'ar_EG'*/);
  }

  Future getCoordinatesFromAddress() async {
    List<Location> locations =
        await locationFromAddress(locationSearchController.text);
    currentCenterLat = locations[0].latitude;
    currentCenterLng = locations[0].longitude;
    await getGeoLocationFromCoordinates();
    adLocationMapController.move(
        LatLng(currentCenterLat, currentCenterLng), 18);
    notifyListeners();
  }

  assignLocationToConfirmDetailsMap(String prevAddress){
    EditConfirmBeforeSendViewModel.propertyAdDetails['location_latlng'] =
        '$currentCenterLat,$currentCenterLng';

    if (placemarks.isNotEmpty) {
      EditConfirmBeforeSendViewModel.propertyAdDetails['location_address'] =
          '${placemarks[0].subLocality}, ${placemarks[0].locality}, ${placemarks[0].administrativeArea}';
    }else{
      EditConfirmBeforeSendViewModel.propertyAdDetails['location_address'] = prevAddress;
    }
    EditConfirmBeforeSendViewModel.propertyAdDetails['country'] =
        currentCountryId;
  }

  Future getAllowedCountries() async {
    CountriesRequests countriesRequests = CountriesRequests();
    try {
      final res = await countriesRequests.getListOfCountries();
      return res;
    } catch (e) {
      return e;
    }
  }

  checkIfCountryIsAllowed(String countryIso, List allowedCountries) {
    bool? isAllowed;
    for (var country in allowedCountries) {
      if (countryIso == country['country_iso']) {
        isAllowed = true;
        currentCountryId = country['id'];
        break;
      } else {
        isAllowed = false;
      }
    }
    isCurrentChosenCountryAllowed = isAllowed;
    return isAllowed;
  }
}
