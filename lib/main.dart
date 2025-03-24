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
import 'presentation/pages/auth/account_type_page.dart';
import 'presentation/pages/auth/phone_signup_page.dart';
import 'presentation/pages/auth/aadhar_page.dart';
import 'presentation/pages/auth/otp_page.dart';
import 'presentation/pages/auth/success_page.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/profile/profile_page.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/theme/theme_bloc.dart';

// Initialize service locator
final getIt = GetIt.instance;

// Define routes
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AccountTypePage(),
      routes: [
        GoRoute(
          path: 'phone',
          builder: (context, state) => PhoneSignupPage(
            accountType: state.extra as AccountType,
          ),
        ),
        GoRoute(
          path: 'otp',
          builder: (context, state) => OtpPage(
            phoneNumber: state.extra as String,
          ),
        ),
        GoRoute(
          path: 'aadhar',
          builder: (context, state) => const AadharPage(),
        ),
        GoRoute(
          path: 'success',
          builder: (context, state) => const SuccessPage(),
        ),
      ],
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const ProfilePage(),
    ),
  ],
  errorBuilder: (context, state) => ErrorHandler(
    error: state.error,
    onRetry: () => context.go('/'),
  ),
  redirect: (context, state) {
    final authState = context.read<AuthBloc>().state;
    final isAuthenticated = authState is AuthAuthenticated;
    final isAuthRoute = state.matchedLocation.startsWith('/auth');
    final isHomePage = state.matchedLocation == '/';

    // Allow access to home page without authentication
    if (isHomePage) {
      return null;
    }

    // Redirect to auth if trying to access protected routes while not authenticated
    if (!isAuthenticated && !isAuthRoute && !isHomePage) {
      return '/auth';
    }

    // Redirect to dashboard if trying to access auth routes while authenticated
    if (isAuthenticated && isAuthRoute) {
      return '/dashboard';
    }

    return null;
  },
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependencies
  await setupServiceLocator();
  
  // Initialize network info
  await getIt<NetworkInfo>().initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => getIt<AuthBloc>(),
        ),
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
