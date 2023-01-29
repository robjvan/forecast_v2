// These actions are used to interact with Location state

import 'package:forecast_v3/models/models.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class UpdateLocationListAction {
  final List<Location> newList;
  const UpdateLocationListAction(this.newList);
}

ThunkAction<AppState> grabUserLocationAction =
    (final Store<AppState> store) async {
  // Grab the user's coords
  // dispatch send coords to locationsList reducer action
  // dispatch send coords to fetch weather data action
};
