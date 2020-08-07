import 'package:flutter/material.dart';
import './settings.dart';
import '../classes/config.dart';

final Config config = new Config();

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.appName}) : super(key: key);

  final String appName;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Text Editing Controllers
  TextEditingController deviceAddressController;

  String _deviceAddress = config.deviceAddress;

  @override
  void initState() {
    print('Home: initState()');
    super.initState();
  }

  Future<bool> loadConfigAsync() async {
    print('Home: loadConfigAsync()');
    // Initialize the config object
    await config.loadData();
    // Initialize the device address variable from preferences
    _deviceAddress = config.deviceAddress;
    // Set the initial value for the edit field
    deviceAddressController = TextEditingController(text: _deviceAddress);
    // Tell FutureBuilder we're ready to go...
    return true;
  }

  void updateDeviceAddress(String value) {
    print('Home: _updateDeviceAddress($value)');
    _deviceAddress = value;
  }

  void _openPage() async {
    print('Home: _openPage()');
    config.deviceAddress = _deviceAddress;

    //======================================
    // Opens a page with a back button
    //======================================
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //      builder: (BuildContext context) => SettingsPage(),
    //      settings: RouteSettings(name: '/settings')
    //   ));

    //======================================
    // opens a page with an X to close
    // https://fidev.io/full-screen-dialog/
    //======================================
    // Navigator.of(context).push(new MaterialPageRoute<Null>(
    //    builder: (BuildContext context) {
    //      return new SettingsPage();
    //    },
    //    fullscreenDialog: true
    // ));

    String ipAddr = await Navigator.of(context).push(new MaterialPageRoute<String>(
        builder: (BuildContext context) {
          return new SettingsPage();
        },
        fullscreenDialog: true
    ));
    if (ipAddr != null ) {
      setState(() {
        _deviceAddress = ipAddr;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // https://medium.com/swlh/flutter-futurebuilder-383b6ed63f18
    return FutureBuilder(
        future: loadConfigAsync(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // Future hasn't finished yet, return a placeholder
            return Scaffold(
                appBar: AppBar(title: Text(widget.appName)),
                body: SafeArea(
                    child: Center(
                        child: Container(child: Text('Loading preferences')))));
          } else {
            return Scaffold(
              appBar: AppBar(title: Text(widget.appName), actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    print('Home: Save button tapped');
                    // Save the data to preferences
                    config.deviceAddress = _deviceAddress;
                  },
                ),
              ]),
              body: SafeArea(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text(
                        "Enter a value in the field below, then click the button (below) to continue."),
                    SizedBox(height: 10),
                    TextField(
                      controller: deviceAddressController,
                      onChanged: updateDeviceAddress,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '(Device IP Address)'),
                      style: TextStyle(fontFamily: 'Roboto Mono'),
                    ),
                    SizedBox(height: 10),
                    RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      splashColor: Colors.blueAccent,
                      onPressed: _openPage,
                      child: Text(
                        "Go To Sub-page",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
