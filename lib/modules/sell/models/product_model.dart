// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  final String id;
  final String barcode;
  final String title;
  final String img;
  ProductModel({
    required this.id,
    required this.barcode,
    required this.title,
    required this.img,
  });

  ProductModel copyWith({
    String? id,
    String? barcode,
    String? title,
    String? img,
  }) {
    return ProductModel(
      id: id ?? this.id,
      barcode: barcode ?? this.barcode,
      title: title ?? this.title,
      img: img ?? this.img,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'barcode': barcode,
      'title': title,
      'img': img,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      barcode: map['barcode'] as String,
      title: map['title'] as String,
      img: map['img'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, barcode: $barcode, title: $title, img: $img)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.barcode == barcode &&
        other.title == title &&
        other.img == img;
  }

  @override
  int get hashCode {
    return id.hashCode ^ barcode.hashCode ^ title.hashCode ^ img.hashCode;
  }
}
