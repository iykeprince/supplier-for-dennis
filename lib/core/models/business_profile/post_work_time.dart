import 'dart:convert';

PostWorkTime workTimeFromJson(String str) =>
    PostWorkTime.fromJson(json.decode(str));

String workTimeToJson(PostWorkTime data) => json.encode(data.toJson());

class PostWorkTime {
  PostWorkTime({
    this.workTime,
  });

  List<WorkTimeElement> workTime;

  factory PostWorkTime.fromJson(Map<String, dynamic> json) => PostWorkTime(
        workTime: json["work_time"] != null
            ? List<WorkTimeElement>.from(
                json["work_time"].map((x) => WorkTimeElement.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "work_time": List<dynamic>.from(workTime.map((x) => x.toJson())),
      };
}

class WorkTimeElement {
  WorkTimeElement({
    this.close,
    this.id,
    this.open,
  });

  String close;
  String id;
  String open;

  factory WorkTimeElement.fromJson(Map<String, dynamic> json) =>
      WorkTimeElement(
        close: json["close"],
        id: json["id"],
        open: json["open"],
      );

  Map<String, dynamic> toJson() => {
        "close": close,
        "id": id,
        "open": open,
      };
  @override
  String toString() {
    return 'id: $id open: $open close: $close';
  }
}
