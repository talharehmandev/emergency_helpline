import 'package:flutter/material.dart';
import 'package:emergency_helpline/emergency_helpline.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Emergency Helpline Example")),
        body: const EmergencyDemo(),
      ),
    );
  }
}

class EmergencyDemo extends StatefulWidget {
  const EmergencyDemo({super.key});

  @override
  State<EmergencyDemo> createState() => _EmergencyDemoState();
}

class _EmergencyDemoState extends State<EmergencyDemo> {
  String selectedCode = "PK"; // default country
  EmergencyNumber? data;
  List<String> allCodes = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  /// Loads default country + all codes
  Future<void> loadData() async {
    allCodes = await EmergencyHelpline.instance.getAllCountryCodes();
    data = await EmergencyHelpline.instance.getCountry(selectedCode);
    setState(() {});
  }

  /// Whenever user selects another country
  Future<void> changeCountry(String code) async {
    selectedCode = code;
    data = await EmergencyHelpline.instance.getCountry(code);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return allCodes.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          /// -----------------------------------------------------
          /// COUNTRY DROPDOWN (shows all supported codes)
          /// -----------------------------------------------------
          DropdownButton<String>(
            value: selectedCode,
            items: allCodes
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            onChanged: (value) {
              if (value != null) changeCountry(value);
            },
          ),

          const SizedBox(height: 20),

          /// -----------------------------------------------------
          /// SHOW EMERGENCY NUMBERS OF SELECTED COUNTRY
          /// -----------------------------------------------------
          data == null
              ? const Text("No data available")
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Country: ${data!.countryName}",
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text("Police: ${data!.police}",
                  style: const TextStyle(fontSize: 18)),
              Text("Ambulance: ${data!.ambulance}",
                  style: const TextStyle(fontSize: 18)),
              Text("Fire: ${data!.fire}",
                  style: const TextStyle(fontSize: 18)),
            ],
          ),

          const SizedBox(height: 30),

          /// -----------------------------------------------------
          /// QUICK ACCESS BUTTONS (Police / Ambulance / Fire)
          /// -----------------------------------------------------
          ElevatedButton(
            onPressed: () async {
              final police =
              await EmergencyHelpline.instance.police(selectedCode);
              _showPopup("Police Number: $police");
            },
            child: const Text("Get Police Number"),
          ),

          ElevatedButton(
            onPressed: () async {
              final ambulance = await EmergencyHelpline.instance
                  .ambulance(selectedCode);
              _showPopup("Ambulance Number: $ambulance");
            },
            child: const Text("Get Ambulance Number"),
          ),

          ElevatedButton(
            onPressed: () async {
              final fire =
              await EmergencyHelpline.instance.fire(selectedCode);
              _showPopup("Fire Brigade Number: $fire");
            },
            child: const Text("Get Fire Number"),
          ),
        ],
      ),
    );
  }

  /// Small popup on button click
  void _showPopup(String text) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Info"),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }
}
