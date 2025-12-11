🚨 Emergency Helpline (Flutter / Dart Package)

A Flutter/Dart package that provides emergency contact numbers (Police, Ambulance, Fire Brigade, etc.) for countries around the world — including Pakistan (15, 1122, 16), USA (911), and many more.

This package makes it easy to build emergency contact apps or display numbers for quick-dial purposes.

📦 Features

Get emergency numbers by country code (ISO Alpha-2 → “PK”, “US”, etc.)

Includes: Police, Ambulance, Fire

Lightweight & offline (no API required)

100% Dart — works with Flutter & pure Dart

Easy to extend for more countries

📥 Installation

Add the package to your pubspec.yaml:

dependencies:
emergency_helpline: ^0.0.1


Then run:

flutter pub get

🚀 Usage
Basic Example
import 'package:emergency_helpline/emergency_helpline.dart';

void main() {
final pk = EmergencyHelpline.getForCountry("PK");

print("Police: ${pk?.police}");
print("Ambulance: ${pk?.ambulance}");
print("Fire: ${pk?.fire}");
}

Output
Police: 15
Ambulance: 1122
Fire: 16

## 🌍 Supported Countries (Sample)

| Country  | Code | Police | Ambulance | Fire |
|----------|------|--------|-----------|------|
| Pakistan | PK   | 15     | 1122      | 16   |
| USA      | US   | 911    | 911       | 911  |
| UK       | GB   | 999    | 999       | 999  |
| India    | IN   | 112    | 102       | 101  |
| Canada   | CA   | 911    | 911       | 911  |


More countries will be added over time.

📚 API
EmergencyHelpline.getForCountry(String code)

Returns an EmergencyNumber object containing:

class EmergencyNumber {
final String police;
final String ambulance;
final String fire;
}

🧩 Example App

A full example is included in the /example folder.
To run it:

cd example
flutter run

🛠️ Contributing

Pull requests are welcome!

You can contribute by:

Adding emergency numbers for more countries

Improving data accuracy

Adding country flags

Adding region-level emergency numbers

Fork the repo and create a pull request.

📄 License

This package is released under the MIT License.
You are free to use, modify, and distribute it.

❤️ Author

Talha Rehman
Flutter Developer
Pakistan

If you use this package in your app, feel free to share the link with me!