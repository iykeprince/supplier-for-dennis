import 'dart:convert';

PostEventType postEventTypeFromJson(String str) => PostEventType.fromJson(json.decode(str));

String postEventTypeToJson(PostEventType data) => json.encode(data.toJson());

class PostEventType {
    PostEventType({
        this.eventTypes,
    });

    List<String> eventTypes;

    factory PostEventType.fromJson(Map<String, dynamic> json) => PostEventType(
        eventTypes: List<String>.from(json["event_types"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "event_types": List<dynamic>.from(eventTypes.map((x) => x)),
    };
}
