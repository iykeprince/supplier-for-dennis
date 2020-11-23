import 'dart:convert';

List<EventType> eventTypeFromJson(String str) =>
    List<EventType>.from(json.decode(str).map((x) => EventType.fromJson(x)));

String eventTypeToJson(List<EventType> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EventType {
  EventType({
    this.image,
    this.name,
    this.id, 
    this.eventTypeId,
    this.createdAt,
    this.updatedAt,
    this.selected = false,
  });

  Image image;
  String name;
  String id;
  String eventTypeId;
  AtedAt createdAt;
  AtedAt updatedAt;
  
  bool selected;

  factory EventType.fromJson(Map<String, dynamic> json) => EventType(
        image: json["image"] != null ? Image.fromJson(json["image"]) : null,
        name: json["name"],
        id: json["_id"],
        eventTypeId: json["id"],
        createdAt: AtedAt.fromJson(json["created_at"]),
        updatedAt: AtedAt.fromJson(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "image": image.toJson(),
        "name": name,
        "_id": id,
        "id": eventTypeId,
        "created_at": createdAt.toJson(),
        "updated_at": updatedAt.toJson(),
      };
}

class AtedAt {
  AtedAt({
    this.year,
    this.month,
    this.day,
    this.hour,
    this.minute,
    this.nanosecond,
    this.second,
    this.timeZoneId,
    this.timeZoneOffsetSeconds,
  });

  int year;
  int month;
  int day;
  int hour;
  int minute;
  int nanosecond;
  int second;
  dynamic timeZoneId;
  int timeZoneOffsetSeconds;

  factory AtedAt.fromJson(Map<String, dynamic> json) => AtedAt(
        year: json["year"],
        month: json["month"],
        day: json["day"],
        hour: json["hour"],
        minute: json["minute"],
        nanosecond: json["nanosecond"],
        second: json["second"],
        timeZoneId: json["timeZoneId"],
        timeZoneOffsetSeconds: json["timeZoneOffsetSeconds"],
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "month": month,
        "day": day,
        "hour": hour,
        "minute": minute,
        "nanosecond": nanosecond,
        "second": second,
        "timeZoneId": timeZoneId,
        "timeZoneOffsetSeconds": timeZoneOffsetSeconds,
      };
}

class Image {
  Image({
    this.path,
    this.name,
    this.path1M,
    this.imageId,
    this.id,
    this.key,
    this.tags,
  });

  String path;
  String name;
  String path1M;
  String imageId;
  String id;
  String key;
  List<Tag> tags;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        path: json["path"],
        name: json["name"],
        path1M: json["path1m"],
        imageId: json["id"],
        id: json["_id"],
        key: json["key"],
        tags: List<Tag>.from(json["tags"].map((x) => tagValues.map[x])),
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "name": name,
        "path1m": path1M,
        "id": imageId,
        "_id": id,
        "key": key,
        "tags": List<dynamic>.from(tags.map((x) => tagValues.reverse[x])),
      };
}

enum Tag { EVENT_TYPES, ADMIN }

final tagValues =
    EnumValues({"admin": Tag.ADMIN, "event types": Tag.EVENT_TYPES});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
