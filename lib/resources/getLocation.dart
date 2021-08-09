import 'package:geolocator/geolocator.dart';

class GetMyLocation {
  String lati = '';
  String long = '';

  Future<void> getLocation() async {
  try {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lati = position.latitude.toString();
    long = position.longitude.toString();

    
  } catch (e) {
    String err = 'error';
    print(err);
    
  }
}
}


