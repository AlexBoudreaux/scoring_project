
class Category {
  final String id;
  final String categoryName;
  final String weight;
  Map<dynamic, dynamic> responses = {};

  Category._(this.id, this.categoryName, this.weight, this.responses);

  factory Category.fromJson(Map json) {

    final id = json['_id'].replaceAll('ObjectId(\"', '').replaceAll('\")', '');
    final categoryName = json['category'];
    final weight = json['weight'];
    final responses =
        json['responses'].map((key, value) => MapEntry(key, value));

    return Category._(id, categoryName, weight, responses);
  }
}
