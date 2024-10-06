import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:oraxproperty/app/value_holders.dart';
import 'package:oraxproperty/data/api-request/get_ad_details.dart';
import 'package:oraxproperty/data/api-request/get_advertisments.dart';
import 'package:oraxproperty/data/api-request/get_user_details.dart';
import 'package:oraxproperty/main.dart';

// import 'package:syncfusion_flutter_maps/maps.dart' as sf_map;

class HomepageViewModel extends ChangeNotifier {
  MapController mapController = MapController();
  // sf_map.MapTileLayerController mapTileLayerController =
  //     sf_map.MapTileLayerController();
  TextEditingController searchController = TextEditingController();

  double minZoomLevel = 5.0;
  double maxZoomLevel = 25.0;
  double initZoomLevel = 13.0;
  LatLng initialCenter = const LatLng(24.7213229, 46.718309);

  List<String> mapStyles = [
    'https://api.maptiler.com/maps/streets-v2/{z}/{x}/{y}.png?key=wQyBzssE7OqQU2piVZdC',
    'https://api.mapbox.com/styles/v1/dvzeyad/clevk3a17001i01npc9cuifsx/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZHZ6ZXlhZCIsImEiOiJjbDQ1cmc5amEwMG1yM21tb2p3c3B3bHl6In0.dYmOPn5-M5-l5dW469lCDw',
  ];
  List<String> mapStylesLabels = ['Default'];

  Map adData = {};
  String adCategroy = '';

  // sf_map.MapZoomPanBehavior zoomPanBehavior = sf_map.MapZoomPanBehavior(
  //   focalLatLng: const sf_map.MapLatLng(24.7213229, 46.718309),
  //   minZoomLevel: 5.0,
  //   maxZoomLevel: 20,
  //   zoomLevel: 10.0,
  // );

  double adOffsetLeftPosition = 0.0;
  double adOffsetBottomPosition = 0.0;
  bool adContainerIsVisible = false;

  Future? currentAdFuture;

  void showAdWidget(double offsetBottomPosition) {
    adContainerIsVisible = true;
    adOffsetBottomPosition = offsetBottomPosition;
    notifyListeners();
  }

  Future<void> hideAdWiget() async {
    adOffsetBottomPosition = 0.0;
    adContainerIsVisible = false;
    notifyListeners();
  }

  Future getAdsForMap() async {
    GetAdvertisementsRequest getAdvertisementsRequest =
        GetAdvertisementsRequest();
    try {
      var res = await getAdvertisementsRequest.getAdvertisementsForMapRPC();
      return res;
    } catch (e) {
      return e;
    }
  }

  Future getApartmentsForSale() async {
    GetAdvertisementsRequest getAdvertisementsRequest =
        GetAdvertisementsRequest();
    try {
      var res = await getAdvertisementsRequest.getApartmentsForSaleRPC();
      return res;
    } catch (e) {
      return e;
    }
  }

  Future getApartmentsForRent() async {
    GetAdvertisementsRequest getAdvertisementsRequest =
        GetAdvertisementsRequest();
    try {
      var res = await getAdvertisementsRequest.getApartmentsForRentRPC();
      return res;
    } catch (e) {
      return e;
    }
  }

  Future getVillaForSale() async {
    GetAdvertisementsRequest getAdvertisementsRequest =
        GetAdvertisementsRequest();
    try {
      var res = await getAdvertisementsRequest.getVillaForSaleRPC();
      return res;
    } catch (e) {
      return e;
    }
  }

  Future getVillaForRent() async {
    GetAdvertisementsRequest getAdvertisementsRequest =
        GetAdvertisementsRequest();
    try {
      var res = await getAdvertisementsRequest.getVillaForRentRPC();
      return res;
    } catch (e) {
      return e;
    }
  }

  Future getLandsForSale() async {
    GetAdvertisementsRequest getAdvertisementsRequest =
        GetAdvertisementsRequest();
    try {
      var res = await getAdvertisementsRequest.getLandsForSaleRPC();
      return res;
    } catch (e) {
      return e;
    }
  }

  Future getLandsForRent() async {
    GetAdvertisementsRequest getAdvertisementsRequest =
        GetAdvertisementsRequest();
    try {
      var res = await getAdvertisementsRequest.getLandsForRentRPC();
      return res;
    } catch (e) {
      return e;
    }
  }

  Future indicateCategoryAndGetAdDetails(int categoryId, int adId) async {
    AdDetailsRequests adDetailsRequests = AdDetailsRequests();
    switch (categoryId) {
      case 1:
        final res = await adDetailsRequests.getApartmentForSaleAdDetails(adId);
        return res;

      case 2:
        final res = await adDetailsRequests.getApartmentForRentAdDetails(adId);
        return res;
      case 3:
        final res = await adDetailsRequests.getVillaForSaleAdDetails(adId);
        return res;
      case 4:
        final res = await adDetailsRequests.getVillaForRentAdDetails(adId);
        return res;
      case 5:
        final res = await adDetailsRequests.getLandForSaleAdDetails(adId);
        return res;
      case 6:
        final res = await adDetailsRequests.getLandForRentAdDetails(adId);
        return res;
      default:
        return null;
    }
  }

  // Future<void> notificationHandler() async {
  //   const channel = AndroidNotificationChannel(
  //     'chat_channel', // id
  //     'New Message', // title
  //     importance: Importance.high,
  //   );

  //   const initializationSettingsAndroid =
  //       AndroidInitializationSettings('@mipmap/ic_launcher');

  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.createNotificationChannel(channel);

  //   const initializationSettings = InitializationSettings(
  //     android: initializationSettingsAndroid,
  //   );

  //   await flutterLocalNotificationsPlugin.initialize(
  //     initializationSettings,
  //   );
  // }

    Future getUserRule() async{
    GetUserDetails getUserDetails = GetUserDetails();
    try {
      final res = await getUserDetails.getUserProfileDetails(supabase.auth.currentUser!.id);
      ValueHolders.userRule = res[0]['user_rule'];
      notifyListeners();
    } catch (e) {
      return e;
    }
  }
}
