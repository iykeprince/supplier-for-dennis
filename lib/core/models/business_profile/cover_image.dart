import 'dart:convert';

import '../ated_at.dart';

CoverImage coverImageFromJson(String str) => CoverImage.fromJson(json.decode(str));

String coverImageToJson(CoverImage data) => json.encode(data.toJson());

class CoverImage {
  CoverImage({
    this.path,
    this.updatedAt,
    this.vendorId,
    this.name,
    this.createdAt,
    this.path1M,
    this.coverId,
    this.id,
    this.key,
    this.tags,
  });

  String path;
  AtedAt updatedAt;
  String vendorId;
  String name;
  AtedAt createdAt;
  String path1M;
  String coverId;
  String id;
  String key;
  List<String> tags;

  factory CoverImage.fromJson(Map<String, dynamic> json) => CoverImage(
        path: json["path"] != null ? json['path'] : 'no logo',
        updatedAt: json["updated_at"] != null
            ? AtedAt.fromJson(json["updated_at"])
            : null,
        vendorId: json["vendor_id"] ?? '',
        name: json["name"] ?? 'no logo name',
        createdAt: json["created_at"] != null
            ? AtedAt.fromJson(json["created_at"])
            : null,
        path1M: json["path1m"] != null ? json["path1m"] : 'no path1M',
        coverId: json["id"] != null ? json["id"] : null,
        id: json["_id"] != null ? json["_id"] : null,
        key: json["key"] != null ? json["key"] : null,
        tags: json["tags"] != null
            ? List<String>.from(json["tags"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "updated_at": updatedAt.toJson(),
        "vendor_id": vendorId,
        "name": name,
        "created_at": createdAt.toJson(),
        "path1m": path1M,
        "id": coverId,
        "_id": id,
        "key": key,
        "tags": List<dynamic>.from(tags.map((x) => x)),
      };

  @override
  String toString() {
    return 'name: $name, path: $path, path1m: $path1M, id: $id';
  }
}