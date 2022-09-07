import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_challenge/modules/daily_challenge/data/models/roulette_configuration/roulette_configuration_model.dart';

class RemoteDataSource {
  final database = FirebaseFirestore.instance;

  RemoteDataSource() {
    database.settings = const Settings(persistenceEnabled: true);
  }

  Future<void> initWebConfig() async {
    const persistenceSettings = PersistenceSettings(synchronizeTabs: true);
    await database.enablePersistence(persistenceSettings);
  }

  Stream<RouletteConfigurationModel?> getRouletteConfiguration() {
    final collection = database.collection("configuration");
    return collection.doc("roulette_configuration").snapshots().map((event) {
      final documentData = event.data();

      if (documentData != null) {
        return RouletteConfigurationModel.fromJson(
          documentData,
        );
      }
      return null;
    });
  }
}
