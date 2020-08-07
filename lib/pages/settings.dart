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

    // increment the current value
    _deviceAddress += '.23';
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
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Settings'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                print('Home: Save button tapped');
                // Save the data to preferences
                config.deviceAddress = _deviceAddress;
                Navigator.of(context).pop(_deviceAddress);
              },
            ),
          ]),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            Text("Updated value, returned to the previous page."),
            SizedBox(height: 10),
            TextField(
              controller: deviceAddressController,
              onChanged: updateDeviceAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              style: TextStyle(fontFamily: 'Roboto Mono'),
            ),
          ],
        ),
      ),
    );
  }
}
