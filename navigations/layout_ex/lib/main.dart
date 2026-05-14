import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Layout(),
    );
  }
}

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  bool star = true;
  int count = 41;

  @override
  Widget build(BuildContext context) {
    Widget imageSection = Image.network(
      'https://cdn.thetrippick.com/news/photo/202507/289_1002_342.jpg',
      height: 240,
      width: 600,
      fit: BoxFit.cover,
    );

    Widget titleSection = Container(
      padding: EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Songjeong Beach',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Busan, South Korea',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: star
            ? Icon(Icons.star)
            : Icon(Icons.star_border),
            color: Colors.red,
            onPressed: (){
              setState(() {
                if(star){
                  star = !star;
                  count = count - 1;
                }else{
                  star = !star;
                  count = count + 1;
                }
              });
            },
          ),
          Text('$count'),
        ],
      ),
    );

    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Icon(Icons.call, color: Colors.blue,),
            Text('CALL', style: TextStyle(color: Colors.blue),),
          ],
        ),
        Column(
          children: [
            Icon(Icons.near_me, color: Colors.blue,),
            Text('ROUTE', style: TextStyle(color: Colors.blue),),
          ],
        ),
        Column(
          children: [
            Icon(Icons.share, color: Colors.blue,),
            Text(
              'SHARE',
              style: TextStyle(color: Colors.blue),),
          ],
        ),
      ],
    );

    Widget textSection = Container(
      padding: EdgeInsets.all(32),
      child: const Text(
        '송정 해수욕장은 부산의 대표적인 서핑 명소로 유명합니다. '
            '해운대와 달리 비교적 한적하고 자연 친화적인 분위기를 간직하고 있으며, '
            '경사가 완만하고 파도가 잔잔해 초보 서퍼와 가족 피서객 모두에게 사랑받고 있습니다. '
            '특히 넓고 깨끗한 백사장과 맑은 바다 덕분에 여유로운 휴식을 즐기기에 적합하며, '
            '인근에는 다양한 카페와 맛집이 있어 여행객들에게 인기 있는 관광지로 자리 잡고 있습니다. '
            '여름철을 중심으로 서핑을 즐기는 사람들이 많아 부산의 대표적인 해양 레저 명소로 알려져 있습니다.',
      ),
    );

    return Scaffold(
        appBar: AppBar(
            title: Text('Flutter example')
        ),
        body: ListView(
          children: [
            imageSection,
            titleSection,
            buttonSection,
            textSection
          ],
        )
    );
  }
}

