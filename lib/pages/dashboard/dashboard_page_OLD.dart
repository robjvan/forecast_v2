// import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
// import 'package:forecast_v3/models/models.dart';
// import 'package:forecast_v3/pages/dashboard/dashboard_view_model.dart';
// import 'package:forecast_v3/pages/dashboard/widgets/dashboard_tab.dart';
// import 'package:forecast_v3/providers/local_storage_provider.dart';
// import 'package:forecast_v3/redux/actions.dart';
// import 'package:forecast_v3/utilities/utilities.dart';
// import 'package:forecast_v3/widgets/widgets.dart';
// import 'package:get/get.dart';
// import 'package:redux/redux.dart';

// class DashboardPage extends StatefulWidget {
//   const DashboardPage({super.key});

//   @override
//   State<DashboardPage> createState() => _DashboardPageState();
//   static const String routeName = '/dashboard';
// }

// class _DashboardPageState extends State<DashboardPage>
//     with TickerProviderStateMixin {
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
//   Future<void> onInit(final Store<AppState> store) async {
//     /// Set app loading state to loading
//     if (store.state.loadingState != LoadingState.loading) {
//       store.dispatch(const SetLoadingStateAction(LoadingState.loading));
//     }

//     /// Check for saved user settings
//     final Map<String, dynamic> localData =
//         await LocalStorageProvider.readSettingsData();

//     if (localData.isNotEmpty) {
//       /// Also load user's saved locations
//       await store.dispatch(loadUserLocationsAction);
//       final UserSettings userSettings = UserSettings.fromJson(localData);
//       store.dispatch(UpdateUserSettingsAction(userSettings));

//       /// Grab user location index from Get Storage
//       await store.dispatch(loadLocationIndexAction);
//     }

//     /// Grab user's current location again in case the saved location is no longer accurate
//     await store.dispatch(grabUserLocationAction);
//     await store.dispatch(fetchWeatherDataAction(0, true));
//     store.dispatch(const SetLoadingStateAction(LoadingState.done));
//   }

//   @override
//   Widget build(final BuildContext context) {
//     return StoreConnector<AppState, DashboardPageViewModel>(
//       distinct: true,
//       onInit: onInit,
//       converter: DashboardPageViewModel.create,
//       builder: (final BuildContext context, final DashboardPageViewModel vm) {
//         /**
//          * Create a tab controller with dynamic length based on the number of 
//          * locations in our list
//          */
//         final TabController tabController = TabController(
//           length: vm.locationList.length,
//           initialIndex: vm.activeLocationIndex,
//           vsync: this,
//         );

//         /**
//          * Add a listener so we can reassign the "active location index" when 
//          * we swipe to change pages
//          */
//         tabController.addListener(() {
//           if (!tabController.indexIsChanging) {
//             vm.dispatch(UpdateCurrentLocationIndexAction(tabController.index));
//             vm.dispatch(saveLocationIndexAction);
//           }
//         });

//         /// Build out the tabs (pages) using a template widget and passed data
//         List<Widget> buildDashboardTabs({
//           required final List<WeatherData> weatherDataList,
//         }) {
//           return weatherDataList
//               .map((final WeatherData elem) => DashboardTab(weatherData: elem))
//               .toList();
//         }

//         /// Build the animated background
//         Widget buildBackground(final DashboardPageViewModel vm) {
//           return WeatherBg(
//             weatherType: vm.weatherType(
//               vm.weatherDataList[vm.activeLocationIndex].currentConditions
//                   .condition!.code!,
//             ),
//             width: Get.width,
//             height: Get.height,
//           );
//         }

//         /// Build a chip if there are active weather alerts
//         Widget buildAlertChip(final DashboardPageViewModel vm) {
//           /// Check if there are active alerts
//           final bool activeAlerts = vm.activeAlerts.isNotEmpty;

//           return activeAlerts
//               ? ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white,
//                     textStyle: const TextStyle(fontWeight: FontWeight.bold),
//                     backgroundColor: Colors.red,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   onPressed: () {
//                     // TODO(Rob): Add dialog for weather alert details
//                   },
//                   child: const Text('ALERT'),
//                 )
//               : Container();
//         }

//         return vm.loadingState == LoadingState.loading
//             ? const Scaffold(body: Center(child: CircularProgressIndicator()))
//             : Stack(
//                 children: <Widget>[
//                   vm.useDynamicBackgrounds ? buildBackground(vm) : Container(),
//                   Scaffold(
//                     key: scaffoldKey,
//                     backgroundColor: Colors.transparent,
//                     appBar: AppBar(
//                       leading: IconButton(
//                         style: IconButton.styleFrom(
//                           backgroundColor: vm.cardColor,
//                         ),
//                         icon: const Icon(Icons.settings),
//                         onPressed: () => scaffoldKey.currentState!.openDrawer(),
//                       ),
//                       shadowColor: Colors.transparent,
//                       backgroundColor: Colors.transparent,
//                       title: buildAlertChip(vm),
//                       centerTitle: true,
//                     ),
//                     drawer: const SettingsDrawer(),
//                     body: TabBarView(
//                       controller: tabController,
//                       children: buildDashboardTabs(
//                         weatherDataList: vm.weatherDataList,
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//       },
//     );
//   }
// }
