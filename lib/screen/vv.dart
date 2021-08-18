// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:letsgo/resources/addressjson.dart';

// class VVS extends StatefulWidget {
//   @override
//   _VVSState createState() => _VVSState();
// }

// class _VVSState extends State<VVS> {
//   var curLocat = [];
//   var add = [];

//   void getCurLocation(List locList) async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       String lati = position.latitude.toString();
//       String long = position.longitude.toString();
//       print(position);
//       locList.add(lati);
//       locList.add(long);
//     } catch (e) {
//       List er = [];
//       String err = 'error';
//       print(err);
//     }
//   }

//   void locjd(longi, latit, reli) async {
//     AddressJson addressjson = AddressJson(
//         "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=${longi}0,${latit}0&sourcecrs=epsg:4326&output=json");

//     var addressData = await addressjson.getJsonData();
//     reli.add(addressData);
//   }

//   void asyncMethod(List locl) async {
//     print(locl);
//     getCurLocation(locl);
//     locjd(curLocat[1], curLocat[0], add);
//     print(locl);
//   }

//   @override
//   void initState() {
//     super.initState();
//     asyncMethod(curLocat);
//     //현재 주소를 위도, 경도가 있는 리스트로 반환
//   }

//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [Text(curLocat[0]), Text(add[0].toString())],
//       ),
//     );
//   }
// }
