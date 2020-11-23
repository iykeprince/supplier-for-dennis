import 'dart:convert';
import '../ated_at.dart';

List<BasePortfolio> basePortfolioFromJson(String str) =>
    List<BasePortfolio>.from(
        json.decode(str).map((x) => BasePortfolio.fromJson(x)));
String basePortfolioToJson(List<BasePortfolio> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BasePortfolio {
  BasePortfolio({
    this.previewS,
    this.raw,
    this.previewM,
    this.createdAt,
    this.previewL,
    this.path1M,
    this.uuid,
    this.previewXl,
    this.tags,
    this.path,
    this.previewXxs,
    this.updatedAt,
    this.previewXs,
    this.vendorId,
    this.name,
    this.portfolioId,
    this.id,
    this.key,
    this.imagetags,
    this.dominantColor,
  });

  PreviewL previewS;
  PreviewL raw;
  PreviewL previewM;
  AtedAt createdAt;
  PreviewL previewL;
  String path1M;
  String uuid;
  PreviewL previewXl;
  List<String> tags;
  String path;
  PreviewL previewXxs;
  AtedAt updatedAt;
  PreviewL previewXs;
  String vendorId;
  String name;
  String portfolioId;
  String id;
  String key;
  List<String> imagetags;
  String dominantColor;

  factory BasePortfolio.fromJson(Map<String, dynamic> json) => BasePortfolio(
        previewS: json["preview_s"] != null
            ? PreviewL.fromJson(json["preview_s"])
            : null,
        raw: json["raw"] != null ? PreviewL.fromJson(json["raw"]) : null,
        previewM: json["preview_m"] != null
            ? PreviewL.fromJson(json["preview_m"])
            : null,
        createdAt: json["created_at"] != null
            ? AtedAt.fromJson(json["created_at"])
            : null,
        previewL: json["preview_l"] != null
            ? PreviewL.fromJson(json["preview_l"])
            : null,
        path1M: json["path1m"] ?? '',
        uuid: json["uuid"] == null ? null : json["uuid"],
        previewXl: json["preview_xl"] != null
            ? PreviewL.fromJson(json["preview_xl"])
            : null,
        tags: json["tags"] != null
            ? List<String>.from(json["tags"].map((x) => x))
            : null,
        path: json["path"] ?? '',
        previewXxs: json["preview_xxs"] != null
            ? PreviewL.fromJson(json["preview_xxs"])
            : null,
        updatedAt: json["updated_at"] != null
            ? AtedAt.fromJson(json["updated_at"])
            : null,
        previewXs: json["preview_xs"] != null
            ? PreviewL.fromJson(json["preview_xs"])
            : null,
        vendorId: json["vendor_id"] ?? '',
        name: json["name"] ?? '',
        portfolioId: json["id"] ?? '',
        id: json["_id"] ?? '',
        key: json["key"] == null ? null : json["key"],
        imagetags: json["imagetags"] == null
            ? null
            : List<String>.from(json["imagetags"].map((x) => x)),
        dominantColor:
            json["dominantColor"] == null ? null : json["dominantColor"],
      );

  Map<String, dynamic> toJson() => {
        "preview_s": previewS.toJson(),
        "raw": raw.toJson(),
        "preview_m": previewM.toJson(),
        "created_at": createdAt.toJson(),
        "preview_l": previewL.toJson(),
        "path1m": path1M,
        "uuid": uuid == null ? null : uuid,
        "preview_xl": previewXl.toJson(),
        "tags": List<String>.from(tags.map((x) => x)),
        "path": path,
        "preview_xxs": previewXxs.toJson(),
        "updated_at": updatedAt.toJson(),
        "preview_xs": previewXs.toJson(),
        "vendor_id": vendorId,
        "name": name,
        "id": portfolioId,
        "_id": id,
        "key": key == null ? null : key,
        "imagetags": imagetags == null
            ? null
            : List<String>.from(imagetags.map((x) => x)),
        "dominantColor": dominantColor == null ? null : dominantColor,
      };
}

class PreviewL {
  PreviewL({
    this.width,
    this.height,
    this.path,
  });

  int width;
  int height;
  String path;

  factory PreviewL.fromJson(Map<String, dynamic> json) => PreviewL(
        width: json["width"] as int,
        height: json["height"] as int,
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "path": path,
      };
}
