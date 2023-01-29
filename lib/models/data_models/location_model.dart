class Location {
  final double latitude;
  final double longitude;
  final String name;
  final String region;

  Location({
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.region,
  });

  factory Location.initial() {
    return Location(
      latitude: double.nan,
      longitude: double.nan,
      name: '',
      region: '',
    );
  }
}
