import 'package:flutter_test/flutter_test.dart';
import 'package:emergency_helpline/emergency_helpline.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('EmergencyHelpline', () {
    test('Pakistan numbers', () async {
      final pk = await EmergencyHelpline.instance.getCountry("PK");

      expect(pk, isNotNull);
      expect(pk?.police, "15");
      expect(pk?.ambulance, "1122");
      expect(pk?.fire, "16");
    });

    test('USA numbers', () async {
      final us = await EmergencyHelpline.instance.getCountry("US");

      expect(us, isNotNull);
      expect(us?.police, "911");
      expect(us?.ambulance, "911");
      expect(us?.fire, "911");
    });

    test('Unknown country code should return null', () async {
      final unknown = await EmergencyHelpline.instance.getCountry("XX");
      expect(unknown, isNull);
    });

    test('Shortcut methods: fire, police, ambulance', () async {
      final fire = await EmergencyHelpline.instance.fire("US");
      final police = await EmergencyHelpline.instance.police("PK");
      final ambulance = await EmergencyHelpline.instance.ambulance("PK");

      expect(fire, "911");
      expect(police, "15");
      expect(ambulance, "1122");
    });

    test('Get all country codes', () async {
      final codes = await EmergencyHelpline.instance.getAllCountryCodes();

      expect(codes.contains("PK"), true);
      expect(codes.contains("US"), true);
    });
  });
}
