import 'package:flutter/material.dart';
import '../classes/config.dart';

final Config config = new Config();

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Text Editing Controllers
  TextEditingController deviceAddressController;

  String _deviceAddress = config.deviceAddress;

  @override
  void initState() {
    print('Settings: initState()');
    super.initState();

    // Set the initial value for the edit field
    deviceAddressController = TextEditingController(text: _deviceAddress);
  }

  void updateDeviceAddress(String value) {
    print('Settings: _updateDeviceAddress($value)');
    _deviceAddress = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            Text("The IP Address:"),
            SizedBox(height: 10),
            TextField(
              controller: deviceAddressController,
              onChanged: updateDeviceAddress,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '(Device IP Address)'),
              style: TextStyle(fontFamily: 'Roboto Mono'),
            ),
          ],
        ),
      ),
    );
  }
}
