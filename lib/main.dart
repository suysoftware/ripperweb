import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripper_web/src/bloc/time_screen_cubit.dart';
import 'package:ripper_web/src/locator.dart';
import 'package:ripper_web/src/services/firebase/firebase_configurations.dart';
import 'package:sizer/sizer.dart';
import 'src/routing/route_names.dart';
import 'src/routing/router.dart';
import 'src/services/navigation_service.dart';
import 'src/views/layout_template/layout_template.dart';

final FirebaseConfigurations _configurations = FirebaseConfigurations();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: _configurations.apiKey,
        projectId: _configurations.projectId,
        messagingSenderId: _configurations.messagingSenderId,
        appId: _configurations.appId),
  );
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => TimeScreenCubit())],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          builder: (context, child) => LayoutTemplate(
            child: child!,
          ), 
          navigatorKey: locator<NavigationService>().navigatorKey,
          onGenerateRoute: generateRoute,
          initialRoute: homeRoute,
        ),
      );
    });
  }
}
