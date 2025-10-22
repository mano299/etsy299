import 'package:etsy/features/core/shared.dart';
import 'package:etsy/features/home/cubit/product_cubit.dart';
import 'package:etsy/features/navigation/navigation.dart';
import 'package:etsy/features/profile/cubit/profile_cubit.dart';
import 'package:etsy/features/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Shared.init();
  runApp(const EtsyApp());
}

class EtsyApp extends StatelessWidget {
  const EtsyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider(
          create: (context) => ProductCubit()..getDataCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Etsy',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
          ),
        ),
        home: SplashView(),
      ),
    );
  }
}
