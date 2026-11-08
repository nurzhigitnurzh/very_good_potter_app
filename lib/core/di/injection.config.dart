// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:untitled/core/di/register_module.dart' as _i524;
import 'package:untitled/features/characters/data/remote/character_data_source.dart'
    as _i111;
import 'package:untitled/features/characters/data/remote/character_data_source_impl.dart'
    as _i657;
import 'package:untitled/features/characters/data/repo_impl/character_repository_impl.dart'
    as _i141;
import 'package:untitled/features/characters/domain/repo/character_repository.dart'
    as _i333;
import 'package:untitled/features/characters/ui/bloc/characters_bloc.dart'
    as _i446;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i111.CharacterDataSource>(
      () => _i657.CharacterDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i333.CharacterRepository>(
      () => _i141.CharacterRepositoryImpl(
        dataSource: gh<_i111.CharacterDataSource>(),
      ),
    );
    gh.factory<_i446.CharactersBloc>(
      () => _i446.CharactersBloc(repository: gh<_i333.CharacterRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i524.RegisterModule {}
