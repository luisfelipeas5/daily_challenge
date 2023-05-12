import 'package:daily_challenge/modules/daily_challenge/data/data_sources/local_data_source.dart';
import 'package:daily_challenge/modules/daily_challenge/data/data_sources/remote_data_source.dart';
import 'package:daily_challenge/modules/daily_challenge/domain/entities/roulette_configuration/roulette_configuration.dart';
import 'package:daily_challenge/modules/daily_challenge/domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  RepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
  );

  @override
  RouletteConfiguration getRouletteConfigurationStream() {
    final remoteConfig = remoteDataSource.getRouletteConfiguration();
    return remoteConfig ?? localDataSource.getRouletteConfiguration();
  }
}
