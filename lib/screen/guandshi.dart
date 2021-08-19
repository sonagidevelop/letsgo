import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:letsgo/resources/addressjson.dart';
import 'package:letsgo/resources/getLocation.dart';
import 'package:letsgo/resources/timexml.dart';
import 'package:letsgo/ttutils/ttgetlocation.dart';
import 'package:timer_builder/timer_builder.dart';

class GuAndShi extends StatefulWidget {
  @override
  _GuAndShiState createState() => _GuAndShiState();
}

class ClockWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TimerBuilder.periodic(
      Duration(minutes: 1),
      builder: (context) {
        return Text("${DateTime.now()}");
      },
    );
  }
}

class _GuAndShiState extends State<GuAndShi> {
  get dateTime => null;

  Future<List> getmyLocation() async {
    List gusiandtime = [];

    GetMyLocation mylocation = GetMyLocation();
    await mylocation.getLocation();
    String longi = mylocation.long;
    String latit = mylocation.lati;
    String dateStr = DateFormat('yyyyMMdd').format(DateTime.now());

    AddressJson addressjson = AddressJson(
        "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=${longi}0,${latit}0&sourcecrs=epsg:4326&output=json");

    var addressData = await addressjson.getJsonData();
    String gu = addressData["results"][1]['region']['area2']['name'];
    String si = addressData["results"][1]['region']['area1']['name'];

    gusiandtime.add(gu);
    gusiandtime.add(si);

    TimeXml timexml = TimeXml(
        'http://apis.data.go.kr/B090041/openapi/service/RiseSetInfoService/getLCRiseSetInfo?ServiceKey=cR1YY2ji2HzxD35o6BnH7GgH46ViNYaXmUFWJ%2FKKXc%2BMYcZNA51AWWyKOPorXp8pHJ6gBLiaXzJ809NDVwgNSg%3D%3D&locdate=${dateStr}&longitude=${longi}&latitude=${latit}&dnYn=Y');

    var timeDataxml = await timexml.getXmlData();
    print(timeDataxml);
    var timeData = timeDataxml.toString().substring(10, 14);
    var riseTimeData = timeDataxml.toString().substring(38, 42);
    String fs = timeData.substring(0, 2);
    String bs = timeData.substring(2);
    String rfs = riseTimeData.substring(0, 2);
    String rbs = riseTimeData.substring(2);
    String fd = DateFormat('yyyy-MM-dd').format(DateTime.now());

    var noeulTime = fs + ':' + bs;
    var riseTime = rfs + ':' + rbs;

    String noeulStr = fd + ' ' + noeulTime;
    String riseStr = fd + ' ' + riseTime;
    DateTime ndt = new DateFormat('yyyy-MM-dd HH:mm').parse(noeulStr);
    DateTime rdt = new DateFormat('yyyy-MM-dd HH:mm').parse(riseStr);

    Duration diff = ndt.difference(DateTime.now());
    Duration diffRise = rdt.difference(DateTime.now());
    int lm = diff.inMinutes.toInt() + 1;
    int rlm = diffRise.inMinutes.toInt();
    Timer(Duration(minutes: 1), () {
      setState(() {
        if (lm > 0) {
          lm--;
        } else {
          lm;
        }
      });
    });
    String km = lm.toString();
    String rkm = rlm.toString();
    String getTimeString(int value) {
      final int hour = value ~/ 60;
      final int minutes = value % 60;
      return '${hour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}';
    }

    String nlt = getTimeString(lm);
    String rlt = getTimeString(rlm);

    // TimerBuilder _timerBuilder;

    // _timerBuilder =
    //     TimerBuilder.periodic(Duration(minutes: 1), builder: (context) {
    //   setState(() {
    //     if (lm > 0) {
    //       lm--;
    //     } else {
    //       "";
    //     }
    //   });
    //   return Text(nlt);
    // });

    var leftNoeulTime = nlt;
    var leftRiseTime = rlt;
    gusiandtime.add(noeulTime);
    gusiandtime.add(leftNoeulTime);
    gusiandtime.add(leftRiseTime);
    gusiandtime.add(riseTime);

    // gusiandtime.add(diff);

    return gusiandtime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color(0xff7faeff),
                Color(0xffe0bfff),
                Color(0xffffa67f),
                Color(0xffff6a7a),
              ])),
          child: SafeArea(
            child: Column(
              children: [
                FutureBuilder(
                    future: getmyLocation(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                      if (snapshot.hasData == false) {
                        return CircularProgressIndicator();
                      }
                      //error가 발생하게 될 경우 반환하게 되는 부분
                      else if (snapshot.hasError) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                      }
                      // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                      else {
                        print(snapshot.data);
                        String si = snapshot.data[1];
                        String gu = snapshot.data[0];
                        String time = snapshot.data[2];
                        String leftTime = snapshot.data[3];
                        String leftRiseTime = snapshot.data[4];
                        String riseTime = snapshot.data[5];
                        // DateTime testTime = snapshot.data[5];

                        return Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                // TimerBuilder.periodic(Duration(minutes: 1),
                                //     builder: (context) {
                                //   return Text("${dateTime.now()}");
                                // }),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      si,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(" "),
                                    Text(
                                      gu,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(
                                  "sunset $time",
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                Text(
                                  "sunrise $riseTime",
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                Text(
                                  "노을까지 ${leftTime}분 남았습니다.",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "일출까지 ${leftRiseTime}분 남았습니다.",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                // TimerBuilder.periodic(
                                //     const Duration(minutes: -1),
                                //     builder: (context) {
                                //   return Text("$testTime");
                                // })
                              ],
                            ));
                      }
                    }),
              ],
            ),
          )),
    );
  }
}
