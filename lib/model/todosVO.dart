
//Todo 클래스
class Todos {
  int? idx;
  String? todo;
  int? isSuccess;
  String? createAt;

  Todos({this.idx, this.todo, this.isSuccess, this.createAt});//생성자

  // Todos.fromJson(Map<String, dynamic> json) {
  //   idx = json['idx'];
  //   todo = json['todo'];
  //   isSuccess = json['isSuccess'];
  //   createAt = json['createAt'];
  // }
  //
  // //Map : 요소들의 순서도 기억하므로 순회, 수량 추적, 키를 문자열이 아닌 다른 타입으로 설정할 때 유리
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['idx'] = this.idx.toString();
  //   data['todo'] = this.todo;
  //   data['isSuccess'] = this.isSuccess.toString(); // 문자열로 변환
  //   data['createAt'] = this.createAt;
  //   return data;
  // }
}
