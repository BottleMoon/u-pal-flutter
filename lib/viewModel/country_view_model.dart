import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:u_pal/model/country.dart';

class CountryViewModel with ChangeNotifier {
  List<Country> _countries = [];

  void getCountriesFromCsv() async {
    var countries_csv = await rootBundle.loadString('lib/assets/countries.csv');

    List<List<dynamic>> csv =
    CsvToListConverter(eol: "\n").convert(countries_csv);

    for (var c in csv.sublist(1)) {
      var country = Country(
          code: c[0],
          latitude: c[1] is double ? c[1] : null,
          longitude: c[2] is double ? c[2] : null,
          name: c[3]);
      _countries.add(country);
    }
  }

  List<Country> getCountries() {
    return _countries;
  }
}
