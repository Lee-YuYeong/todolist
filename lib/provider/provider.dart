import 'package:flutter/material.dart';

class TodoProvider extends ChangeNotifier {
  List<String> _todos = ['앱 리뉴얼 진행하기', '앱 리뉴얼 진행하기', '앱 리뉴얼 진행하기']; //진행 목록
  List<String> _award = ['끝내주는 소비 생활하기', '끝내주는 소비 생활하기','끝내주는 소비 생활하기']; //명예의 전당

  List<String> get todos => _todos;
  List<String> get award => _award;

 void addTodo(String todo) {
   _todos.insert(0, todo);
   notifyListeners();
 }

 void doneTodo(int index, String todo) {
   _todos.removeAt(index);
   _award.add(todo);
   notifyListeners();
 }

 void deleteAward(int index) {
   _award.removeAt(index);
   notifyListeners();
 }

 void updateAward (int index, String newAward) {
   _award[index] = newAward;
   notifyListeners();
 }


}
