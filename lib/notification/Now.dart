import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as az;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: MystatefulWidget(),
    );
  }
}

class MystatefulWidget extends StatefulWidget {
  const MystatefulWidget({Key? key}) : super(key: key);

  @override
  _MystatefulWidgetState createState() => _MystatefulWidgetState();
}

class _MystatefulWidgetState extends State<MystatefulWidget> {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // double? latitude2;
  // double? longitude2;
  // final _openweatherkey = 'a045afc7e3734446b7c0ec44595205fd';

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

  tz.TZDateTime _setNotiTime() {
    az.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 10, 53);
    return scheduledDate;
  }

  // Future<void> getWeatherData({
  //   @required String? lat,
  //   @required String? lon,
  // }) async {
  //   var str =
  //       'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_openweatherkey&units=metric';
  //   print(str);
  //   var response = await http.get(Uri.parse(str));

  //   if (response.statusCode == 200) {
  //     var data = response.body;
  //     var dataJson = jsonDecode(data);
  //     print('data =$data');
  //     print('${dataJson['main']['temp']}');
  //     print('${dataJson['sys']['country']}');
  //     print('${dataJson['name']}');
  //     print('${dataJson['weather'][0]['main']}');
  //     print('${dataJson['weather'][0]['description']}');
  //     // var myJsondata = jsonDecode(data)['main']['temp'];
  //     // print(myJsondata); 로도 쓸 수 있다.
  //   } else
  //     print('response status code = ${response.statusCode}');
  // }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    print("스크린 높이: ${screenSize.height}");

    var _navigationBar = CupertinoNavigationBar(
        border: null,
        backgroundColor: CupertinoColors.systemGrey.withOpacity(0),
        middle: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: Text(
              '여 기',
              style: TextStyle(color: CupertinoColors.systemGrey, fontSize: 15),
            )),
            Container(
              child: Text(
                '서울특별시 영등포구 여의도동',
                style: TextStyle(color: CupertinoColors.black),
              ),
            )
          ],
        ));

    return CupertinoPageScaffold(
        navigationBar: _navigationBar,
        child: SafeArea(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // Expanded(
          //   child: Container(
          //     child: Text(
          //       '일몰까지 남은 시간: 1시간 \n\n 일몰 90% 완료',
          //       textAlign: TextAlign.center,
          //     ),
          //     alignment: Alignment.bottomCenter,
          //     color: CupertinoColors.lightBackgroundGray,
          //     padding: EdgeInsets.all(30),
          //     margin: EdgeInsets.zero,
          //   ),
          //   flex: 1,
          // ),
          // color: CupertinoColors.lightBackgroundGray,
          // padding: EdgeInsets.all(50),
          // margin: EdgeInsets.zero,
          // height: 200,
          Expanded(
            child: Container(
                decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/여의도_한강_일몰.jpeg'),
                fit: BoxFit.cover,
              ),
            )),
          ),
          // child: Container(
          //   decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //     colors: [
          //       CupertinoColors.systemBlue.withOpacity(0.2),
          //       CupertinoColors.systemPurple.withOpacity(0.6),
          //     ],
          //     stops: [0, 0, 1],
          //     begin: Alignment.topCenter,
          //   )),
          //   child: Align(
          //     alignment: Alignment.centerLeft,
          //     child: Container(
          //       width: 300,
          //       margin: EdgeInsets.only(top: 200),
          //       padding: EdgeInsets.all(16),
          //       decoration: BoxDecoration(
          //         gradient: LinearGradient(
          //           colors: [
          //             CupertinoColors.systemPurple,
          //             CupertinoColors.systemPink.withOpacity(0)
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // )),
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                ElevatedButton(
                  onPressed: _showNotificationAtTime,
                  child: Text('노을 알람'),
                )
              ])),
        ])));
  }
}
