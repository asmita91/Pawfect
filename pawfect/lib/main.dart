import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khalti/khalti.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:khalti_flutter/localization/khalti_localizations.dart';
import 'package:pawfect/UserScreens/Favorite.dart';
import 'package:pawfect/ViewModel/CatViewModel.dart';
import 'package:pawfect/ViewModel/SingleDogViewModel.dart';
import 'package:pawfect/services/NotificationService.dart';
import 'package:provider/provider.dart';

import 'ScreensForBoth/SplashScreen.dart';
import 'UserScreens/CatListView.dart';
import 'UserScreens/DogListView.dart';
import 'UserScreens/DrawerScreen.dart';
import 'UserScreens/ForgetPassword.dart';
import 'UserScreens/HomeScreen.dart';
import 'UserScreens/OldPayment.dart';
import 'UserScreens/SubScreenDog.dart';
import 'UserScreens/UserLogin.dart';
import 'UserScreens/UserRegistration.dart';
import 'UserScreens/account_screen.dart';
import 'UserScreens/subScreenCat.dart';
import 'ViewModel/DogViewModel.dart';
import 'ViewModel/GlobalUIViewModel.dart';
import 'ViewModel/auth_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Khalti.init(
    publicKey: 'test_public_key_0713eb3c9e684be994feae24c451ff44',
    enabledDebugging: false,
  );
  await Firebase.initializeApp();
  NotificationService.initialize();
  // runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));
  runApp(MyApp());
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //     overlays: [SystemUiOverlay.bottom]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GlobalUIViewModel()),
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
          ChangeNotifierProvider<DogViewModel>(create: (_) => DogViewModel()),
          ChangeNotifierProvider<CatViewModel>(create: (_) => CatViewModel()),
          ChangeNotifierProvider<SingleDogViewModel>(
              create: (_) => SingleDogViewModel()),
        ],
        child: MaterialApp(
          localizationsDelegates: [
            KhaltiLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.grey,
          ),
          initialRoute: "/splash",
          routes: {
            "/splash": (context) => Splash(),
            "/UserLogin": (context) => UserLogin(),
            "/ForgotPassword": (context) => ForgotPassword(),
            "/Registration": (context) => UserRegistration(),
            "/dashboard": (context) => HomePage(),
            "/CatCategory": (context) => CatListView(),
            "/DogCategory": (context) => DogListView(),
            "/SubPage": (context) =>
                SubScreen(null, null, null, null, null, null, null),
            "/SubPageCat": (context) =>
                SubScreenCat(null, null, null, null, null, null, null),
            "/Favorites": (context) => FavoriteScreen(),
            "/Profile": (context) => AccountScreen(),
            "/Payment": (context) => KhaltiScope(
                publicKey: 'test_public_key_5a22ad67e707441b8362fc7bed556a8d',
                builder: (context, navKey) {
                  return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      home: KhaltiPayment(),
                      navigatorKey: navKey,
                      localizationsDelegates: const [
                        KhaltiLocalizations.delegate,
                      ]);
                }),
          },
        ));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [DrawerScreen(), HomeScreen()],
      ),
      // body: SubScreen(),
    );
  }
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: 'test_public_key_5a22ad67e707441b8362fc7bed556a8d',
        enabledDebugging: true,
        builder: (context, navKey) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: KhaltiPayment(),
              navigatorKey: navKey,
              localizationsDelegates: const [
                KhaltiLocalizations.delegate,
              ]);
        });
  }
}
//
// class MyPayment extends StatelessWidget {
//   const MyPayment({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return KhaltiScope(
//         publicKey: 'test_public_key_0713eb3c9e684be994feae24c451ff44',
//         enabledDebugging: false,
//         builder: (context, navigatorKey) {
//           return MaterialApp(
//             localizationsDelegates: [
//               KhaltiLocalizations.delegate,
//             ],
//             debugShowCheckedModeBanner: false,
//             navigatorKey: navigatorKey,
//             supportedLocales: const [
//               Locale("en", "US"),
//               Locale("ne", "NP"),
//             ],
//             theme: ThemeData(
//                 primaryColor: const Color(0xFF56328C),
//                 appBarTheme: const AppBarTheme(
//                   color: Color(0xFF56328C),
//                 )),
//             title: "Khalti Payment",
//             home: KhaltiPaymentPage(),
//           );
//         });
//   }
// }
//
// class KhaltiPayment extends StatefulWidget {
//   const KhaltiPayment({Key? key}) : super(key: key);
//
//   @override
//   State<KhaltiPayment> createState() => _KhaltiPaymentState();
// }
//
// class _KhaltiPaymentState extends State<KhaltiPayment> {
//   TextEditingController phoneController = new TextEditingController();
//   TextEditingController pinCodeController = new TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             "Khalti",
//             style: TextStyle(color: Colors.white),
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.purple,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: phoneController,
//                 keyboardType: TextInputType.phone,
//                 decoration: const InputDecoration(labelText: "Phone number"),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               TextFormField(
//                 controller: pinCodeController,
//                 obscureText: true,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(labelText: "Pin Code "),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   final initiationModel = await Khalti.service.initiatePayment(
//                     request: PaymentInitiationRequestModel(
//                         amount: 1000,
//                         mobile: phoneController.text,
//                         productIdentity: "pID",
//                         productName: "ProductName",
//                         transactionPin: pinCodeController.text,
//                         productUrl: "",
//                         additionalData: {}),
//                   );
//                   final otp = await showDialog(
//                       context: (context),
//                       barrierDismissible: false,
//                       builder: (context) {
//                         String? _otp;
//                         return AlertDialog(
//                           title: Text("Enter OTP"),
//                           content: TextField(
//                             onChanged: (v) => _otp = v,
//                             keyboardType: TextInputType.number,
//                             decoration: InputDecoration(label: Text("OTP")),
//                           ),
//                           actions: [
//                             SimpleDialogOption(
//                               child: Text("Submit"),
//                               onPressed: () {
//                                 Navigator.pop(context, _otp);
//                               },
//                             )
//                           ],
//                         );
//                       });
//                   if (otp != null) {
//                     try {
//                       final model = await Khalti.service.confirmPayment(
//                           request: PaymentConfirmationRequestModel(
//                               confirmationCode: otp,
//                               token: initiationModel.token,
//                               transactionPin: pinCodeController.text));
//                       showDialog(
//                           context: (context),
//                           builder: (context) {
//                             return AlertDialog(
//                               title: const Text("Payment Successful"),
//                               content:
//                                   Text("Verification Token ${model.token}"),
//                             );
//                           });
//                     } catch (e) {
//                       ScaffoldMessenger.maybeOf(context)
//                           ?.showSnackBar(SnackBar(content: Text(e.toString())));
//                     }
//                   }
//                 },
//                 child: Text("Make Payment"),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
