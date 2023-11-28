import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u_pal/view/sign_up_view.dart';
import 'package:u_pal/viewModel/auth_view_model.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  var email = "";
  var password = "";

  void _onChangedId(String value) {
    email = value;
  }

  void _onChangedPassword(String value) {
    setState(() {
      password = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
        body: Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(textAlign: TextAlign.center, onChanged: _onChangedId),
          TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: _onChangedPassword,
              onSubmitted: (value) => {viewModel.signIn(email, password)}),
          SizedBox(height: 10),
          OutlinedButton(
              onPressed: () => {viewModel.signIn(email, password)},
              child: Text("Sign in")),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("if you dont have account"),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignUpView()));
                },
                child: Text("Sign up"))
          ])
        ],
      ),
    ));
  }
}
