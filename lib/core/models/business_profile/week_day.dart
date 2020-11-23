import 'dart:convert';

List<WeekDay> weekDayFromJson(String str) => List<WeekDay>.from(json.decode(str).map((x) => WeekDay.fromJson(x)));

String weekDayToJson(List<WeekDay> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WeekDay {
    WeekDay({
        this.weekDayId,
        this.name,
        this.id,
    });

    String weekDayId;
    String name;
    String id;

    factory WeekDay.fromJson(Map<String, dynamic> json) => WeekDay(
        weekDayId: json["id"],
        name: json["name"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": weekDayId,
        "name": name,
        "_id": id,
    };
}
