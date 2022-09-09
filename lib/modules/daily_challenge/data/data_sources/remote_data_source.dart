import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_challenge/modules/daily_challenge/data/models/roulette_configuration/roulette_configuration_model.dart';

class RemoteDataSource {
  final database = FirebaseFirestore.instance;

  RemoteDataSource() {
    database.settings = const Settings(persistenceEnabled: true);
  }

  Future<void> initWebConfig() async {
    try {
      const persistenceSettings = PersistenceSettings(synchronizeTabs: true);
      await database.enablePersistence(persistenceSettings);
    } on FirebaseException catch (_) {
      //ignore exception of that says:
      //"Firestore has already been started and persistence can no longer"
      //" be enabled. You can only enable persistence before calling any other"
      //" methods on a Firestore object."
    }
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
