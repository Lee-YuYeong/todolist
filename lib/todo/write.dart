// 할 일 작성 페이지
import 'package:contact/main.dart';
import 'package:flutter/material.dart';

class Todo {
  final String description;//할 일 내용
  Todo({required this.description});//생성자
}

class Write extends StatefulWidget {
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Write> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  List<Todo> todos = [];//할 일 목록

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        margin: EdgeInsets.fromLTRB(0, 60, 10, 0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
              },
              child: SizedBox(
                  width: double.infinity,
                  child: Text("취소", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),textAlign: TextAlign.end)
              ),
            ),
            Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(10, 50, 0, 20),
                child: Text("오늘 내 할 일은?", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30), textAlign: TextAlign.start,)
            ),
            Flexible(
              fit: FlexFit.loose, //화면 크기를 넘어갈 경우
              child: Container(
                width: double.infinity,
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
                child: TextButton(child: Text("작성 완료!",style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.w400),),
                  onPressed: () {
                    String description = myController.text;
                    todos.add(Todo(description: description));
                    Navigator.pop(context,description);

                  },),

              ),
            )
          ],
        ),
      ),

    );
  }
}
