import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime
{

  late String location; //Location name for the UI
  late String time; //The time in that location
  late String flag; //url to an asset flag icon
  late String url; //Location url for api endpoint
  late bool isDayTime; //True or false if day time or not

  WorldTime({required this.location,required this.flag,required this.url});


  Future<void> getTime() async {

    try
    {
      //make the request
      var url1 = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      http.Response response = await http.get(url1);
      Map data = jsonDecode(response.body);
      // print(data);

      //get properties from data
      String datetime = data['utc_datetime'];
      String offset = data['utc_offset'].substring(1,3);
      //print(offset);

      //Create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set the time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);

    }catch(e)
    {
      print('caught error: $e');
      time = 'could not get time data';
    }

  }

}

