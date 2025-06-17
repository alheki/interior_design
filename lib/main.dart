import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:home_services_app/core/localizations/app_localizations.dart';
import 'package:home_services_app/core/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme_helpers/app_theme.dart';
import 'features/settings/logic/settings_cubit.dart';
import 'features/home/logic/home_cubit.dart';
import 'features/services/logic/services_cubit.dart';
import 'features/gallery/logic/gallery_cubit.dart';
import 'features/contact/logic/contact_cubit.dart';
import 'features/portfolio/logic/portfolio_cubit.dart';
import 'features/notifications/logic/notifications_cubit.dart';
import 'utils/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  await UserDataFromStorage.getData();

  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SettingsCubit(prefs)..loadSettings()),
        BlocProvider(create: (context) => HomeCubit()..loadHomeData()),
        BlocProvider(create: (context) => ServicesCubit()..loadServices()),
        BlocProvider(create: (context) => GalleryCubit()..loadGallery()),
        BlocProvider(create: (context) => ContactCubit()..loadContactInfo()),
        BlocProvider(create: (context) => PortfolioCubit()..loadPortfolio()),
        BlocProvider(create: (context) => NotificationsCubit()..loadNotifications()),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Home Services',
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.router,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            locale: state.locale,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ar', 'SA'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}