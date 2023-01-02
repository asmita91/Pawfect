import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pawfect/UserScreens/ForgetPassword.dart';
import 'package:pawfect/UserScreens/UserLogin.dart';
import 'package:pawfect/UserScreens/UserRegistration.dart';
import 'package:pawfect/Widgets/CatListView.dart';
import 'package:pawfect/Widgets/DogListView.dart';
import 'package:pawfect/services/NotificationService.dart';
import 'package:provider/provider.dart';

import 'ScreensForBoth/SplashScreen.dart';
import 'UserScreens/DrawerScreen.dart';
import 'UserScreens/HomeScreen.dart';
import 'ViewModel/GlobalUIViewModel.dart';
import 'ViewModel/auth_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationService.initialize();
  // runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));
  runApp(MyApp());
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
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: "/splash",
          routes: {
            "/splash": (context) => Splash(),
            "/UserLogin": (context) => UserLogin(),
            "/ForgotPassword": (context) => ForgotPassword(),
            "/Registration": (context) => UserRegistration(),
            "/dashboard": (context) => HomePage(),
            "/CatCategory": (context) => CatListView(child: "Hi"),
            "/DogCategory": (context) => DogListView(),
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
