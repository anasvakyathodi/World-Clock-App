import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  String bgImage;
  Color fontColor;
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    bgImage = data['isDayTime'] ? 'assets/daytime.jpg' : 'assets/nighttime.jpg';
    fontColor = data['isDayTime'] != null && data['isDayTime']
        ? Colors.black87
        : Colors.white;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(bgImage),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: const EdgeInsets.only(top: 120.0),
            child: Column(
              children: [
                FlatButton.icon(
                  icon: Icon(Icons.location_on, color: fontColor),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(color: fontColor),
                  ),
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    print(result);
                    setState(() {
//                      data = {
//                        'location': result['location'],
//                        'time': result['time'],
//                        'flag': result['flag'],
//                        'isDayTime': result['isDayTime'],
//                      };
                      data = result;
                    });
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style: TextStyle(
                          fontSize: 24.0,
                          letterSpacing: 2.0,
                          color: data['isDayTime'] != null && data['isDayTime']
                              ? Colors.black87
                              : Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 66.0,
                    color: fontColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
