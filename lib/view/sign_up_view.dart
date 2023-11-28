import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u_pal/viewModel/country_view_model.dart';
import 'package:u_pal/viewModel/sign_up_view_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  List<int> ageList = List.generate(53, (index) => 18 + index);
  var _email = "";
  var _isEmailValid = false;
  var _code = "";
  var _password = "";
  var _confirmPassword = "";
  var _nickname = "";
  var _age;
  var _countryCode = "";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SignUpViewModel(),
        child: Consumer<SignUpViewModel>(
            builder: (context, provider, _) => Scaffold(
                    body: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _emailTextField(provider),
                      _emailValidText(),
                      SizedBox(height: 10),
                      _codeTextField(provider),
                      _codeCheckText(provider.isCodeCorrect),
                      SizedBox(height: 10),
                      _passwordTextField(),
                      _confirmPasswordTextField(),
                      _passwordCheck(),
                      SizedBox(height: 10),
                      _nicknameTextField(),
                      SizedBox(height: 10),
                      _ageDropdown(),
                      SizedBox(height: 10),
                      _countryDropdown(context),
                      SizedBox(height: 10),
                      _signUpButton(provider)
                    ],
                  ),
                ))));
  }

  TextField _nicknameTextField() {
    return TextField(
      onChanged: (value) {
        setState(() {
          _nickname = value;
        });
      },
      decoration: InputDecoration(hintText: "nickname"),
    );
  }

  TextField _passwordTextField() {
    return TextField(
      obscureText: true,
      onChanged: (value) {
        setState(() {
          _password = value;
        });
      },
      decoration: InputDecoration(hintText: "password"),
    );
  }

  TextField _confirmPasswordTextField() {
    return TextField(
      obscureText: true,
      onChanged: (value) {
        setState(() {
          _confirmPassword = value;
        });
      },
      decoration: InputDecoration(hintText: "check password"),
    );
  }

  OutlinedButton _signUpButton(SignUpViewModel provider) {
    if (provider.isCodeCorrect == true) {
      return OutlinedButton(
          onPressed: () async {
            if (_password != _confirmPassword) {
              alert("Passwords do not match", null);
            } else {
              if (await provider.sign_up(
                  _email, _password, _nickname, _age, _countryCode)) {
                Navigator.pop(context);
              }
            }
          },
          child: Text("완료"));
    } else {
      return OutlinedButton(
          onPressed: () => {},
          style: InactiveButtonStyle(),
          child: Text(
            "완료",
            style: TextStyle(color: Colors.grey),
          ));
    }
  }

  ButtonStyle InactiveButtonStyle() {
    return ButtonStyle(
        overlayColor:
            MaterialStateColor.resolveWith((states) => Colors.transparent));
  }

  DropdownMenu<String> _countryDropdown(BuildContext context) {
    return DropdownMenu(
      enableFilter: true,
      dropdownMenuEntries: Provider.of<CountryViewModel>(context)
          .getCountries()
          .map((e) => DropdownMenuEntry(
              value: e.code as String, label: e.name as String))
          .toList(),
      onSelected: (String? code) {
        setState(() {
          _countryCode = code!;
        });
      },
    );
  }

  DropdownMenu<int> _ageDropdown() {
    return DropdownMenu(
      dropdownMenuEntries: ageList
          .map<DropdownMenuEntry<int>>(
              (int e) => DropdownMenuEntry<int>(value: e, label: e.toString()))
          .toList(),
      onSelected: (int? age) {
        setState(() {
          _age = age;
        });
      },
    );
  }

  Row _emailTextField(SignUpViewModel provider) {
    return Row(
      children: [
        Expanded(
            child: TextField(
          decoration: InputDecoration(hintText: "email"),
          onChanged: (value) {
            setState(() {
              _email = value;
              if (EmailValidator.validate(_email))
                _isEmailValid = true;
              else
                _isEmailValid = false;
            });
          },
        )),
        OutlinedButton(
            style: _isEmailValid ? ButtonStyle() : InactiveButtonStyle(),
            onPressed: () async {
              if (_isEmailValid) {
                await provider.sendEmail(_email);
                if (provider.isEmailDuplicate) {
                  provider.isEmailDuplicate = false;
                  alert('Duplicate Email', 'This email is already in use');
                }
              }
            },
            child: provider.isEmailSent
                ? Text(
                    "resend code",
                    style: _isEmailValid
                        ? TextStyle()
                        : TextStyle(color: Colors.grey),
                  )
                : Text(
                    "send code",
                    style: _isEmailValid
                        ? TextStyle()
                        : TextStyle(color: Colors.grey),
                  ))
      ],
    );
  }

  void alert(String title, String? message) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(title),
              content: message == null ? null : Text(message),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ));
  }

  Row _codeTextField(SignUpViewModel provider) {
    return Row(
      children: [
        Expanded(
            child: TextField(
          decoration: InputDecoration(hintText: "code"),
          onChanged: (value) {
            setState(() {
              _code = value;
            });
          },
        )),
        OutlinedButton(
            style: provider.isEmailSent ? ButtonStyle() : InactiveButtonStyle(),
            onPressed: () {
              provider.authenticateEmail(_email, _code);
              provider.checkCount++;
            },
            child: Text(
              "check code",
              style: provider.isEmailSent
                  ? TextStyle()
                  : TextStyle(color: Colors.grey),
            )),
      ],
    );
  }

  Widget _emailValidText() {
    if (!_isEmailValid && _email != "") {
      return Text("Please enter a valid email.",
          style: TextStyle(color: Colors.redAccent));
    } else {
      return SizedBox();
    }
  }

  Widget _codeCheckText(bool? isCorrect) {
    if (isCorrect == null) {
      return SizedBox();
    } else if (!isCorrect) {
      return Text(
        "code is not correct",
        style: TextStyle(color: Colors.redAccent),
      );
    } else {
      return Text(
        "code is coreect",
        style: TextStyle(color: Colors.lightGreen),
      );
    }
  }

  Widget _passwordCheck() {
    if ((_password.length < 8 || _password.length > 60) && _password != "") {
      return Text(
        "Your password must contain between 8 and 60 characters.",
        style: TextStyle(color: Colors.redAccent),
      );
    } else {
      return SizedBox();
    }
  }
}
