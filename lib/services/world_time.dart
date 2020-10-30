import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location;
  String time;
  String flag;
  String url;
  bool isDay;

  WorldTime({this.location,this.flag,this.url});

  Future<void> getTime() async{

    try {
      //make the request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      //print(datetime);
      //print(offset);

      //create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set the time property
      isDay=(now.hour>6 && now.hour<8) ? true : false;
      time = DateFormat.jm().format(now);
    }

    catch(e){
      print('caught error: $e');
      time='couldn\'t load data';
    }

  }
}
