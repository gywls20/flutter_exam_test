import 'package:flutter/material.dart';
import 'subDetail.dart';
import 'SecondDetail.dart';
import 'thirdDetail.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sub page Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      //home: FirstPage(),
      initialRoute: '/',
      routes: {
        '/': (context)=> FirstPage(), //SubDetail(),
        '/second':(context)=> SecondDetail(),
        '/third':(context)=> ThirdDetail()
      },
    );
  }
}

class FirstPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _FirstPage();
}

class _FirstPage extends State<StatefulWidget>{
  String result = '';
  List? data;

  TextEditingController? _editingController;
  ScrollController? _scrollController;
  int page =1;
  void initState(){
    super.initState();

    data = new List.empty(growable: true);
    _editingController = new TextEditingController();
    _scrollController = new ScrollController();

    _scrollController!.addListener(() {
      if(_scrollController!.offset >= _scrollController!.position.maxScrollExtent && !_scrollController!.position.outOfRange){
        print('bottom');
        page++;
        getJSONData();
      }
    });
  }

  Future<String> getJSONData() async{
    var url = 'https://dapi.kakao.com/v2/search/image?page=$page&query=${_editingController!.value.text}';
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "KakaoAK 9921500163c8990734de7f360146fd51"});
    print(response.body);
    setState(() {
      var dataConvertedToJSON = json.decode(response.body);
      List result = dataConvertedToJSON['documents'];

      data!.addAll(result);

    });
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _editingController,
          style: TextStyle(color: Colors.lime),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: 'enter a search them'),
          onSubmitted: (String value){
            data!.clear(); //데이터 초기화
            getJSONData();
          },
        ),
      ),
      body: Container(
        child: Center(
          child: data!.length == 0
              ? Text('The data is not available.', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,)
              :ListView.builder(itemBuilder: (context, index){
                return Card(
                  child: Container(
                    child: Row(
                      children: [
                        Image.network(
                          data![index]['image_url'],
                          height: 100,width: 100,
                          fit: BoxFit.contain,
                        ),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 150,
                              child:  Text(
                                  data![index]['collection'].toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text('출처: ${data![index]['display_sitename'].toString()}'),
                            Text('날짜: ${data![index]['datetime'].toString()}'),
                            // Text('Status: ${data![index]['status'].toString()}')

                          ],
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                  ),
                );
              },
              itemCount: data!.length,
              controller: _scrollController,
            )

        ),
      ),
    );
  }

}




class SecondPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('second page'),
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('back'),
          ),
        ),
      ),
    );
  }
}


