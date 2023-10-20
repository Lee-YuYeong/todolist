// todolist 메인페이지
//FutureBuilder는 Flutter의 위젯으로, Future 형태의 비동기 데이터를 다루기 쉽게 도와주는 위젯
//생명 주기
// initState() : 위젯 초기화
// didChangeDependencied() : 의존성 변경시 호출
// didUpdateWidget() : 위젯 갱신 시
// setState() : 상태 변경 시

import 'package:contact/provider/provider.dart';
import 'package:contact/todo/write.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

import 'api_client/fetchdata.dart';
import 'model/todosVO.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodoProvider()),
      ],
      child: MyApp(),
    ),
  );
}

var dio = Dio();

//stless + Enter > 자동완성
class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Jua-Regular'),
      home: TodosWidget(),
    );
  }
}

late TodoProvider _todoProvider;
class TodosWidget extends StatefulWidget {
  const TodosWidget({Key? key}) : super(key: key);

  @override
  _TodosWidgetState createState() => _TodosWidgetState();
}

class _TodosWidgetState extends State<TodosWidget> {
  late Future<List<Todos>> futureTodos;
  late Future<List<Todos>> futureAward;

  late TodoProvider _todoProvider;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _todoProvider = Provider.of<TodoProvider>(context, listen:false);
    futureTodos = fetchData(isSuccess : 0, todoProvider: _todoProvider);
    futureAward = fetchData(isSuccess : 1, todoProvider: _todoProvider);
  }

  // void todoRender() {
  //   setState(() {
  //     futureTodos = fetchData(isSuccess: 0, todoProvider: _todoProvider);
  //   });
  // }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.fromLTRB(15, 70, 10, 10),
              child: Row(
                children: [
                  Text("7월 17일",style: TextStyle(fontWeight: FontWeight.w500, fontSize: 50, ), ),
                  GestureDetector(
                      onTap: () async {
                        var result = await Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Write()));

                        if(result != null) {
                          // _todoProvider.todos.clear();
                          // todoRender();
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

          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,//child 크기만큼 할당
                itemCount: _todoProvider.todos.length,
                itemBuilder: (BuildContext content, int index) {
                  List<Todos> todos = _todoProvider.todos;
                  Todos todo = todos[index];

                  return Card(
                    elevation: 3,//음영 지정
                    margin: EdgeInsets.all(8),
                    color: Color(0xfff3eae0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.elliptical(10, 10)),
                    ),
                    child :
                    ListTile(title :
                    Text(todo.todo!, textAlign: TextAlign.center,),
                      onTap: () =>_showDialog(content,index),
                    ),
                  );
                }),
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

          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,//child 크기만큼 할당
                itemCount: _todoProvider.awards.length,
                itemBuilder: (BuildContext content, int index) {
                  List<Todos> awards = _todoProvider.awards;
                  Todos award = awards[index];

                  return Card(
                    elevation: 3,//음영 지정
                    margin: EdgeInsets.all(8),
                    color: Color(0xfff3eae0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.elliptical(10, 10)),
                    ),
                    child :
                    ListTile(title :
                    Text(award.todo!, textAlign: TextAlign.center,),
                      onTap: () =>_showDialog(content,index),
                    ),
                  );
                }),
          ),
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
              style: OutlinedButton.styleFrom(foregroundColor: Color(0xffffffff),minimumSize: Size(150, 50), ),
              onPressed: () {
                final response = dio.put(
                    'https://api2.metabx.io/api/examples/${_todoProvider.todos[index].idx}/status')
                    .then((value) => Dio().get(
                    "https://api2.metabx.io/api/examples"));

                  _todoProvider.completeTask(index);

                Navigator.of(context).pop(); //창 닫기
              },
              child: Text('확인',style: TextStyle(color: Colors.red),),
            ),
          ),
          Container(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(foregroundColor: Color(0xffffffff), minimumSize: Size(150, 50)),
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
              style: OutlinedButton.styleFrom(foregroundColor: Color(0xffffffff), minimumSize: Size(150, 50)),
              onPressed: () async {
                final result = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Write(defaultValue:_todoProvider.awards[index].todo, index : index)));

                Navigator.of(context).pop(); //창 닫기


                    _todoProvider.updateAward(index, result);

                final response = await dio.put(
                    'https://api2.metabx.io/api/examples/${_todoProvider.awards[index].idx}', data: {"todo" : result})
                    .then((value) => Dio().get(
                    "https://api2.metabx.io/api/examples"));

              },
              child: Text('수정',style: TextStyle(color: Colors.black),),
            ),
          ),
          Container(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(foregroundColor: Color(0xffffffff), minimumSize: Size(150, 50)),
              onPressed: () async {
                Navigator.of(context).pop(); //창 닫기
                final response = await dio.delete(
                    'https://api2.metabx.io/api/examples/${_todoProvider.awards[index].idx}');

                  _todoProvider.deleteAward(index);

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

// }