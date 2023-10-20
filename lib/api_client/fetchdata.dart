import 'package:dio/dio.dart';
import 'package:contact/model/todosVO.dart';
import 'package:contact/provider/provider.dart';

var dio = Dio();

Future<List<Todos>> fetchData({required int isSuccess, required TodoProvider todoProvider}) async {
  try {
    final response = await dio.get(
      "https://api2.metabx.io/api/examples",
    );

    if (response.statusCode == 200) {
      var data = response.data;

      List<Todos> items = [];

      for (var item in data['data']) {
        if (item['isSuccess'] == isSuccess) {
          items.add(Todos(
              idx: item['idx'], todo: item['todo'], isSuccess: item['isSuccess'], createAt: item['createdAt'])
          );
        }
      }

      if (isSuccess == 0) {
        todoProvider.setTodos(items);
      } else if (isSuccess == 1) {
        todoProvider.setAwards(items);
      }

      return items;
    } else {
      throw Exception('통신 에러');
    }
  } catch (e) {
    throw Exception('fetch data 에러 발생');
  }
}