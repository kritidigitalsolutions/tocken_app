import 'package:flutter/material.dart';
import 'package:token_app/utils/custom_dialogBox.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

// make call ""

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri url = Uri.parse("tel:$phoneNumber");

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    debugPrint("Could not launch dialer");
  }
}

/// locaion
///

Future<Map<String, dynamic>> getCurrentLocationAndAddress(
  BuildContext context,
) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check location service
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw 'Location services are disabled.';
  }

  // Check permission
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw 'Location permission denied';
    }
  }

  if (permission == LocationPermission.deniedForever) {
    showCustomDialog(
      context: context,
      title: "Permission Required",
      message:
          'Location permission is permanently denied. '
          'Please enable it from app settings.',
      confirmText: "Open Settings",
      onConfirm: () {
        Navigator.pop(context);
        Geolocator.openAppSettings();
      },
    );
    throw 'Location permission permanently denied';
  }

  // Get current position
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  // Convert lat/long to address
  List<Placemark> placemarks = await placemarkFromCoordinates(
    position.latitude,
    position.longitude,
  );

  Placemark place = placemarks.first;

  String address =
      '${place.street}, ${place.subLocality}, ${place.locality}, '
      '${place.administrativeArea}, ${place.postalCode}, ${place.country}';
  String city = place.locality ?? '';
  String locality = '${place.street}, ${place.subLocality}';

  return {
    'latitude': position.latitude,
    'longitude': position.longitude,
    'address': address,
    "locality": locality,
    'city': city,
  };
}
