import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../base/constant.dart';
import '../../../../base/widget_utils.dart';
import '../../common/alert_dialog.dart';
import 'lab_controller.dart';

class LabLocationScreen extends StatefulWidget {
  const LabLocationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LabLocationScreenState();
  }
}

class _LabLocationScreenState extends State<LabLocationScreen> {
  late LabController controller;
  List<LatLng> polylineCoordinates = [];
  GoogleMapController? mapController;
  Polyline? _polyline;
  final Set<Polyline> _polylines = {};
  late CameraPosition initialCameraPosition;
  final geolocator = Geolocator();
  Position? position;
  LatLng? selectedLocation;
  bool isLoading = false;
  String? address;
  bool _isPermissionGranted = false;
  bool _isGpsEnabled = false;

  @override
  void initState() {
    controller = Get.put(LabController());
    _checkLocationPermissionAndGps();
    super.initState();
  }

  void backClick() {
    Constant.backToPrev(context: context);
  }

  @override
  Widget build(BuildContext context) {
    initialCameraPosition = CameraPosition(
      target: LatLng(controller.lat.value!, controller.lng.value!),
      zoom: 12,
    );
    return WillPopScope(
      onWillPop: () async {
        backClick();
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(
              children: [
                buildMapView(),
                buildLocationFetcher(),
              ],
            ),
          ),
          floatingActionButton: !isLoading
              ? FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: buildNavigatorBtn('situation.svg'),
                  onPressed: () async {
                    _getLocation();
                  } // selectLocation,

                  )
              : const SizedBox.shrink(),
          bottomNavigationBar: buildBottomContainerView(context)),
    );
  }

  Widget buildLocationFetcher() {
    return Visibility(
      visible: isLoading,
      child: Center(
          child: Container(
              color: Colors.white.withOpacity(0.8),
              height: double.infinity,
              width: double.infinity,
              child:  const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator()),
                  Text('Getting your location please wait....')
                ],
              ))),
    );
  }

  Widget buildMapView() {
    return GoogleMap(
      polylines: _polylines,
      onMapCreated: (controller) {
        mapController = controller;
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(controller.lat.value!, controller.lng.value!),
        zoom: 12,
      ),
      zoomControlsEnabled: false,
      onTap: (location) async {
        _updateLoacation(location.latitude, location.longitude);
      },
      markers: <Marker>{
        Marker(
          markerId: const MarkerId('selected-location'),
          position: selectedLocation ??
              LatLng(controller.lat.value!, controller.lng.value!),
        ),
      },
    );
  }

  Align buildNavigatorBtn(icon) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: 50.h,
        width: 50.h,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Center(child: getSvgImage(icon, height: 24.h, width: 24.h)),
      ),
    );
  }

  Widget buildBottomContainerView(BuildContext context) {
    var lab = controller.lab.value;
    return getShadowDefaultContainer(
        height: 101.h,
        width: double.infinity,
        padding: EdgeInsets.all(20.h),
        color: Colors.white,
        child: Row(
          children: [
            getHorSpace(6.h),
            getCircularNetworkImage(
                context, 89.h, 89.h, 22.h, controller.image.value!,
                boxFit: BoxFit.fill),
            getHorSpace(10.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getCustomFont(lab!.name!, 18.sp, Colors.black, 1,
                      fontWeight: FontWeight.w700),
                  getVerSpace(10.h),
                  Row(
                    children: [
                      getSvgImage('lab_clock.svg', height: 20.h, width: 20.h),
                      getHorSpace(10.h),
                      getCustomFont('${lab.openFrom} to ${lab.openTo}', 17.sp,
                          Colors.black, 1,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
                onTap: () async {
                  //_drawPolyline(); // New line
                  _openNavigationApp();
                },
                child: buildNavigatorBtn('share.svg')),
          ],
        ));
  }

  void _openNavigationApp() async {
    final source = position ?? await Geolocator.getCurrentPosition();
    final destination = LatLng(controller.lat.value!, controller.lng.value!);

    final url =
        'https://maps.google.com/maps/dir/?api=1&origin=${source.latitude},${source.longitude}&destination=${destination.latitude},${destination.longitude}';

    Constant.launchURL(url);
  }

  void _drawPolyline() {
    if (selectedLocation == null) {
      Constant.printValue(
          "Selected location is null : ${selectedLocation == null}");
      return;
    }

    final sourceLatLng = selectedLocation;
    final destinationLatLng =
        LatLng(controller.lat.value!, controller.lng.value!);

    Polyline polyline = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.blue,
      points: [
        sourceLatLng!,
        destinationLatLng,
      ],
      width: 5,
    );

    setState(() {
      _polyline = polyline;
      _polylines.add(polyline);
    });

    mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(
            sourceLatLng.latitude < destinationLatLng.latitude
                ? sourceLatLng.latitude
                : destinationLatLng.latitude,
            sourceLatLng.longitude < destinationLatLng.longitude
                ? sourceLatLng.longitude
                : destinationLatLng.longitude,
          ),
          northeast: LatLng(
            sourceLatLng.latitude > destinationLatLng.latitude
                ? sourceLatLng.latitude
                : destinationLatLng.latitude,
            sourceLatLng.longitude > destinationLatLng.longitude
                ? sourceLatLng.longitude
                : destinationLatLng.longitude,
          ),
        ),
        100, // Padding value to include some space around the polyline
      ),
    );
  }

  _updateLoacation(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      Placemark place = placemarks[0];

      setState(() {
        address =
            "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
        selectedLocation = LatLng(lat, lng);
        isLoading = false;
      });
      print('address: $address');
      print('selected loaction: $selectedLocation');
    } catch (e) {
      print(e.toString());
    }
  }

  _getLocation() async {
    if (!_isPermissionGranted) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return const CustomAlertDialog(
              title: 'Location permission',
              message: 'Please grant the permission to use location services!',
              isLogout: false,
            );
          });
    } else if (!_isGpsEnabled) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return const CustomAlertDialog(
              title: 'GPS disabled',
              message: 'Please turn your GPS on to continue!',
              isLogout: false,
            );
          });
    } else {
      setState(() {
        address = null;
        isLoading = true;
      });
      try {
        Position position = await Geolocator.getCurrentPosition();

        setState(() {
          mapController!.animateCamera(CameraUpdate.newLatLng(
              LatLng(position.latitude, position.longitude)));
        });
        _updateLoacation(position.latitude, position.longitude);
      } catch (e) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _checkLocationPermissionAndGps() async {
    // Check if location permission is granted
    var status = await Permission.location.status;
    if (!status.isGranted) {
      // Ask for permission
      status = await Permission.location.request();
      if (!status.isGranted) {
        // Permission denied
        return;
      }
    }

    // Check if GPS is turned on
    final isGpsEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isGpsEnabled) {
      // GPS is turned off
      return;
    }

    // Location permission is granted and GPS is turned on
    setState(() {
      _isPermissionGranted = true;
      _isGpsEnabled = true;
    });
  }
}
