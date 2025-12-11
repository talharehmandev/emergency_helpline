import 'package:flutter/material.dart';
import 'package:emergency_helpline/emergency_helpline.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final pk = EmergencyHelpline.getForCountry("PK");

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Emergency Helpline Example")),
        body: Center(
          child: pk == null
              ? const Text("No data")
              : Text(
            "Police: ${pk.police}\nAmbulance: ${pk.ambulance}\nFire: ${pk.fire}",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}