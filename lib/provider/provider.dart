// todo_provider.dart
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

import '../main.dart';



// class Todos {
//   int? idx;
//   String? todo;
//   int? isSuccess;
//   String? createAt;
//
//   Todos({this.idx, this.todo, this.isSuccess, this.createAt});
//
//   Todos.fromJson(Map<String, dynamic> json) {
//     idx = json['idx'];
//     todo = json['todo'];
//     isSuccess = json['isSuccess'];
//     createAt = json['createAt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['idx'] = this.idx.toString();
//     data['todo'] = this.todo;
//     data['isSuccess'] = this.isSuccess.toString(); // 문자열로 변환
//     data['createAt'] = this.createAt;
//     return data;
//   }
// }

class TodoProvider with ChangeNotifier {

  final List<Todos> _todos = [];
  final List<Todos> _awards = [];

  List<Todos> get todos => _todos;
  List<Todos> get awards => _awards;

  void addTodo(Todos todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void awardTodo(Todos todo) {
    _awards.add(todo);
    notifyListeners();
  }

  void completeTask(int index) {
    awards.add(Todos(idx: todos[index].idx, todo: todos[index].todo, isSuccess: todos[index].isSuccess, createAt: todos[index].createAt));
    todos.removeAt(index);
    notifyListeners();
  }

  void updateAward (int index, String newAward) {
    _awards[index].todo = newAward;
    //_awards.removeAt(index);
    notifyListeners();
  }

  void deleteAward(int index) {
    _awards.removeAt(index);
    notifyListeners();
  }




  // Future<void> fetchTodos() async {
  //   try {
  //     final response = await Dio().get(
  //         "https://api2.metabx.io/api/examples"
  //     );
  //
  //     if (response.statusCode == 200) {
  //       var dataJsonArray= response.data as List;
  //
  //       for (var item in dataJsonArray) {
  //
  //         Todos tempTodo=Todos.fromJson(item);
  //
  //         if(tempTodo.isSuccess ==0){
  //           addTodo(tempTodo);
  //         }
  //         else{
  //           completeTask(tempTodo.idx!-1); // assuming index starts from zero and matches with the id
  //         }
  //       }
  //     } else {
  //       throw Exception('Failed to load album');
  //     }
  //   } catch (e) {
  //     throw Exception('Error occurred while fetching data');
  //   }
  // }

}






