import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sanzhyra/app/build_context_ext.dart';
import 'package:sanzhyra/di.dart';
import 'package:sanzhyra/domain/bloc/appblockobs.dart';
import 'package:sanzhyra/domain/bloc/auth_bloc/auth_bloc.dart';
import 'package:sanzhyra/domain/bloc/theme_cubit/theme_cubit.dart';
import 'package:sanzhyra/domain/interfaces/api_repo.dart';
import 'package:sanzhyra/domain/interfaces/auth_repo.dart';
import 'package:sanzhyra/domain/interfaces/local_repo.dart';
import 'package:sanzhyra/presentation/driver/driver_main_page.dart';
import 'package:sanzhyra/presentation/login/login_page.dart';
import 'package:sanzhyra/presentation/gps_page.dart';
import 'package:sanzhyra/presentation/splash/splash_page.dart';

void configLoading(BuildContext context) {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 40.0
    ..radius = 8
    ..lineWidth = 2
    ..progressColor = context.color.primary
    ..backgroundColor = Colors.white
    ..indicatorColor = context.color.primary
    ..textColor = context.color.primary
    ..fontSize = 12
    ..maskColor = Colors.white.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = AppBlockObserver();
  await configureDependencies();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => ThemeCubit(),
      ),
      BlocProvider(
        create: (_) => AuthBloc(
          authRepo: locator.get<AuthRepo>(),
          localRepo: locator.get<LocalRepo>(),
          apiRepo: locator.get<ApiRepo>(),
        )..add(AppStarter()),
      ),
    ], child: AppView());
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(builder: (_, theme) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        builder: EasyLoading.init(),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            configLoading(context);
            if (state is AuthInitial) {
              return SplashPage();
            } else if (state is AuthenticatedRider) {
              return GpsPage(
                isRider: true,
                isDriver: false,
              );
            } else if (state is AuthenticatedDriver) {
              return GpsPage(
                isRider: false,
                isDriver: true,
              );
            } else if (state is Unauthenticated) {
              return LoginPage();
            } else {
              return SplashPage();
            }
          },
        ),
      );
    });
  }
}
