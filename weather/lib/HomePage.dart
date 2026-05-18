import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; //

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool gps = false;

  Map<String, dynamic>? weatherData;
  Color background = Color(0xFFB1D1CF);

  String url = "https://api.openweathermap.org/data/2.5/weather?";
  String lat ="";
  String lon ="";
  String appid = "appid=1b7a18da59f9443d39a2e3be55d1edba&";
  String units = "units=metric";

  var vackground = Color(0xFFB1D1CF);
  var textground = Color(0xFF9DBBB9);
  String image = "images/cold_mountain.png";

  DateFormat formatter = DateFormat('H시 m분 s초');
  DateFormat sun = DateFormat('H시 m분');

  void permission() async {
    await Geolocator.requestPermission();
    var value = await Geolocator.checkPermission();

    if (value == LocationPermission.always ||
        value == LocationPermission.whileInUse) {
      gps = true;
    } else {
      gps = false;

      http.Response response = await http.get(
        Uri.parse(url + lat + lon + appid + units),
        headers: {"Accept": "application/json"},
      );

      print("Response body: ${response.body}");
      weatherData = jsonDecode(response.body);
    }

    setState(() {});
  }


  Future<Map<String, dynamic>> getData() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    lat = "lat=${position.latitude}&";
    lon = "lon=${position.longitude}&";

    http.Response response = await http.get(
      Uri.parse(url + lat + lon + appid + units),
      headers: {"Accept": "application/json"},
    );

    print("요청 주소: ${url + lat + lon + appid + units}");
    print("응답 내용: ${response.body}");

    Map<String, dynamic> weatherData = jsonDecode(response.body);

    if (weatherData['main'] == null) {
      throw Exception(weatherData['message']);
    }

    if (weatherData['main']['temp'] < 22) {
      background = const Color(0xFFB1D1CF);
      image = "images/cold_mountain.png";
      textground = Color(0xFF9DBBB9);
      print('cold');
    } else {
      background = const Color(0xFFF5CE8B);
      image = "images/hot_mountain.png";
      textground = Color(0xFFE5AB48);
      print('hot');
    }

    return weatherData;
  }

  Future<void> _onRefresh() async {
    await getData();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    permission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF7FF),
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
              ),
              child: Row(
                children: [
                  Text(
                      'Weather Apps',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.share, color: Colors.black),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                            image: NetworkImage(
                                'https://static.vecteezy.com/system/resources/previews/041/854/206/non_2x/cloud-with-sun-cartoon-icon-hand-drawn-weather-forecast-logo-illustration-isolated-on-a-white-with-blue-background-free-vector.jpg')
                        )
                      ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('reasley',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                 ),
                 Text('sojeong26123@gmail.com', style: TextStyle(
                   color: Colors.black
                 ),
                 ),
                  Divider(color: Colors.black,),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  )
                ],
              ),
            )
          ],
        ),
      ),

      body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(icon: Icon(Icons.menu),
                        onPressed: (){
                          _scaffoldKey.currentState!.openDrawer();
                        },),
                      Spacer(),
                      Text('Weather Apps'),
                      Spacer(),

                      gps == true
                          ? IconButton(icon: Icon(Icons.gps_fixed),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('위치정보를 정상적으로 받아오고 있습니다.')),
                          );
                        },
                      )
                          : IconButton(icon: Icon(Icons.gps_not_fixed),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('위치정보가 정상적이지 못합니다.')),
                          );
                        },
                      )
                    ],
                  ),

          FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text("오류: ${snapshot.error}");
              }

              if (!snapshot.hasData) return CircularProgressIndicator();

              return Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 40),
                color: background,
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Text(
                      "${snapshot.data['weather'][0]['main']}",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 16,
                        ),
                        Text(
                          "${snapshot.data['name']}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                Column( // ✅ [추가] 전체를 Column으로 감쌈 (위-아래 구조 만들기)
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${snapshot.data['main']['temp'].toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: 65,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "°C",
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_up,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                Text(
                                  "${snapshot.data['main']['temp_max'].toStringAsFixed(0)}°C",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_up,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                Text(
                                  "${snapshot.data['main']['temp_min'].toStringAsFixed(0)}°C",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    //step4
                    SizedBox(height: 10),
                    Image.network('https://openweathermap.org/img/wn/${weatherData?['weather']?[0]?['icon'] ?? '01d'}@2x.png',),
                    Image.asset(image, width: MediaQuery.of(context).size.width,),

                    //step5
                    Container(
                      padding: EdgeInsets.only(right: 10, top: 10),
                      alignment: Alignment.centerRight,
                      child: Text('Last Updated: ${formatter.format(DateTime.now())}'),
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: textground,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('More information',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            SizedBox(height: 10,),
                            IntrinsicHeight(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.water_damage, color: Colors.white,),
                                    Column(
                                      children: [
                                        Text('Humidity'),
                                        Text('${snapshot.data['main']['humidity'].toStringAsFixed(0)}%')], ),

                                    Icon(Icons.remove_red_eye, color: Colors.white,),
                                    Column(
                                      children: [
                                        Text('Visibility'),
                                        Text('${snapshot.data['visibility']}')
                                      ],
                                    ),

                                    Icon(Icons.water_damage, color: Colors.white,),
                                    Column(
                                      children: [
                                        Text('Country'),
                                        Text('${snapshot.data['sys']['country']}'),
                                      ],
                                    ),
                                  ]),
                            ),

                                SizedBox(height: 20,),
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      infoSpace(Icons.speed, 'wind Speed', '${snapshot.data['wind']['speed']}'),
                                      VerticalDivider(color: Colors.white,),
                                      infoSpace(Icons.speed, 'wind Deg', '${snapshot.data['wind']['speed']}'),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 20,),
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      infoSpace(
                                        Icons.wb_sunny,
                                        'Sunset',
                                        sun.format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                            snapshot.data['sys']['sunset'] * 1000,
                                          ),
                                        ),
                                      ),
                                      VerticalDivider(color: Colors.white),
                                      infoSpace(
                                        Icons.nights_stay,
                                        'Sunrise',
                                        sun.format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                            snapshot.data['sys']['sunrise'] * 1000,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
                  ],
                ),
              );
            },
          ),
                ],
              ),


            ),
          ),
        ),
      );
    }

  Widget infoSpace(IconData icons, String topText, String bottomText) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            icons,
            color: Colors.white,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 5,
            child: Column(
              children: [
                Text(topText),
                Text(bottomText),
              ],
            ),
          ),
        ],
      ),
    );
  }
}