import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

/// -------------------------------------------------------------
/// MODEL CLASS
/// -------------------------------------------------------------
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

/// -------------------------------------------------------------
/// MAIN SERVICE CLASS
/// -------------------------------------------------------------
class EmergencyHelpline {
  // Singleton Instance
  static final EmergencyHelpline instance = EmergencyHelpline._internal();
  EmergencyHelpline._internal();

  final Map<String, EmergencyNumber> _countries = {};
  bool _loaded = false;

  // Path to JSON inside your package
  static const String _jsonPath =
      'packages/emergency_helpline/assets/emergency_numbers.json';

  /// Loads JSON only once
  Future<void> _loadJsonIfNeeded() async {
    if (_loaded) return;

    final jsonString = await rootBundle.loadString(_jsonPath);
    final Map<String, dynamic> decoded = jsonDecode(jsonString);

    decoded.forEach((code, data) {
      _countries[code.toUpperCase()] = EmergencyNumber.fromJson(data);
    });

    _loaded = true;
  }

  /// Get complete emergency details for a country
  Future<EmergencyNumber?> getCountry(String code) async {
    await _loadJsonIfNeeded();
    return _countries[code.toUpperCase()];
  }

  /// -------------------------------------------------------------
  /// SHORTCUT FUNCTIONS
  /// -------------------------------------------------------------
  Future<String?> police(String countryCode) async {
    final c = await getCountry(countryCode);
    return c?.police;
  }

  Future<String?> fire(String countryCode) async {
    final c = await getCountry(countryCode);
    return c?.fire;
  }

  Future<String?> ambulance(String countryCode) async {
    final c = await getCountry(countryCode);
    return c?.ambulance;
  }

  /// -------------------------------------------------------------
  /// EXTRA API HELPERS
  /// -------------------------------------------------------------
  Future<List<String>> getAllCountryCodes() async {
    await _loadJsonIfNeeded();
    return _countries.keys.toList();
  }

  Future<List<EmergencyNumber>> getAllCountries() async {
    await _loadJsonIfNeeded();
    return _countries.values.toList();
  }
}
