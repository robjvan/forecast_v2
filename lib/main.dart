import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/redux/reducers.dart';
import 'package:forecast_v3/utilities/utilities.dart';
import 'package:get/get.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    // ignore: always_specify_types
    middleware: [
      thunkMiddleware,
      LoggingMiddleware<dynamic>.printer(),
    ],
  );

  runApp(MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  const MyApp(
    this.store, {
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: GetMaterialApp(
        translations: AppTranslations(),
        locale: Get.deviceLocale,
        fallbackLocale: const Locale('en', 'US'),
        getPages: AppRoutes.getPages,
        title: 'Forecast',
        theme: AppTheme.themeData,
        initialRoute: AppRoutes.initialRoute,
      ),
    );
  }
}
