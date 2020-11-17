import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String url;
  String location;
  String flag;
  String time;
  bool isDayTime = true;
  WorldTime({this.url, this.location, this.flag});

  Future<void> getTime() async {
    try {
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offsetHour = data['utc_offset'].substring(1, 3);
      String offsetMinutes = data['utc_offset'].substring(4);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(
          hours: int.parse(offsetHour), minutes: int.parse(offsetMinutes)));
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('error is : $e');
      time = "Couldn't fetch time";
    }
  }
}
