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
  Stream<RouletteConfiguration> getRouletteConfigurationStream() {
    return remoteDataSource
        .getRouletteConfiguration()
        .map((remoteRouletteConfiguration) {
      return remoteRouletteConfiguration ??
          localDataSource.getRouletteConfiguration();
    });
  }
}
