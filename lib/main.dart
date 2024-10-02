import 'package:aps_motobike/firebase_options.dart';
import 'package:aps_motobike/models/bike.dart';
import 'package:aps_motobike/pages/booking_page.dart';
import 'package:aps_motobike/pages/chatting_page.dart';
import 'package:aps_motobike/pages/checkout_page.dart';
import 'package:aps_motobike/pages/detail_page.dart';
import 'package:aps_motobike/pages/discover_page.dart';
import 'package:aps_motobike/pages/pin_page.dart';
import 'package:aps_motobike/pages/signin_page.dart';
import 'package:aps_motobike/pages/signup_page.dart';
import 'package:aps_motobike/pages/splash_screen.dart';
import 'package:aps_motobike/pages/success_booking_page.dart';
import 'package:d_session/d_session.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); /* Initial plugin */
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffEFEFF0),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: FutureBuilder(
        future: DSession.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.data == null) return SplashScreen();
          return const DiscoverPage();
        },
      ),
      /* Deklaratif routing */
      routes: {
        '/discover': (context) => const DiscoverPage(),
        '/signup': (context) => const SignupPage(),
        '/signin': (context) => const SigninPage(),
        '/detail': (context) {
          String bikeId = ModalRoute.of(context)!.settings.arguments as String;
          return DetailPage(bikeId: bikeId);
        },
        '/booking': (context) {
          Bike bike = ModalRoute.of(context)!.settings.arguments as Bike;
          return BookingPage(bike: bike);
        },
        '/checkout': (context) {
          Map data = ModalRoute.of(context)!.settings.arguments as Map;
          Bike bike = data['bike'];
          String startDate = data['startDate'];
          String endDate = data['endDate'];
          
          return CheckoutPage(
            bike: bike, 
            startDate: startDate, 
            endDate: endDate
          );
        },
        '/pin': (context) {
          Bike bike = ModalRoute.of(context)!.settings.arguments as Bike;
          return PINPage(bike: bike);
        },
        '/success-booking': (context) {
          Bike bike = ModalRoute.of(context)!.settings.arguments as Bike;
          return SuccessBookingPage(bike: bike);
        },
        '/chatting': (context) {
          Map data = ModalRoute.of(context)!.settings.arguments as Map;
          String uid = data['uid'];
          String userName = data['userName'];
          
          return ChattingPage(
            uid: uid, 
            userName: userName
          );
        },
      },
    );
  }
}
