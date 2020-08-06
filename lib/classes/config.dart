import 'package:shared_preferences/shared_preferences.dart';

class Config {
  static final Config _config = Config._internal();

  factory Config() => _config;

  // ESP32 IP Address
  final deviceAddressKey = 'deviceAddress';

  String _deviceAddress;

  SharedPreferences prefs;

  Config._internal() {
    print('Config constructor');
//    loadData();
  }

  Future loadData() async {
    // Get the configuration data from persistent storage
    print('Config: loadData()');
    // initialize the preferences object
    prefs = await SharedPreferences.getInstance();
    // grab the device address from preferences
    _deviceAddress = prefs.getString(deviceAddressKey);
  }

  void printConfig() {
    print('Config: printConfig()');
    print('Device Address: $_deviceAddress');
  }

  String get deviceAddress {
    print('Config: Getting Device Address');
    return _deviceAddress;
  }

  set deviceAddress(String deviceAddress) {
    print('Config: deviceAddress($deviceAddress)');
    _deviceAddress = deviceAddress;
    _saveString(deviceAddressKey, deviceAddress);
  }

  _saveString(key, value) async {
    print('Config: _saveString($key, $value)');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
}
