import 'package:http/http.dart' as http;
import 'dart:convert';

class AddressJson {

  final String url;
  AddressJson(this.url);

  Map<String, String> test = {
    "X-NCP-APIGW-API-KEY-ID": "n9hamqjko2",
    "X-NCP-APIGW-API-KEY": "H0oYKsp8RuG0tn63J3geayID1VrBDVeeXuchqMSa"
  };

  Future<dynamic> getJsonData() async {
    http.Response response = await http.get(Uri.parse(url), headers: test);
    String jsonData = response.body;
    var parsingData = jsonDecode(jsonData);
    return parsingData;
  }
}
