import 'package:flutter/material.dart';

class ThirdDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    final String args = ModalRoute.of(context)!.settings.arguments.toString();


    return Scaffold(
      appBar: AppBar(
        title: Text('Third page'),
      ),
      body: Container(
          child: Center(
            child: Column(
              children: [
                Text(
                  args,
                  style: TextStyle(fontSize: 30),
                ),

              ],
            )

          )
      ),

    );
  }
}