import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u_pal/viewModel/country_view_model.dart';

class SingUpView extends StatefulWidget {
  const SingUpView({super.key});

  @override
  State<SingUpView> createState() => _SingUpViewState();
}

class _SingUpViewState extends State<SingUpView> {
  List<int> ageList = List.generate(53, (index) => 18 + index);
  var _selectedAge;
  var _selectedCountryCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(hintText: "email"),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(hintText: "password"),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(hintText: "nickname"),
          ),
          SizedBox(height: 10),
          DropdownMenu(
            dropdownMenuEntries: ageList
                .map<DropdownMenuEntry<int>>((int e) =>
                    DropdownMenuEntry<int>(value: e, label: e.toString()))
                .toList(),
            onSelected: (int? age) {
              setState(() {
                _selectedAge = age;
              });
            },
          ),
          SizedBox(height: 10),
          DropdownMenu(
            enableSearch: true,
            dropdownMenuEntries: Provider.of<CountryViewModel>(context)
                .getCountries()
                .map((e) => DropdownMenuEntry(
                    value: e.code as String, label: e.name as String))
                .toList(),
            onSelected: (String? code) {
              setState(() {
                _selectedCountryCode = code!;
              });
            },
          ),
          SizedBox(height: 10),
          OutlinedButton(onPressed: () => {}, child: Text("완료"))
        ],
      ),
    ));
  }

  List<String> getCountries() {
    return List.empty();
  }
}
