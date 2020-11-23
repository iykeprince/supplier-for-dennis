import 'dart:convert';

List<BaseWorkTime> baseWorkTimeFromJson(String str) => List<BaseWorkTime>.from(
    json.decode(str).map((x) => BaseWorkTime.fromJson(x)));

String baseWorkTimeToJson(List<BaseWorkTime> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BaseWorkTime {
  BaseWorkTime({
    this.times,
    this.baseWorkTimeId,
    this.name,
    this.id,
    this.valid = false,
  });

  BaseTimes times;
  String baseWorkTimeId;
  String name;
  String id;
  bool valid;

  factory BaseWorkTime.fromJson(Map<String, dynamic> json) => BaseWorkTime(
        times: json["times"] != null ? BaseTimes.fromJson(json["times"]) : null,
        baseWorkTimeId: json["id"],
        name: json["name"],
        id: json["_id"],
        valid: true,
      );

  Map<String, dynamic> toJson() => {
        "times": times.toJson(),
        "id": baseWorkTimeId,
        "name": name,
        "_id": id,
      };

  @override
  String toString() {
    return "base work time: id: $id, isValid: $valid";
  }
}

class BaseTimes {
  BaseTimes({
    this.open,
    this.close,
  });

  BaseClose open;
  BaseClose close;

  factory BaseTimes.fromJson(Map<String, dynamic> json) => BaseTimes(
        open: BaseClose.fromJson(json["open"]),
        close: BaseClose.fromJson(json["close"]),
      );

  Map<String, dynamic> toJson() => {
        "open": open.toJson(),
        "close": close.toJson(),
      };
}

class BaseClose {
  BaseClose({
    this.hour,
    this.minute,
    this.nanosecond,
    this.second,
    this.timeZoneOffsetSeconds,
  });

  int hour;
  int minute;
  int nanosecond;
  int second;
  int timeZoneOffsetSeconds;

  factory BaseClose.fromJson(Map<String, dynamic> json) => BaseClose(
        hour: json["hour"],
        minute: json["minute"],
        nanosecond: json["nanosecond"],
        second: json["second"],
        timeZoneOffsetSeconds: json["timeZoneOffsetSeconds"],
      );

  Map<String, dynamic> toJson() => {
        "hour": hour,
        "minute": minute,
        "nanosecond": nanosecond,
        "second": second,
        "timeZoneOffsetSeconds": timeZoneOffsetSeconds,
      };
}
