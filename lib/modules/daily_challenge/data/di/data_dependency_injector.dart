import 'package:daily_challenge/modules/daily_challenge/data/data_sources/local_data_source.dart';
import 'package:daily_challenge/modules/daily_challenge/data/data_sources/remote_data_source.dart';
import 'package:daily_challenge/modules/daily_challenge/data/repository/repository_impl.dart';
import 'package:daily_challenge/modules/daily_challenge/domain/repository/repository.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class DataDependencyInjector extends MultiProvider {
  final RemoteDataSource remoteDataSource;
  DataDependencyInjector({
    super.key,
    super.child,
    required this.remoteDataSource,
  }) : super(
          providers: [
            Provider.value(value: remoteDataSource),
            Provider<LocalDataSource>(create: _localDataSourceCreator),
            Provider<Repository>(create: _repositoryCreator),
          ],
        );

  static Repository _repositoryCreator(context) => RepositoryImpl(
        Provider.of(context, listen: false),
        Provider.of(context, listen: false),
      );

  static LocalDataSource _localDataSourceCreator(BuildContext context) {
    return LocalDataSource();
  }
}
