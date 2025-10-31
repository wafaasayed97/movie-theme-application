import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theming_app/core/cache/secure_storage/secure_storage.dart';
import 'package:movie_theming_app/core/di/services_locator.dart';
import 'package:movie_theming_app/core/helpers/app_bloc_observer.dart';
import 'package:movie_theming_app/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServicesLocator().init();
  Bloc.observer = AppBlocObserver();

  await sl<SecureStorage>().clearOnFreshInstall(sl());
  runApp(MyApp());
}
