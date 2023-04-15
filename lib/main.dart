import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_proj_ui_test/theme/my_theme.dart';
import 'package:grad_proj_ui_test/ui/screens/home/home_screen.dart';
import 'package:grad_proj_ui_test/ui/screens/login_screen.dart';
import 'package:grad_proj_ui_test/ui/screens/onboarding_screen.dart';
import 'bloc/cubit.dart';
import 'network/local/bloc_observer.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BreatheCubit(),
      child: MaterialApp(
        title: 'Breathe App',
        theme: MyTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: OnboardingScreen(),
        // home: const HomeScreen(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


