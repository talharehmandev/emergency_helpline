class EmergencyNumber {
  final String police;
  final String ambulance;
  final String fire;

  EmergencyNumber({
    required this.police,
    required this.ambulance,
    required this.fire,
  });
}

class EmergencyHelpline {
  static final Map<String, EmergencyNumber> numbers = {
    "PK": EmergencyNumber(
      police: "15",
      ambulance: "1122",
      fire: "16",
    ),
    "US": EmergencyNumber(
      police: "911",
      ambulance: "911",
      fire: "911",
    ),
  };

  static EmergencyNumber? getForCountry(String code) {
    return numbers[code];
  }
}
