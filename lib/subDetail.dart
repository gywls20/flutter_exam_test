
import 'package:flutter/material.dart';


class SubDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SubDetail();
}

class _SubDetail extends State<SubDetail>{
  List<String> todoList = new List.empty(growable: true);

  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    todoList.add('하나');
    todoList.add('둘');
    todoList.add('셋');
    todoList.add('넷');
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Detail - 메인화면'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index){
          return Card(
            child: InkWell(
              child: Text(
                todoList[index],
                style: TextStyle(fontSize: 30),
              ),
              onTap: (){
                Navigator.of(context).pushNamed('/third', arguments: todoList[index]);
              },
            ),
          );
        },
        itemCount: todoList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _addNavigation(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // + 함수
  void _addNavigation(BuildContext context) async{
    final result = await Navigator.of(context).pushNamed('/second');
    setState(() {
      todoList.add(result as String);
    });
  }


}

