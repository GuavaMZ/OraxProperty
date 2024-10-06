import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:oraxproperty/app/value_holders.dart';
import 'package:oraxproperty/presentation/add_ad_or_req/choose_location/viewmodel/choose_location_viewmodel.dart';
import 'package:oraxproperty/presentation/resources/assets_manager.dart';
import 'package:oraxproperty/presentation/resources/colors_manager.dart';
import 'package:oraxproperty/presentation/resources/sizehelper.dart';
import 'package:oraxproperty/presentation/resources/string_manager.dart';
import 'package:oraxproperty/presentation/resources/values_manager.dart';
import 'package:oraxproperty/presentation/resources/widgets_manager.dart';
import 'package:provider/provider.dart';

class ChooseLocationView extends StatefulWidget {
  const ChooseLocationView({super.key});

  @override
  State<ChooseLocationView> createState() => _ChooseLocationViewState();
}

class _ChooseLocationViewState extends State<ChooseLocationView> {
  final ChooseLocationViewModel _viewModel = ChooseLocationViewModel();

  List allowedCountries = [];
  @override
  void initState() {
    Future.wait([_viewModel.getAllowedCountries()]).then((value) {
      allowedCountries = value[0];
      print(allowedCountries);
    });
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => _viewModel,
        child: Scaffold(
          backgroundColor: ColorManager.bgColor,
          resizeToAvoidBottomInset: false,
          body: Consumer<ChooseLocationViewModel>(
              builder: (BuildContext context, viewModel, Widget? child) =>
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: displayHeight(context) * 0.05,
                        ),
                        SizedBox(
                          width: displayWidth(context),
                          height: AppSize.s60,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  context.pop();
                                },
                                icon: SvgPicture.asset(
                                    'assets/images/arrow-circle-left.svg'),
                              ),
                              TextContainer(
                                width: displayWidth(context) * 0.77,
                                text: AppStrings.propertyLocationText
                                    .getString(context),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.05,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.topCenter,
                          children: [
                            RoundedContainer(
                              radius: displayHeight(context) * 0.025,
                              width: displayWidth(context) * 0.9,
                              height: displayHeight(context) * 0.5,
                              color: ColorManager.whiteColor,
                              boxShadow: const BoxShadow(),
                              child: FlutterMap(
                                mapController:
                                    viewModel.adLocationMapController,
                                options: MapOptions(
                                    initialCenter: viewModel.initialCenter,
                                    initialZoom: viewModel.initZoomLevel,
                                    maxZoom: viewModel.maxZoomLevel,
                                    onMapEvent: (p0) async {
                                      // print(p0.source.name);
                                      viewModel.mapEvent = p0.source.name;
                                      if (viewModel.mapEvent == "dragEnd") {
                                        Future.delayed(
                                            const Duration(milliseconds: 1350));
                                        await viewModel
                                            .getGeoLocationFromCoordinates();
                                        viewModel.checkIfCountryIsAllowed(
                                            viewModel
                                                .placemarks[0].isoCountryCode!,
                                            allowedCountries);
                                      }
                                      viewModel.toggleNotifyListener();
                                    },
                                    onPositionChanged:
                                        (position, hasGesture) async {
                                      viewModel.currentCenterLat =
                                          position.center!.latitude;
                                      viewModel.currentCenterLng =
                                          position.center!.longitude;
                                      viewModel.toggleNotifyListener();
                                    },
                                    backgroundColor: ColorManager.transparent),
                                children: [
                                  TileLayer(
                                    urlTemplate: viewModel.mapStyles[0],
                                    errorTileCallback:
                                        (tile, error, stackTrace) {},
                                    maxZoom: viewModel.maxZoomLevel,
                                    retinaMode: true,
                                  ),
                                  MarkerLayer(rotate: false, markers: [
                                    Marker(
                                        rotate: false,
                                        point: LatLng(
                                            viewModel.currentCenterLat,
                                            viewModel.currentCenterLng),
                                        child: Image.asset(
                                            ImageAssets.pinMarkerIcon))
                                  ])
                                ],
                              ),
                            ),
                            RoundedContainer(
                              radius: displayHeight(context) * 0.025,
                              width: displayWidth(context) * 0.88,
                              // height: displayHeight(context) * 0.15,
                              margin: const EdgeInsets.only(top: AppMargin.m5),
                              padding: EdgeInsets.symmetric(
                                  horizontal: displayWidth(context) * 0.03,
                                  vertical: displayHeight(context) * 0.02),
                              color: ColorManager.whiteColor,
                              child: Column(
                                children: [
                                  TextInputField(
                                    controller:
                                        viewModel.locationSearchController,
                                    width: displayWidth(context) * 0.83,
                                    height: displayHeight(context) * 0.05,
                                    focusedBorderRadius:
                                        displayHeight(context) * 0.025,
                                    enabledBorderRadius:
                                        displayHeight(context) * 0.025,
                                    errorBorderRadius:
                                        displayHeight(context) * 0.025,
                                    obsecureText: false,
                                    contentPadding:
                                        const EdgeInsets.symmetric(),
                                    maxLines: 1,
                                    prefixIcon: SvgPicture.asset(
                                      ImageAssets.searchIcon,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    // onChanged: (p0) {
                                    //   Future.delayed(
                                    //       const Duration(milliseconds: 1500),
                                    //       viewModel.getCoordinatesFromAddress);
                                    // },
                                    onSubmitted: (p0) {
                                      Future.delayed(
                                          const Duration(milliseconds: 1500),
                                          viewModel.getCoordinatesFromAddress);
                                    },
                                  ),
                                  SizedBox(
                                    height: displayHeight(context) * 0.016,
                                  ),
                                  Row(
                                    children: [
                                      TextContainer(
                                        width: displayWidth(context) * 0.75,
                                        text: viewModel.placemarks.isNotEmpty
                                            ? '${viewModel.placemarks[0].thoroughfare},${viewModel.placemarks[0].subLocality}, ${viewModel.placemarks[0].locality}, ${viewModel.placemarks[0].subAdministrativeArea}, ${viewModel.placemarks[0].administrativeArea},${viewModel.placemarks[0].country}'
                                            : '',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        // fontFamily:
                                        //     FontConstants.outfitFontFamily,
                                        maxLines: 2,
                                        textAlign: TextAlign.right,
                                      ),
                                      SvgPicture.asset(
                                          ImageAssets.streetAddressIcon),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.2,
                        ),
                        SizedBox(
                          width: displayWidth(context) * 0.45,
                          height: displayHeight(context) * 0.06,
                          child: ElevatedButton(
                              onPressed: () async {
                                viewModel.assignLocationToConfirmDetailsMap();
                                if (ValueHolders.adsOrRequest == 'Request') {
                                  if (viewModel.isCurrentChosenCountryAllowed ==
                                      true) {
                                    context.push(
                                        '/add_ad_or_req/confirm_before_sending/view');
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Country Not Allowed');
                                  }
                                } else if (ValueHolders.adsOrRequest == 'Ads') {
                                  if (viewModel.isCurrentChosenCountryAllowed ==
                                      true) {
                                    context.push(
                                        '/add_ad_or_req/choosing_media/view');
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Country Not Allowed');
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorManager.buttonsColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          displayHeight(context) * 0.03))),
                              child: TextContainer(
                                fontSize: 20,
                                text: AppStrings.nextText.getString(context),
                                color: ColorManager.fontColor,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.02,
                        ),
                      ],
                    ),
                  )),
        ));
  }
}
