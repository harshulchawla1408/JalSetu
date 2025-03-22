import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/network_info.dart';
import 'service_locator.config.dart';

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
  
  // await $initGetIt(getIt);
}

@module
abstract class RegisterModule {} 