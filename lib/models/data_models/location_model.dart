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

  factory Location.fromJson(final Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
      name: json['name'],
      region: json['region'],
    );
  }

  @override
  String toString() =>
      'latitude: $latitude, longitude: $longitude, name: $name, region: $region';
}
