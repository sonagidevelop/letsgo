import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:xml/xml.dart';

class TimeXml {
  final String url;
  TimeXml(this.url);

  Future<dynamic> getXmlData() async {
    http.Response response = await http.get(Uri.parse(url));
    var xmlData = XmlDocument.parse(response.body);
    var parsingData = xmlData.findAllElements('sunset');
    var sunriseData = xmlData.findAllElements('sunrise');
    List allData = [parsingData, sunriseData];
    return allData;
  }
}
