import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:u_pal/view/home_view.dart';
import 'package:u_pal/view/signIn_view.dart';
import 'package:u_pal/viewModel/auth_view_model.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(ChangeNotifierProvider(
    create: (context) => AuthViewModel(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Consumer<AuthViewModel>(
        builder: (context, provider, child) {
          return provider.isSignedIn ? const HomeView() : const SignInView();
        },
      ),
    );
  }
}
