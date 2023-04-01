import 'package:forecast/pages/pages.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String initialRoute = DashboardPage.routeName;

  // static final Map<String, Widget Function(BuildContext)> routes = {
  //   '/': (final BuildContext ctx) => DashboardPage(
  //         onInit: () {
  //           StoreProvider.of<AppState>(ctx).dispatch(grabUserLocationAction);
  //         },
  //       ),
  //   SettingsPage.routeName: (final BuildContext ctx) => const SettingsPage(),
  // };

  static final List<GetPage<dynamic>> getPages = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: DashboardPage.routeName,
      page: DashboardPage.new,
    ),
  ];
}


