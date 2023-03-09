import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:waterfall_flow_example/api.dart';
import 'package:waterfall_flow_example/global.dart';
import 'package:waterfall_flow_example/models/art.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int currentPage = 0;
  int lastPage = 0;
  List<Art> artList = [];
  getArt(){
    int page = currentPage + 1;

    //页数大于总页数，则直接返回加载完成
    if(page > 1 && page > lastPage) {
      return false;
    }
    Api.init().get('/api/getArt', data: {}, queryParameters: {'page': page, 'artist_id': 0, 'type_id': 0, 'title':''}).then((value) {
      print(value.data['data']['list']);
      for (var o in value.data['data']['list']['data']) {
        artList.add(Art.fromJson(o));
      }
      setState(() {
        currentPage = value.data['data']['list']['current_page'];
        lastPage = value.data['data']['list']['last_page'];
        artList;

      });
    });
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    getArt();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: CustomScrollView(
            slivers: <Widget>[

          SliverWaterfallFlow(
          gridDelegate:
          SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            lastChildLayoutTypeBuilder: (index) => index == artList.length-1
                ? LastChildLayoutType.foot
                : LastChildLayoutType.none,
            // collectGarbage: (List<int> garbages) {
            // print('collect garbage : $garbages');
            // },
            viewportBuilder: (int firstIndex, int lastIndex) {
              if(lastIndex + 1 == artList.length) {
                getArt();
              }
            },
          ),
        delegate:
        SliverChildBuilderDelegate((BuildContext c, int index) {
          Widget item = const Padding(padding: EdgeInsets.all(3));
          if (artList.length == index + 1) {
            item = Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('～到底啦～'),
                )
              ],
            );
          }else if (artList.isNotEmpty) {
            Art art = artList[index];
            String imageUrl = Global.getImageUrl(art.thumb.url, width: 200);
            print(imageUrl);
            item = GestureDetector(
              onTap: ()=>{
                // artController.goArtInfo(art)
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.fill,
                    placeholder: (context, val){
                      return Image.asset('assets/images/defaultImg.png', fit: BoxFit.fill,);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(4)),
                  Text(art.title, style: TextStyle(
                      color: const Color.fromRGBO(51, 51, 51, 1),
                      fontSize: 16
                  ),),
                  Text('${art.sizeW}-${art.sizeH}cm',style: const TextStyle(
                      color: Color.fromRGBO(153, 153, 153, 1)
                  ),),
                  Text(art.typeName, style: const TextStyle(
                      color: Color.fromRGBO(153, 153, 153, 1)
                  )),
                  Text.rich(TextSpan(
                      children: [
                        TextSpan(
                            text: '¥${art.recommendPrice}元', style: const TextStyle(
                            color: Color.fromRGBO(51, 51, 51, 1)
                        )
                        )
                      ]
                  ))
                ],
              ),
            );
          }
          return item;
        }, childCount: artList.length),
      )

            ],
          ),
        ),
    );
  }
}
