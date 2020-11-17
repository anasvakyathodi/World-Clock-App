import 'package:flutter/material.dart';
import 'package:worldclock/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void setupWorldTime() async {
    WorldTime instance = WorldTime(
      location: 'Kolkata',
      flag: 'Kerala.jpg',
      url: 'Asia/Kolkata',
    );
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'time': instance.time,
      'flag': instance.flag,
      'isDayTime': instance.isDayTime,
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Center(
          child: SpinKitHourGlass(
            color: Colors.white,
            size: 50.0,
          ),
        ),
      ),
    );
  }
}
