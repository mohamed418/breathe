import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_proj_ui_test/theme/my_theme.dart';
import 'bloc/cubit.dart';
import 'modules/recording/sound_player.dart';
import 'modules/recording/sound_recorder.dart';
import 'network/local/bloc_observer.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/patient_registeriation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;

  late String? token = CacheHelper.getData(key: 'Token');

  if (token != null) {
    widget = PatientRegistrationScreen();
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  MyApp({super.key, this.startWidget});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BreatheCubit(),
      child: MaterialApp(
        title: 'Breathe App',
        theme: MyTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        // home: startWidget,
        // home: LoginScreen(),
        home: SoundPlayerScreen(),
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
