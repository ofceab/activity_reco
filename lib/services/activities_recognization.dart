import 'dart:async';

import 'package:activities_recognization/utils/constants.dart';
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
        _activityName = IS_LAYING_MESSAGE;
        break;
      case ActivityType.ON_FOOT:
        _activityName = IS_WALKING_ON_FOOT_MESSAGE;
        break;
      case ActivityType.WALKING:
        _activityName = IS_WALKING_MESSAGE;
        break;
      case ActivityType.IN_VEHICLE:
        _activityName = IS_IN_CAR_MESSAGE;
        break;
      case ActivityType.ON_BICYCLE:
        // TODO: Handle this case.
        _activityName = IS_ON_BICYCLE_MESSAGE;
        break;
      case ActivityType.RUNNING:
        // TODO: Handle this case.
        _activityName = IS_RUNNING_MESAGE;
        break;
      case ActivityType.UNKNOWN:
        // TODO: Handle this case.
        _activityName = UNABLE_TO_KNOW_ACTIVITY;
        break;
      default:
        _activityName = NOT_SUPPORT_YET_MESSAGE;
        break;
    }
    return _activityName;
  }
}
