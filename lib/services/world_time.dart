import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // Location name for the UI
  String time = ''; // The time in that location
  String flag; // URL to an asset flag icon
  String url; //Location URL for api endpoints
  bool isDaytime = false;
  String bgImage = '';

  WorldTime({
    required this.location,
    required this.flag,
    required this.url,
  });

  Future<void> getTime() async {
    try {
      //make the request
      final response = await http
          .get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      //get properties from data
      String datetime = '';
      String offset = '';

      datetime = data['datetime'];
      offset = data['utc_offset'].substring(1, 3);

      //create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set the time proprety
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      if (isDaytime == true) {
        bgImage = 'day.png';
      } else {
        bgImage = 'night.png';
      }

      time = DateFormat.jm().format(now);
    } catch (e) {
      time = 'Could not get time data';
    }
  }
}
