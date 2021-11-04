import 'package:dio/dio.dart';

import 'category.dart';

class CategoriesApi {
  final _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8081/'));

  Future<List<Category>> getCategories() async {
    final response = await _dio.get('');
    return (response.data['categories'] as List)
        .map<Category>((json) => Category.fromJson(json))
        .toList();
  }

  Future<Category> createCategory(String category, String weight) async {
    final response = await _dio.post('',
        data: {'category': category, 'weight': weight, 'responses': {}});
    return Category.fromJson(response.data);
  }

  Future<Category> updateCategory(String category, String weight, Map<String, String> responses) async {
    final response = await _dio.put('',
        data: {'category': category, 'weight': weight, 'responses': {responses}});
    return Category.fromJson(response.data);
  }

  // Future deleteCategory(String id) async {
  //   final response = await _dio.delete('/$id');
  //   return response.data;
  // }
}
