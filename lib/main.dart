import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task07_real_estate_app_beg/core/app/routes.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/manager/property_cubit/property_cubit.dart';
import 'package:flutter_task07_real_estate_app_beg/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    publishableKey: 'sb_publishable_BiclXkpzQkfrqtS7nt1-Kg_IKM4l6Zx',
    url: 'https://wufaopdrbmsmnpcnirhe.supabase.co',
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authCubit = AuthCubit();
  authCubit.checkAuth();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authCubit),
        BlocProvider(create: (_) => PropertyCubit()),
      ],
      child: const RealEstateApp(),
    ),
  );
}

class RealEstateApp extends StatelessWidget {
  const RealEstateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1034, 613),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
