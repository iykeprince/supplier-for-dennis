import 'dart:convert';

Portfolio portfolioFromJson(String str) => Portfolio.fromJson(json.decode(str));

String portfolioToJson(Portfolio data) => json.encode(data.toJson());

class Portfolio {
  Portfolio({
    this.previewXxs,
    this.previewXs,
    this.previewS,
    this.previewM,
    this.previewL,
    this.previewXl,
    this.raw,
    this.name,
    this.uuid,
  });

  List<int> previewXxs;
  List<int> previewXs;
  List<int> previewS;
  List<int> previewM;
  List<int> previewL;
  List<int> previewXl;
  List<int> raw;
  String name;
  String uuid;

  factory Portfolio.fromJson(Map<String, dynamic> json) => Portfolio(
        previewXxs: List<int>.from(json["preview_xxs"].map((x) => x)),
        previewXs: List<int>.from(json["preview_xs"].map((x) => x)),
        previewS: List<int>.from(json["preview_s"].map((x) => x)),
        previewM: List<int>.from(json["preview_m"].map((x) => x)),
        previewL: List<int>.from(json["preview_l"].map((x) => x)),
        previewXl: List<int>.from(json["preview_xl"].map((x) => x)),
        raw: List<int>.from(json["raw"].map((x) => x)),
        name: json["name"],
        uuid: json["uuid"],
      );

  Map<String, dynamic> toJson() => {
        "preview_xxs": List<int>.from(previewXxs.map((x) => x)),
        "preview_xs": List<int>.from(previewXs.map((x) => x)),
        "preview_s": List<int>.from(previewS.map((x) => x)),
        "preview_m": List<int>.from(previewM.map((x) => x)),
        "preview_l": List<int>.from(previewL.map((x) => x)),
        "preview_xl": List<int>.from(previewXl.map((x) => x)),
        "raw": List<int>.from(raw.map((x) => x)),
        "name": name,
        "uuid": uuid,
      };
  @override
  String toString() {
    return 'previewXl $previewXl name: $name uuid: $uuid';
  }
}
