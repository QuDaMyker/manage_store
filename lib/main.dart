import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:manage_store/modules/root/cubit/root_cubit.dart';
import 'package:manage_store/modules/root/view/root_screen.dart';
import 'package:manage_store/modules/sell/services/supbabase_service.dart';

Future<void> main() async {
  // await Supabase.initialize(
  //   url: 'https://isxgjyotpvehvflthzuu.supabase.co',
  //   anonKey:
  //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlzeGdqeW90cHZlaHZmbHRoenV1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQ0ODY2MzIsImV4cCI6MjAzMDA2MjYzMn0.ZvArB9QsH_JaVlwIa7_5FeDxnrvq0tjcH6RgcTELu5g',
  // );
  await dotenv.load(fileName: '.env');
  await SupabaseService.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<RootCubit>(
            create: (BuildContext context) => RootCubit(
              RootState(
                pageController: PageController(initialPage: 0),
              ),
            ),
          ),
        ],
        child: const RootScreen(),
      ),
    );
  }
}
