// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:jal_setu/core/network/network_info.dart' as _i412;
import 'package:jal_setu/presentation/blocs/auth/auth_bloc.dart' as _i409;
import 'package:jal_setu/presentation/blocs/theme/theme_bloc.dart' as _i533;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i409.AuthBloc>(() => _i409.AuthBloc());
    gh.lazySingleton<_i533.ThemeBloc>(
      () => _i533.ThemeBloc(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i412.NetworkInfo>(
      () => _i412.NetworkInfo(gh<_i895.Connectivity>()),
    );
    return this;
  }
}
