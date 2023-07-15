import 'dart:math';

import 'package:flutter/material.dart';
import 'package:share_near/src/models/product_model.dart';
import 'package:share_near/src/utils/size_config.dart';

const Color primaryColor = Color(0xFF2D365C);
const secondaryColor = Color(0xFF979797);
const textColor = Color(0xFF757575);
SizedBox littleGap = SizedBox(height: SizeConfig.screenHeight * 0.02);
SizedBox smallerGap = SizedBox(height: SizeConfig.screenHeight * 0.04);
SizedBox biggerGap = SizedBox(height: SizeConfig.screenHeight * 0.08);

double? appLatitude;
double? appLongitude;
Product? curProduct;

String? appUserEmail;

List<Product> allProductPage = [];

String calculateDistance(double lat1, double lon1, double lat2, double lon2,
    [String unit = 'K']) {
  double theta = lon1 - lon2;
  double dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) +
      cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta));
  dist = acos(dist);
  dist = rad2deg(dist);
  dist = dist * 60 * 1.1515;
  if (unit == 'K') {
    dist = dist * 1.609344;
  } else if (unit == 'N') {
    dist = dist * 0.8684;
  }
  return dist.toStringAsFixed(2);
}

double deg2rad(double deg) {
  return (deg * pi / 180.0);
}

double rad2deg(double rad) {
  return (rad * 180.0 / pi);
}

List<String> bangladeshDistricts = [
  'Bagerhat',
  'Bandarban',
  'Barguna',
  'Barisal',
  'Bhola',
  'Bogra',
  'Brahmanbaria',
  'Chandpur',
  'Chapainawabganj',
  'Chittagong',
  'Chuadanga',
  'Comilla',
  'Cox\'s Bazar',
  'Dhaka',
  'Dinajpur',
  'Faridpur',
  'Feni',
  'Gaibandha',
  'Gazipur',
  'Gopalganj',
  'Habiganj',
  'Jaipurhat',
  'Jamalpur',
  'Jessore',
  'Jhalokati',
  'Jhenaidah',
  'Joypurhat',
  'Khagrachari',
  'Khulna',
  'Kishoreganj',
  'Kurigram',
  'Kushtia',
  'Lakshmipur',
  'Lalmonirhat',
  'Madaripur',
  'Magura',
  'Manikganj',
  'Meherpur',
  'Moulvibazar',
  'Munshiganj',
  'Mymensingh',
  'Naogaon',
  'Narail',
  'Narayanganj',
  'Narsingdi',
  'Natore',
  'Netrokona',
  'Nilphamari',
  'Noakhali',
  'Pabna',
  'Panchagarh',
  'Patuakhali',
  'Pirojpur',
  'Rajbari',
  'Rajshahi',
  'Rangamati',
  'Rangpur',
  'Satkhira',
  'Shariatpur',
  'Sherpur',
  'Sirajganj',
  'Sunamganj',
  'Sylhet',
  'Tangail',
  'Thakurgaon',
];
