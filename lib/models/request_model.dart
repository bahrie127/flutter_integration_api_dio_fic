import 'dart:convert';

class RequestMedical {
  final String name;
  final int stock;
  final int price;
  final String description;

  RequestMedical(this.name, this.stock, this.price, this.description);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'stock': stock,
      'price': price,
      'description': description,
    };
  }

  factory RequestMedical.fromMap(Map<String, dynamic> map) {
    return RequestMedical(
      map['name'] ?? '',
      map['stock']?.toInt() ?? 0,
      map['price']?.toInt() ?? 0,
      map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestMedical.fromJson(String source) =>
      RequestMedical.fromMap(json.decode(source));
}
