
import 'package:clinic_mobile/controllers/add_note/cubit.dart';
import 'package:clinic_mobile/controllers/edit_note/cubit.dart';
import 'package:clinic_mobile/controllers/home_screen/cubit.dart';
import 'package:clinic_mobile/shared/bloc_observer.dart';
import 'package:clinic_mobile/shared/colors.dart';
import 'package:clinic_mobile/shared/network/cache_helper.dart';
import 'package:clinic_mobile/shared/network/dio_helper.dart';
import 'package:clinic_mobile/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show DeviceOrientation, SystemChrome, SystemUiOverlayStyle;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controllers/add_user/cubit.dart';
import 'controllers/option/cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  CasheHelper.init();
  await CasheHelper.init();
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit()..getAllNotes()..getAllUsers(),lazy: false,
        ),
        BlocProvider(
          create: (context) => EditNoteCubit()..getAllUsers(),lazy: false,
        ),
        BlocProvider(
          create: (context) => AddNoteCubit()..getAllUsers(),lazy: false,
        ),
        BlocProvider(
          create: (context) => AddUserCubit()..getInterestData(),lazy: false,
        ),
        BlocProvider(
          create: (context) => OptionsCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            foregroundColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle(
              //<-- SEE HERE
              // Status bar color
              statusBarColor: kPrimary,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
