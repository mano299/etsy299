import 'package:etsy/features/profile/cubit/profile_cubit.dart';
import 'package:etsy/features/profile/presentation/views/profile_view.dart';
import 'package:etsy/features/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const EtsyApp());
}

class EtsyApp extends StatelessWidget {
  const EtsyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: MaterialApp(
        title: 'Etsy',
        home: SplashView(),
      ),
    );
  }
}
