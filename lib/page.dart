import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsgo/resources/addressjson.dart';
import 'package:letsgo/resources/getLocation.dart';
import 'package:letsgo/resources/timexml.dart';
import 'package:letsgo/screen/view.dart';

class PageMain extends StatefulWidget {
  PageMain({Key? key, required this.title}) : super(key: key);

  final String title;

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PageMain> {
  String longi = '';
  String latit = '';
  @override
  void initState() {
    super.initState();
    getmyLocation(); //현재 주소를 위도, 경도가 있는 리스트로 반환
  }

  void getmyLocation() async {
    GetMyLocation mylocation = GetMyLocation();
    await mylocation.getLocation();
    longi = mylocation.long;
    latit = mylocation.lati;

    AddressJson addressjson = AddressJson(
        "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=${longi}0,${latit}0&sourcecrs=epsg:4326&output=json");

    var addressData = await addressjson.getJsonData();
    print(addressData);

    TimeXml timexml = TimeXml(
        'http://apis.data.go.kr/B090041/openapi/service/RiseSetInfoService/getLCRiseSetInfo?ServiceKey=cR1YY2ji2HzxD35o6BnH7GgH46ViNYaXmUFWJ%2FKKXc%2BMYcZNA51AWWyKOPorXp8pHJ6gBLiaXzJ809NDVwgNSg%3D%3D&locdate=20210809&longitude=${longi}&latitude=${latit}&dnYn=Y');

    var timeDataxml = await timexml.getXmlData();
    var timeData = timeDataxml.toString().substring(9, 13);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return View(
        addData: addressData,
        timeData: timeData,
      );
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold();
  }
}
