import 'dart:convert';

import 'ated_at.dart';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    this.image,
    this.name,
    this.plural,
    this.description,
    this.id,
    this.categoryId,
    this.picture,
    this.createdAt,
    this.updatedAt,
    this.active,
    this.selected = false,
  });

  Image image;
  String name;
  String plural;
  String description;
  String id;
  String categoryId;
  String picture;
  AtedAt createdAt;
  AtedAt updatedAt;
  bool active;
  //custom added
  bool selected;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        image: json["image"] != null ? Image.fromJson(json["image"]) : null,
        name: json["name"],
        plural: json["plural"],
        description: json["description"],
        id: json["_id"],
        categoryId: json["id"],
        picture: json["picture"],
        createdAt: AtedAt.fromJson(json["created_at"]),
        updatedAt: AtedAt.fromJson(json["updated_at"]),
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "image": image.toJson(),
        "name": name,
        "plural": plural,
        "description": description,
        "_id": id,
        "id": categoryId,
        "picture": picture,
        "created_at": createdAt.toJson(),
        "updated_at": updatedAt.toJson(),
        "active": active,
      };

  @override
  String toString(){ return "name: $name"; }
}

class Image {
  Image({
    this.path,
    this.updatedAt,
    this.name,
    this.createdAt,
    this.path1M,
    this.imageId,
    this.id,
    this.key,
  });

  String path;
  AtedAt updatedAt;
  String name;
  AtedAt createdAt;
  String path1M;
  String imageId;
  String id;
  String key;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        path: json["path"],
        updatedAt: AtedAt.fromJson(json["updated_at"]),
        name: json["name"],
        createdAt: AtedAt.fromJson(json["created_at"]),
        path1M: json["path1m"],
        imageId: json["id"],
        id: json["_id"],
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "updated_at": updatedAt.toJson(),
        "name": name,
        "created_at": createdAt.toJson(),
        "path1m": path1M,
        "id": imageId,
        "_id": id,
        "key": key,
      };
}
