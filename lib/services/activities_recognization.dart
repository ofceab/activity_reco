import 'dart:async';

import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';

class ActivitiesRecognization {
  // Actitivites stream controller
  Stream<Activity> _activitiesController =
      ActivityRecognition.activityUpdates();

  static final ActivitiesRecognization _activitiesRecognization =
      ActivitiesRecognization._();

  // get instance of the ActivitiesRecognization class
  static get activitiesRecognizationInstance => _activitiesRecognization;

  //Internal constructor
  ActivitiesRecognization._();
  //Stream activities
  Stream get activities => this._activitiesController;

  //Convert value to String for easier understanding
  String getNameOfActivity(ActivityType activityType) {
    String _activityName;
    switch (activityType) {
      case ActivityType.STILL:
        _activityName = 'the device is lay';
        break;
      case ActivityType.ON_FOOT:
        _activityName = 'the user is walking';
        break;
      case ActivityType.WALKING:
        _activityName = 'the user is walking with the phone';
        break;
      case ActivityType.IN_VEHICLE:
        _activityName = 'the user is in a car';
        break;
      case ActivityType.ON_BICYCLE:
        // TODO: Handle this case.
        _activityName = 'the user is on bicycle';
        break;
      case ActivityType.RUNNING:
        // TODO: Handle this case.
        _activityName = 'the user is running';
        break;
      case ActivityType.UNKNOWN:
        // TODO: Handle this case.
        _activityName = 'Unable to know that activity for now';
        break;
      default:
        _activityName = 'Not Supported yet';
        break;
    }
    return _activityName;
  }
}
