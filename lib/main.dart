import 'package:etsy/core/constants.dart';
import 'package:etsy/core/shared.dart';
import 'package:etsy/features/card/cubit/card_cubit.dart';
import 'package:etsy/features/card/cubit/fakecard_cubit.dart';
import 'package:etsy/features/card/cubit/unifiedcard_cubit.dart';
import 'package:etsy/features/favorite/cubit/fav_cubit.dart';
import 'package:etsy/features/home/cubit/product_cubit.dart';
import 'package:etsy/features/login/views/login_screen.dart';
import 'package:etsy/features/navigation/navigation.dart';
import 'package:etsy/features/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
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
        BlocProvider(create: (_) => ProfileCubit()),
        BlocProvider(create: (_) => FavCubit()..loadFavorites()),
        BlocProvider(create: (_) => CardCubit()..getCardCubit()),
        BlocProvider(create: (_) => FakeCardCubit()),
        BlocProvider(
          create: (context) => UnifiedCartCubit(
            realCubit: BlocProvider.of<CardCubit>(context),
            fakeCubit: BlocProvider.of<FakeCardCubit>(context),
          ),
        ),
        BlocProvider(create: (_) => ProductCubit()..getDataCubit()),
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
        home: kToken != null ? Navigation() : LoginScreen(),
      ),
    );
  }
}
