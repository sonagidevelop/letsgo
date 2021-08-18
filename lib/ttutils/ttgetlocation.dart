import 'package:geolocator/geolocator.dart';
import 'package:letsgo/resources/addressjson.dart';
import 'package:letsgo/resources/getLocation.dart';
import 'package:letsgo/resources/timexml.dart';

class GetMyLocationAllProcess {
  Future<List> getmyLocation() async {
    List gusiandtime = [];

    GetMyLocation mylocation = GetMyLocation();
    await mylocation.getLocation();
    String longi = mylocation.long;
    String latit = mylocation.lati;

    AddressJson addressjson = AddressJson(
        "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=${longi}0,${latit}0&sourcecrs=epsg:4326&output=json");

    var addressData = await addressjson.getJsonData();
    String gu = addressData["results"][1]['region']['area2']['name'];
    String si = addressData["results"][1]['region']['area1']['name'];

    gusiandtime.add(gu);
    gusiandtime.add(si);

    TimeXml timexml = TimeXml(
        'http://apis.data.go.kr/B090041/openapi/service/RiseSetInfoService/getLCRiseSetInfo?ServiceKey=cR1YY2ji2HzxD35o6BnH7GgH46ViNYaXmUFWJ%2FKKXc%2BMYcZNA51AWWyKOPorXp8pHJ6gBLiaXzJ809NDVwgNSg%3D%3D&locdate=20210811&longitude=${longi}&latitude=${latit}&dnYn=Y');

    var timeDataxml = await timexml.getXmlData();
    var timeData = timeDataxml.toString().substring(9, 13);
    gusiandtime.add(timeData);

    return gusiandtime;
  }
}
