import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Core imports
import 'core/config/themes.dart';
import 'core/services/service_locator.dart';
import 'core/error/error_handler.dart';
import 'core/network/network_info.dart';

// Presentation imports 
import 'presentation/pages/auth/start_page.dart';
import 'presentation/pages/auth/account_type_page.dart';
import 'presentation/pages/auth/success_page.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/profile/profile_page.dart';
import 'presentation/blocs/theme/theme_bloc.dart';
import 'presentation/pages/about/about_page.dart';
import 'presentation/pages/report/report_issue_page.dart';
import 'presentation/pages/recycling/recycling_process_page.dart';
import 'presentation/pages/auth/register_page.dart';
import 'presentation/pages/auth/login_page.dart';

final getIt = GetIt.instance;

final GoRouter router = GoRouter(
  initialLocation: '/start',
  routes: [
    GoRoute(
      path: '/start',
      builder: (context, state) => const StartPage(),
    ),
    GoRoute(
      path: '/account-type',
      builder: (context, state) => const AccountTypePage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterPage(
        accountType: state.extra as AccountType,
      ),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/success',
      builder: (context, state) => const SuccessPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutPage(),
    ),
    GoRoute(
      path: '/report-issue',
      builder: (context, state) => const ReportIssuePage(),
    ),
    GoRoute(
      path: '/recycling-process',
      builder: (context, state) => const RecyclingProcessPage(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const ProfilePage(),
    ),
  ],
  errorBuilder: (context, state) => ErrorHandler(
    error: state.error,
    onRetry: () => context.go('/start'),
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  await getIt<NetworkInfo>().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => getIt<ThemeBloc>(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp.router(
            title: 'Jal Setu',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeState.themeMode,
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('hi', 'IN'),
            ],
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
