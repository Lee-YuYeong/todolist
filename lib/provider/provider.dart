// todo_provider.dart
import 'package:flutter/foundation.dart';
import '../model/todosVO.dart';



class TodoProvider with ChangeNotifier {

  final List<Todos> _todos = []; //진행 목록
  final List<Todos> _awards = []; // 명예의 전당

  //getter
  List<Todos> get todos => _todos;
  List<Todos> get awards => _awards;

  //할 일 추가
  void addTodo(Todos todo) {
    _todos.add(todo);
    notifyListeners();
  }

  //명예의 전당 추가
  void awardTodo(Todos todo) {
    _awards.add(todo);
    notifyListeners();
  }

  //완료 여부
  void completeTask(int index) {
    _awards.add(todos[index]);
    _todos.removeAt(index);
    notifyListeners();
  }

  //수정
  void updateAward (int index, String newAward) {
    _awards[index].todo = newAward;
    notifyListeners();
  }

  //삭제
  void deleteAward(int index) {
    _awards.removeAt(index);
    notifyListeners();
  }

}






