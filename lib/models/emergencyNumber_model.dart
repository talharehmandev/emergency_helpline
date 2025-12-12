///Model class for EmergencyNumber

class EmergencyNumber {
  final String countryName;
  final String police;
  final String ambulance;
  final String fire;

  EmergencyNumber({
    required this.countryName,
    required this.police,
    required this.ambulance,
    required this.fire,
  });

  /// Creates an object from a JSON map
  factory EmergencyNumber.fromJson(Map<String, dynamic> json) {
    return EmergencyNumber(
      countryName: json['country_name'] ?? '',
      police: json['police'] ?? '',
      ambulance: json['ambulance'] ?? '',
      fire: json['fire'] ?? '',
    );
  }
}
