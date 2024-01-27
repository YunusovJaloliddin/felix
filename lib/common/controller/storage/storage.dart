import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../provider/project_model.dart';

const FlutterSecureStorage $secureStorage = FlutterSecureStorage();
final ProjectModel $currentUser = ProjectModel();

enum StorageKeys {
  user("user"),
  locale("locale");

  const StorageKeys(this.key);

  final String key;
}
