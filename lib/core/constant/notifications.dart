import 'dart:async';
import '../../data/models/notification/recieved_notification.dart';


int id = 0;
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream =
StreamController<String?>.broadcast();