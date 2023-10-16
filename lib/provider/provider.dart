import 'package:flutter/material.dart';

class TodoProvider extends ChangeNotifier {
  List<String> todos = ['앱 리뉴얼 진행하기', '앱 리뉴얼 진행하기', '앱 리뉴얼 진행하기']; //진행 목록
  List<String> award = ['끝내주는 소비 생활하기', '끝내주는 소비 생활하기','끝내주는 소비 생활하기']; //명예의 전당

 void addTodo(String todo) {
   todos.insert(0, todo);
   notifyListeners();
 }

 void doneTodo(int index, String todo) {
   todos.removeAt(index);
   award.add(todo);
   notifyListeners();
 }

 void deleteAward(int index) {
   award.removeAt(index);
   notifyListeners();
 }

 void updateAward (int index, String newAward) {
   award[index] = newAward;
   notifyListeners();
 }


}
