import 'package:activities_recognization/services/activities_recognization.dart';
import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';

///
///Add these permission in your AndroidManifest.xml file
///
/// <uses-permission android:name="android.permission.ACTIVITY_RECOGNITION" />
///
///

class HomeDemoScreen extends StatefulWidget {
  //Get instance of the ActivitiesRecognization class
  @override
  _HomeDemoScreenState createState() => _HomeDemoScreenState();
}

class _HomeDemoScreenState extends State<HomeDemoScreen> {
  final ActivitiesRecognization _activitiesRecognization =
      ActivitiesRecognization.activitiesRecognizationInstance;
  Location _location;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  @override
  void initState() {
    super.initState();

    _getLocationPermission();
  }

  void _getLocationPermission() async {
    _location = Location();
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text('Plugin example app'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<Activity>(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        "We're sure at ${snapshot.data.confidence}% that ${_activitiesRecognization.getNameOfActivity(snapshot.data.type)}!",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.indigo, fontWeight: FontWeight.bold),
                      );
                    }

                    return Text("No activity detected.");
                  },
                  stream: _activitiesRecognization.activities,
                ),
                SizedBox(
                  height: 25,
                ),
                StreamBuilder<LocationData>(
                  stream: _location.onLocationChanged,
                  builder: (context, snaphot) => Text(
                    'Alititude ${snaphot.data.altitude}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.indigo, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
