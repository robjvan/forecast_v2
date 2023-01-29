class Location {
  double? latitude;
  double? longitude;
  String? name;
  String? region;

  Location({
    this.latitude,
    this.longitude,
    this.name,
    this.region,
  });

  factory Location.initial() {
    return Location(
      latitude: null,
      longitude: null,
      name: null,
      region: null,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'latitude': latitude,
        'longitude': longitude,
        'name': name,
        'region': region,
      };
}
