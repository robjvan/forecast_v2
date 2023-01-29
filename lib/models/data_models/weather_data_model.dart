class WeatherData {
  final double tempC;
  final double tempF;
  final double tempK;

  WeatherData({
    required this.tempC,
    required this.tempF,
    required this.tempK,
  });

  factory WeatherData.initial() {
    return WeatherData(
      tempC: double.nan,
      tempF: double.nan,
      tempK: double.nan,
    );
  }
}
