// 할 일 작성 페이지
// ! : null이 절대 아님을 단언
// ? : null일 수도 있음

import 'package:contact/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import '../main.dart';

var dio = Dio();
class Todo {
  final String todo;//할 일 내용
  Todo({required this.todo});//생성자
}

class Write extends StatefulWidget {
  final String? defaultValue;
  final int? index;
  const Write({this.defaultValue, this.index});

  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Write> {
  final myController = TextEditingController();
  late TodoProvider _todoProvider;
  @override
  void initState() {
    super.initState();
    _todoProvider = Provider.of<TodoProvider>(context, listen:false);
    if (widget.defaultValue != null) {
      myController.text = widget.defaultValue!; // 컨트롤러에 기본값 할당
    }
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () async {
                await Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 60, 10, 10),
                alignment: Alignment.centerRight,
                  child: Text("취소", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200))
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(10, 50, 0, 20),
                child: Text("오늘 내 할 일은?", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30), textAlign: TextAlign.start,)
            ),
            Flexible(
              fit: FlexFit.loose, //화면 크기를 넘어갈 경우
              child: Container(
                width: 800,
                height: 800,
                child: TextField(
                  controller: myController,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                    hintText: '모두 힘을 내 작성해보아요.',
                    labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 20
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyApp()));
              },
              child: Container(
                alignment: Alignment.center,
                child: TextButton(child: Text("작성 완료!",style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                  onPressed: () {
                    String todo = myController.text;
                   if(todo != ""){
                      if(widget.defaultValue == null) {
                        var response = dio.post('https://api2.metabx.io/api/examples', data:{'todo': todo});

                        Navigator.pop(context, response);

                      }else {
                          Navigator.pop(context, todo);
                    }
                   }
                  },),
              ),
            )
          ],
      ),

    );
  }


}