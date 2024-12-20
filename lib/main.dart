import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodies/firebase_options.dart';
import 'package:foodies/routes/route_names.dart';
import 'package:foodies/view-model/addcart_view_model.dart';
import 'package:foodies/view-model/address_view_model.dart';
// import 'package:foodies/view-model/checkout_view_model.dart';
import 'package:foodies/view-model/details_view_model.dart';
import 'package:foodies/view-model/home_view_model.dart';
import 'package:foodies/view-model/order_view_model.dart';
import 'package:foodies/view-model/profile_view_model.dart';
import 'package:foodies/view-model/search_view_model.dart';
import 'package:foodies/view-model/signin_view_model.dart';
import 'package:foodies/view-model/signup_view_model.dart';
import 'package:foodies/view-model/user_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final user = Userviewmodel();
  await user.loadLogId();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Signupviewmodel()),
        ChangeNotifierProvider(create: (context) => SigninViewModel()),
        ChangeNotifierProvider(create: (context) => HomeviewModel()),
        ChangeNotifierProvider(create: (context) => Detailsviewmodel()),
        ChangeNotifierProvider(create: (context) => CartViewModel()),
        ChangeNotifierProvider(create: (context) => FoodViewModel()),
        ChangeNotifierProvider(create: (context) => AddressViewModel()),
        ChangeNotifierProvider(create: (context) => PlaceOrderViewModel()),
        ChangeNotifierProvider(create: (context) => Userviewmodel()),
        // ChangeNotifierProvider(create: (context) => Checkoutviewmodel()),
        ChangeNotifierProvider(create: (context) => ProfileViewModel()),
        // Add more providers here as needed
      ],
      child: MyApp(user: user),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Userviewmodel user;

  const MyApp({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) => AppRoutes.generateRoute(settings),
      initialRoute:
          user.logId != null ? AppRoutes.bottomnavpage : AppRoutes.splash,
      theme: ThemeData(
        primarySwatch: Colors.green, // Customize the theme as needed
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
