// todolist 메인페이지

import 'package:contact/todo/write.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp()); //runApp(시작할 메인페이지) : 앱을 시작해주세요~!
}

List<String> todos = ['앱 리뉴얼 진행하기', '앱 리뉴얼 진행하기', '앱 리뉴얼 진행하기']; //진행 목록
List<String> award = ['끝내주는 소비 생활하기', '끝내주는 소비 생활하기','끝내주는 소비 생활하기']; //명예의 전당

//stless + Enter > 자동완성
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,//디버그 배너 삭제
      theme: ThemeData(fontFamily: 'Jua-Regular'),//폰트 설정
      home: First(),
    );
  }
}
class First extends StatefulWidget {
  //StatelessWidget에선 setState()사용 못하므로 StatefulWidget을 상속 받도록 해줌
  const First({Key? key}) : super(key: key);

  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Write()));
              if (result != null) {

                setState(() {
                  todos.insert(0,result);
                });
              }
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(15, 70, 10, 10),
              child: Row(
                children: [
                  Text("7월 17일",style: TextStyle(fontWeight: FontWeight.w500, fontSize: 50, ), ),
                  GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Write()));

                        if (result != null) {
                          setState(() {
                            todos.insert(0,result);
                          });
                        }
                      },
                      child : Icon(Icons.add, size: 50,)
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 10, 0),
            child: Row(
              children: [
                Text("진행 목록",style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, ),),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 250,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: todos.length,
                    itemBuilder: (BuildContext content, int index) {
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.all(8),
                        color: Color(0xfff3eae0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                        ),
                        child: ListTile(
                          title: Text(todos[index], textAlign: TextAlign.center, style: TextStyle(fontSize: 18, height: 1.7),),
                          onTap: () => _showDialog(context,index),
                        ),
                      );
                    }),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 30, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.emoji_events_sharp, size: 50,color: Color(0xffffe6af),),
                    Text("명예의 전당", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),)
                  ],
                )
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 250,
                child: ListView.builder(
                    scrollDirection: Axis.vertical, //스크롤이 증가하는 방향
                    shrinkWrap: true,//true 시 필요한 공간만 차지
                    itemCount: award.length,
                    itemBuilder: (BuildContext content, int index) {
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.all(8),
                        color: Color(0xfff3eae0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                        ),
                        child: ListTile(
                          title: Text(award[index], textAlign: TextAlign.center, style: TextStyle(fontSize: 18, height: 1.7),),
                          onTap: () => _awardshowDialog(content, index),
                        ),
                      );
                    }),
              ),
            ],
          )
        ],
      ),
    );
  }

  //할 일 목록 다이어로그
  void _showDialog(context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("목표를 완료 하셨습니까?", textAlign: TextAlign.center,),
          content:
               SingleChildScrollView(
                  child:new Text("완료된 항목은 하단 명예의 전당에 표시 됩니다.",textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w200),)
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          actions: <Widget>[
            Container(
              child: OutlinedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xffffffff),minimumSize: Size(150, 50), ),
                onPressed: () {
                  setState(() {
                    award.add(todos[index]); // 명예의 전당 리스트 추가
                    todos.removeAt(index); // 진행 목록 삭제
                  });
                  Navigator.of(context).pop(); //창 닫기
                },
                child: Text('확인',style: TextStyle(color: Colors.red),),
              ),
            ),
            Container(
              child: OutlinedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xffffffff), minimumSize: Size(150, 50)),
                onPressed: () {
                  Navigator.of(context).pop(); //창 닫기
                },
                child: Text('취소', style: TextStyle(color: Colors.black),),
              ),
            )
          ],
        );
      },
    );
  }

  //명예의 전당 다이어로그
  void _awardshowDialog(context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("수정 또는 삭제", textAlign: TextAlign.center,),
          content:
          SingleChildScrollView(
              child:new Text("항목을 수정하거나 삭제할 수 있습니다.", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w200))
          ),
          actions: <Widget>[
            Container(
              child: OutlinedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xffffffff), minimumSize: Size(150, 50)),
                onPressed: () async {
                  final result = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Write()));

                  if(result != null){
                    setState(() {
                      award[index] = result; // 작성한 값을 해당하는 index값으로 변경
                    });
                  }
                  Navigator.of(context).pop(); //창 닫기

                },
                child: Text('수정',style: TextStyle(color: Colors.black),),
              ),
            ),
            Container(
              child: OutlinedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xffffffff), minimumSize: Size(150, 50)),
                onPressed: () {
                  setState(() {
                    award.removeAt(index); //index에 있는 값 삭제
                  });
                  Navigator.of(context).pop(); //창 닫기
                },
                child: Text('삭제', style: TextStyle(color: Colors.black),),
              ),
            )
          ],
        );
      },
    );
  }


}






