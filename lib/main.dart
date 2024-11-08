import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodies/firebase_options.dart';
import 'package:foodies/routes/route_names.dart';
import 'package:foodies/view-model/addcart_view_model.dart';
import 'package:foodies/view-model/details_view_model.dart';
import 'package:foodies/view-model/home_view_model.dart';

import 'package:foodies/view-model/signin_view_model.dart';
import 'package:foodies/view-model/signup_view_model.dart';
import 'package:foodies/view/cartscreen.dart';
import 'package:foodies/view/orderscreen.dart';
import 'package:foodies/view/signinscreen.dart';
import 'package:foodies/view/signupscreen.dart';
import 'package:foodies/view/splashscreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Signupviewmodel()),
        ChangeNotifierProvider(create: (context) => SigninViewModel()),
        ChangeNotifierProvider(create: (context) => HomeviewModel()),
        ChangeNotifierProvider(create: (context) => Detailsviewmodel()),
        ChangeNotifierProvider(create:  (context) => CartViewModel()),
        


        // Add more providers here as needed
      ],
      child: MaterialApp(
        onGenerateRoute: (settings) => AppRoutes.generateRoute(settings),
        initialRoute: AppRoutes.splash,
      ),
    ),
  );
}
