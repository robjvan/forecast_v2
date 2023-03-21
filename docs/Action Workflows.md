# Breakdown of Workflows 

SaveLocalDataAction() - Saves locationList, user settings, but NOT weatherDataList

## Handling app launch

### When App is launched offline
App is launched --> Error message telling user to go online
Re-check for connectivity every 15s?


### When App is launched online with NO local saved data
App is launched --> 
Check for local data --> 
*NO DATA FOUND* -->
GrabCurrentCoordsAction() --> 
ReplaceCoordsInLocationListAction(index: 0) --> 
SaveLocalDataAction() --> 
FetchWeatherDataAction(locationList[0]) --> 
ReplaceWeatherDataInListAction(0) --> 
UpdateWeatherDataReducer(weatherDataList)


### When App is launched online with local saved data
App is launched --> 
Check for local data --> 
*DATA FOUND* -->
load LocationList and activeLocationIndex from storage --> 
UpdateLocationListAction() --> 
SetActiveLocationIndexAction(activeLocationIndex) -->
forEach loc in locationList 
   FetchWeatherDataAction(locationList[i]) --> 
   ReplaceWeatherDataInListAction(i, newData)  -->
UpdateWeatherDataReducer(weatherDataList)


## Handling Locations
There are two lists: 
 - `locationList` holds the coords and uuid for each `SimpleLocation`
 - `weatherDataList` holds the `WeatherStateRepository` for each loc in locationList


### Add a location to list
Search for location with name --> 
*LOCATION SELECTED* -->
AddCoordsToLocationListAction() --> 
SaveLocalDataAction() --> 
FetchWeatherDataAction(newCoords) --> 
AddWeatherDataToListAction(newData) -->  
UpdateWeatherDataReducer(weatherDataList)


### Delete a location from list
Click 'delete' on a location --> 
if (location == active) SetActiveLocationIndexAction(current - 1 ?? 0) --> 
DeleteLocationFromListAction(locationId) --> 
SaveLocalDataAction() -->  
DeleteWeatherDataFromListAction(locationId) --> 
UpdateWeatherDataReducer(weatherDataList)


### User launches "refresh data"
Click 'Refresh' --> 
forEach loc in locationList
  FetchWeatherDataAction(locationList[i]) --> 
  ReplaceWeatherDataInListAction(i, newData) --> 
UpdateWeatherDataReducer(weatherDataList)


### Clear all locations
Click 'clear locations' --> 
SetActiveLocationIndexAction(0) --> 
ClearLocationListAction() --> <!-- delete all entries except [0] -->
SaveLocalDataAction() --> 
UpdateWeatherDataReducer(weatherDataList)


### User updates their current location
Click on "locate me" icon --> 
GrabCurrentCoordsAction() --> 
ReplaceCoordsInLocationListAction(index: 0)  --> 
SaveLocalDataAction() --> 
FetchWeatherData(locationList[0]) --> 
ReplaceWeatherDataInListAction(0) --> 
UpdateWeatherDataReducer(weatherDataList)

## Handling user settings

### User toggles dark mode
Click toggle dark mode buttons -->  
ToggleDarkModeAction() -->          *Action*
handleToggleDarkModeRequest() -->   *Middleware*
UpdateUserSettingsAction() -->      *Action*
_setUserSettingsReducer()           *Reducer*
### User updates units
Click on new unit -->
Set[type]UnitsAction([UnitType.enum]) -->
UpdateSettingsReducer()
