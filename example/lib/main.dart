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
      debugShowCheckedModeBanner: false,
      title: "Emergency Helpline",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const EmergencyDemo(),
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

  Future<void> loadData() async {
    allCodes = await EmergencyHelpline.instance.getAllCountryCodes();
    data = await EmergencyHelpline.instance.getCountry(selectedCode);
    setState(() {});
  }

  Future<void> changeCountry(String code) async {
    selectedCode = code;
    data = await EmergencyHelpline.instance.getCountry(code);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency Helpline"),
        centerTitle: true,
      ),
      body: allCodes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// ---------------- Country Dropdown ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Select Country: ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: selectedCode,
                  items: allCodes
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) changeCountry(value);
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// ---------------- Info Card ----------------
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: data == null
                    ? const Center(child: Text("No data available"))
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data!.countryName,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const Divider(height: 20, thickness: 2),
                    _buildRow(Icons.local_police, "Police", data!.police),
                    _buildRow(Icons.local_hospital, "Ambulance", data!.ambulance),
                    _buildRow(Icons.local_fire_department, "Fire", data!.fire),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// ---------------- Quick Access Buttons ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildEmergencyButton(
                  icon: Icons.local_police,
                  label: "Police",
                  color: Colors.blue,
                  onTap: () async {
                    final police =
                    await EmergencyHelpline.instance.police(selectedCode);
                    _showPopup("Police Number: $police");
                  },
                ),
                _buildEmergencyButton(
                  icon: Icons.local_hospital,
                  label: "Ambulance",
                  color: Colors.green,
                  onTap: () async {
                    final ambulance =
                    await EmergencyHelpline.instance.ambulance(selectedCode);
                    _showPopup("Ambulance Number: $ambulance");
                  },
                ),
                _buildEmergencyButton(
                  icon: Icons.local_fire_department,
                  label: "Fire",
                  color: Colors.red,
                  onTap: () async {
                    final fire =
                    await EmergencyHelpline.instance.fire(selectedCode);
                    _showPopup("Fire Number: $fire");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// ---------------- Helper: Row in Info Card ----------------
  Widget _buildRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.redAccent),
          const SizedBox(width: 10),
          Text("$label: ", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }

  /// ---------------- Helper: Emergency Button ----------------
  Widget _buildEmergencyButton(
      {required IconData icon,
        required String label,
        required Color color,
        required VoidCallback onTap}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onTap,
      icon: Icon(icon, size: 24,color: Colors.white,),
      label: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),

    );
  }

  /// ---------------- Helper: Popup ----------------
  void _showPopup(String text) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Emergency Number"),
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
