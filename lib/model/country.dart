import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';

class Country {
  String? code;
  double? latitude;
  double? longitude;
  String? name;

  Country({this.code, this.latitude, this.longitude, this.name});

  factory Country.fromCsv(String code, double latitude, double longitude,
      String name) {
    var input = File("/lib/data/countries.csv").openRead();
    var countries =
    input.transform(utf8.decoder).transform(CsvToListConverter()).toList();
    return Country(
        code: code,
        latitude: latitude,
        longitude: longitude,
        name: name
    );
  }
}
