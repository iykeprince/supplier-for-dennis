import 'dart:convert';

import '../category.dart';

Onboard onboardFromJson(String str) => Onboard.fromJson(json.decode(str));
String onboardToJson(Onboard data) => json.encode(data.toJson());

//profile
Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));
String profileToJson(Profile data) => json.encode(data.toJson());

//

class Onboard {
  Onboard({
    this.profile,
    this.categories,
    this.eventTypes,
    this.loading,
    this.auth,
    this.errorMessage = '',
  });

  Profile profile;
  List<Category> categories;
  List<OnboardEventType> eventTypes;
  bool loading;
  bool auth;
  String errorMessage;

  factory Onboard.initialData() {
    return Onboard(
      loading: true,
      auth: false,
      profile: null,
      categories: null,
      eventTypes: null,
    );
  }

  @override
  String toString() {
    return "Onboard: loading $loading auth $auth, profile $profile";
  }

  factory Onboard.errorData({String errorMessage}) {
    return Onboard(
      loading: false,
      auth: false,
      errorMessage: errorMessage,
    );
  }

  factory Onboard.fromJson(Map<String, dynamic> json) => Onboard(
        loading: false,
        auth: true,
        profile:
            json["profile"] != null ? Profile.fromJson(json["profile"]) : null,
        categories: json["categories"] != null
            ? List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x)))
            : null,
        eventTypes: json["event_types"] != null
            ? List<OnboardEventType>.from(
                json["event_types"].map((x) => OnboardEventType.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "profile": profile.toJson(),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "event_types": List<dynamic>.from(eventTypes.map((x) => x.toJson())),
      };
}

class Profile {
  Profile({
    this.name,
    this.permalink,
    this.vendorId,
    this.description,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.verified,
  });

  String name;
  String permalink;
  String vendorId;
  String description;
  String category;
  AtedAt createdAt;
  AtedAt updatedAt;
  bool verified;

  @override
  String toString() { return "name $name"; }

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        name: json["name"],
        permalink: json["permalink"],
        vendorId: json["vendor_id"],
        description: json["description"],
        category: json["category"],
        createdAt: AtedAt.fromJson(json["created_at"]),
        updatedAt: AtedAt.fromJson(json["updated_at"]),
        verified: json["verified"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
      };
}

List<OnboardEventType> onboardEventTypeFromJson(String str) => List<OnboardEventType>.from(json.decode(str).map((x) => OnboardEventType.fromJson(x)));

String onboardEventTypeToJson(List<OnboardEventType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OnboardEventType {
    OnboardEventType({
        this.updatedAt,
        this.name,
        this.createdAt,
        this.onboardEventTypeId,
        this.id,
    });

    AtedAt updatedAt;
    String name;
    AtedAt createdAt;
    String onboardEventTypeId;
    String id;

    factory OnboardEventType.fromJson(Map<String, dynamic> json) => OnboardEventType(
        updatedAt: AtedAt.fromJson(json["updated_at"]),
        name: json["name"],
        createdAt: AtedAt.fromJson(json["created_at"]),
        onboardEventTypeId: json["id"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "updated_at": updatedAt.toJson(),
        "name": name,
        "created_at": createdAt.toJson(),
        "id": onboardEventTypeId,
        "_id": id,
    };

    @override
    String toString() {
      return "{name: $name, id: $onboardEventTypeId,_id: $id}";
    }
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
