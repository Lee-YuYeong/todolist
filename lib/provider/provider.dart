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

  List<Todos> todos = [];
  List<Todos> award = [];

  void addTodo(Todos todo) {
    todos.add(todo);
    notifyListeners();
  }

  void awardTodo(Todos todo) {
    award.add(todo);
    notifyListeners();
  }

  void completeTask(int index) {
    award.add(todos[index]);
    todos.removeAt(index);
    notifyListeners();
  }

  Future<void> fetchTodos() async {
    try {
      final response = await Dio().get(
          "https://api2.metabx.io/api/examples"
      );

      if (response.statusCode == 200) {
        var dataJsonArray= response.data as List;

        for (var item in dataJsonArray) {

          Todos tempTodo=Todos.fromJson(item);

          if(tempTodo.isSuccess ==0){
            addTodo(tempTodo);
          }
          else{
            completeTask(tempTodo.idx!-1); // assuming index starts from zero and matches with the id
          }
        }
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      throw Exception('Error occurred while fetching data');
    }
  }

}


// void deleteAward(int index) {
 //   _award.removeAt(index);
 //   notifyListeners();
 // }
 //
 // void updateAward (int index, String newAward) {
 //   _award[index] = newAward;
 //   notifyListeners();
 // }



