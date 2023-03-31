import 'package:flutter/material.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/utilities/utilities.dart';
import 'package:redux/redux.dart';

@immutable
class WeatherAlertDialogViewModel {
  final Color cardColor;
  final Color textColor;

  final String headline;
  final String msgType;
  final String severity;
  final String urgency;
  final String areas;
  final String certainty;
  final String event;
  final String effective;
  final String expires;
  final String description;
  final String instruction;

  const WeatherAlertDialogViewModel({
    required this.cardColor,
    required this.textColor,
    required this.headline,
    required this.msgType,
    required this.severity,
    required this.urgency,
    required this.areas,
    required this.certainty,
    required this.event,
    required this.effective,
    required this.expires,
    required this.description,
    required this.instruction,
  });

  factory WeatherAlertDialogViewModel.create(final Store<AppState> store) {
    int getCurrentLocationIndex() => store.state.currentLocationIndex;

    /// Parse the headline of the alert
    String getHeadline() => store.state.weatherData[getCurrentLocationIndex()]
            .weatherAlerts.isNotEmpty
        ? store.state.weatherData[getCurrentLocationIndex()].weatherAlerts[0]
            .headline!
        : '';

    /// Parse the msgtype of the alert
    String getMsgType() => store.state.weatherData[getCurrentLocationIndex()]
            .weatherAlerts.isNotEmpty
        ? store.state.weatherData[getCurrentLocationIndex()].weatherAlerts[0]
            .msgtype!
        : '';

    /// Parse the severity of the alert
    String getSeverity() => store.state.weatherData[getCurrentLocationIndex()]
            .weatherAlerts.isNotEmpty
        ? store.state.weatherData[getCurrentLocationIndex()].weatherAlerts[0]
            .severity!
        : '';

    /// Parse the severity of the alert
    String getUrgency() => store.state.weatherData[getCurrentLocationIndex()]
            .weatherAlerts.isNotEmpty
        ? store.state.weatherData[getCurrentLocationIndex()].weatherAlerts[0]
            .urgency!
        : '';

    /// Parse the areas affected by the alert
    String getAreas() => store.state.weatherData[getCurrentLocationIndex()]
            .weatherAlerts.isNotEmpty
        ? store.state.weatherData[getCurrentLocationIndex()].weatherAlerts[0]
            .areas!
        : '';

    /// Parse the certainty of the alert
    String getCertainty() => store.state.weatherData[getCurrentLocationIndex()]
            .weatherAlerts.isNotEmpty
        ? store.state.weatherData[getCurrentLocationIndex()].weatherAlerts[0]
            .certainty!
        : '';

    /// Parse the event details of the alert
    String getEvent() => store.state.weatherData[getCurrentLocationIndex()]
            .weatherAlerts.isNotEmpty
        ? store.state.weatherData[getCurrentLocationIndex()].weatherAlerts[0]
            .event!
        : '';

    /// Parse the effective time of the alert
    String getEffective() => store.state.weatherData[getCurrentLocationIndex()]
            .weatherAlerts.isNotEmpty
        ? store.state.weatherData[getCurrentLocationIndex()].weatherAlerts[0]
            .effective!
        : '';

    /// Parse the expires time of the alert
    String getExpires() => store.state.weatherData[getCurrentLocationIndex()]
            .weatherAlerts.isNotEmpty
        ? store.state.weatherData[getCurrentLocationIndex()].weatherAlerts[0]
            .expires!
        : '';

    /// Parse the description of the alert
    String getDescription() => store.state
            .weatherData[getCurrentLocationIndex()].weatherAlerts.isNotEmpty
        ? store
            .state.weatherData[getCurrentLocationIndex()].weatherAlerts[0].desc!
        : '';

    /// Parse the instructions for the alert
    String getInstruction() => store.state
            .weatherData[getCurrentLocationIndex()].weatherAlerts.isNotEmpty
        ? store.state.weatherData[getCurrentLocationIndex()].weatherAlerts[0]
            .instruction!
        : '';

    return WeatherAlertDialogViewModel(
      cardColor: AppColors.getCardColor(store),
      textColor: AppColors.getTextColor(store),
      headline: getHeadline(),
      msgType: getMsgType(),
      severity: getSeverity(),
      urgency: getUrgency(),
      areas: getAreas(),
      certainty: getCertainty(),
      event: getEvent(),
      effective: getEffective(),
      expires: getExpires(),
      description: getDescription(),
      instruction: getInstruction(),
      // headline:
      //     'Flood Warning issued January 05 at 9:47PM EST until January 07 at 6:15AM EST by NWS',
      // msgType: 'Alert',
      // severity: 'Moderate',
      // urgency: 'Expected',
      // areas: 'Calhoun; Lexington; Richland',
      // certainty: 'Likely',
      // event: 'Flood Warning',
      // effective: '2021-01-05T21:47:00-05:00',
      // expires: '2021-01-07T06:15:00-05:00',
      // description:
      //     '...The Flood Warning continues for the following rivers in South\nCarolina...\nCongaree River At Carolina Eastman affecting Richland, Calhoun\nand Lexington Counties.\nCongaree River At Congaree National Park-Gadsden affecting\nCalhoun and Richland Counties.\nNorth Fork Edisto River At Orangeburg affecting Orangeburg County.\n...The Flood Warning is now in effect until Thursday morning...\nThe Flood Warning continues for\nthe Congaree River At Carolina Eastman.\n* Until Thursday morning.\n* At 9:28 PM EST Tuesday the stage was 115.6 feet.\n* Flood stage is 115.0 feet.\n* Minor flooding is occurring and minor flooding is forecast.\n* Recent Activity...The maximum river stage in the 24 hours ending\nat 9:28 PM EST Tuesday was 118.2 feet.\n* Forecast...The river will rise to 115.7 feet just after midnight\ntonight. It will then fall below flood stage tomorrow morning to\n114.2 feet and begin rising again tomorrow evening. It will rise\nto 114.3 feet early Thursday morning. It will then fall again and\nremain below flood stage.\n* Impact...At 115.0 feet, Flooding occurs in low lying areas of the\nCarolina Eastman Facility and at the Congaree National Park.\n* Flood History...This crest compares to a previous crest of 116.3\nfeet on 12/03/2020.\n&&',
      // instruction:
      //     'A Flood Warning means that flooding is imminent or occurring. All\ninterested parties should take necessary precautions immediately.\nMotorists should not attempt to drive around barricades or drive\ncars through flooded areas.\nCaution is urged when walking near riverbanks.\nAdditional information is available at www.weather.gov.\nThe next statement will be issued Wednesday morning at 1000 AM EST.',
    );
  }
}
