import 'package:flutter_test/flutter_test.dart';
import 'package:emergency_helpline/emergency_helpline.dart';

void main() {
  group('EmergencyHelpline', () {
    test('Pakistan numbers', () {
      final pk = EmergencyHelpline.getForCountry("PK");
      expect(pk, isNotNull);
      expect(pk?.police, "15");
      expect(pk?.ambulance, "1122");
      expect(pk?.fire, "16");
    });

    test('USA numbers', () {
      final us = EmergencyHelpline.getForCountry("US");
      expect(us, isNotNull);
      expect(us?.police, "911");
      expect(us?.ambulance, "911");
      expect(us?.fire, "911");
    });

    test('Unknown country code', () {
      final unknown = EmergencyHelpline.getForCountry("XX");
      expect(unknown, isNull);
    });
  });
}
