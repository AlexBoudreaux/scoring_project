class Response {
  final String response;
  final String weight;

  const Response._(this.response ,this.weight);

  factory Response.fromJson(Map json) {
    final categoryName = json['categoryName'];
    final weight = json['weight'];
    return Response._(categoryName, weight);
  }
}