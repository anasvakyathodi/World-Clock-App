import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:worldclock/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var newCities = [];
  Future<void> setCities() async {
    Response cities = await get('http://worldtimeapi.org/api/timezone/');
    setState(() {
      newCities = jsonDecode(cities.body);
    });
  }

  void updateTime(index) async {
    String location = newCities[index].split("/")[1].toString();
    WorldTime newInstance = WorldTime(
        flag: '$location.jpg', location: location, url: newCities[index]);
    await newInstance.getTime();
    Navigator.pop(context, {
      'location': newInstance.location,
      'time': newInstance.time,
      'flag': newInstance.flag,
      'isDayTime': newInstance.isDayTime,
    });
  }

  @override
  void initState() {
    super.initState();
    setCities();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Location'),
      ),
      body: newCities.length > 0
          ? ListView.builder(
              itemCount: newCities.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        updateTime(index);
                      },
                      title: Text(newCities[index].split("/").length > 2
                          ? newCities[index].split("/")[2].toString()
                          : newCities[index].split("/")[1].toString()),
                      subtitle: Text(newCities[index].split("/")[0].toString()),
                    ),
                  ),
                );
              },
            )
          : SpinKitHourGlass(
              color: Colors.black,
              size: 50.0,
            ),
    );
  }
}
