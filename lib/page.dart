import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:letsgo/resources/addressjson.dart';
import 'package:letsgo/resources/getLocation.dart';
import 'package:letsgo/resources/timexml.dart';
import 'package:letsgo/screen/guandshi.dart';
import 'package:letsgo/screen/view.dart';
import 'package:timezone/data/latest.dart' as az;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

class PageMain extends StatefulWidget {
  PageMain({Key? key, required this.title}) : super(key: key);

  final String title;

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PageMain> {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    var androidSetting = AndroidInitializationSettings('app_icon');
    var iosSetting = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});
    var initializationSettings =
        InitializationSettings(android: androidSetting, iOS: iosSetting);

    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    _showNotificationAtTime();
    print("알림 작동");
  }

  void _showNotificationAtTime() async {
    var type = 'yyyy-MM-dd (E) a HH:mm:ss';
    var sunsetAlarmDate = DateFormat(type).format(DateTime.now());
    print(sunsetAlarmDate);
    var android = AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription',
        importance: Importance.max, priority: Priority.high);
    var ios = IOSNotificationDetails();
    var detail = NotificationDetails(android: android, iOS: ios);
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        0, '제목', '내용', _setNotiTime(), detail,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  Future<void> onSelectNotification(String? payload) async {
    debugPrint('$payload');
    showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text('sdsdsdsd'),
              content: Text('Payload: $payload'),
            ));
  }

  tz.TZDateTime _setNotiTime() {
    az.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 13, 22);
    return scheduledDate;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: GuAndShi(),
    );
  }
}
