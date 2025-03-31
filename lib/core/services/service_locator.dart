import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/network_info.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';
import '../../presentation/blocs/theme/theme_bloc.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> setupServiceLocator() async {
  // Register external dependencies
  getIt.registerSingleton<Connectivity>(Connectivity());
  
  // Register async dependencies
  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPrefs);
  
  // Register app dependencies
  getIt.registerSingleton<NetworkInfo>(NetworkInfo(getIt<Connectivity>()));
  
  // Register blocs
  getIt.registerFactory<AuthBloc>(() => AuthBloc());
  getIt.registerFactory<ThemeBloc>(() => ThemeBloc(getIt<SharedPreferences>()));
}

@module
abstract class RegisterModule {} 