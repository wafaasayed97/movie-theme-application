import 'package:movie_theming_app/core/cache/preferences_storage/preferences_storage.dart';
import 'package:movie_theming_app/core/helpers/alerts.dart';
import '../../generated/l10n.dart';
import '../cache/hive/hive_helper.dart';
import '../cache/secure_storage/secure_storage.dart';

class SessionManager {
  final SecureStorage storage;
  final PreferencesStorage preferencesStorage;
  final HiveHelper hiveHelper;
  SessionManager(this.storage, this.preferencesStorage, this.hiveHelper);

  Future<void> handleUnauthorized() async {
    await storage.deleteAll();
    await Future.wait([
      hiveHelper.clear(),
   
    ]);
    showError(S().your_session_has_been_expired);
    // TODO: Navigate to LOGIN SCREEN
    // routes.go(Routes.loginScreen);
  }
}
