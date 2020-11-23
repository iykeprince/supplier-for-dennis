import 'dart:convert';

import 'base_work_time.dart';
import 'contact.dart';
import 'cover_image.dart';

BaseProfile baseProfileFromJson(String str) =>
    BaseProfile.fromJson(json.decode(str));
String baseProfileToJson(BaseProfile data) => json.encode(data.toJson());

//BaseUserProfile
BaseUserProfile baseUserProfileFromJson(String str) =>
    BaseUserProfile.fromJson(json.decode(str));
String baseUserProfileToJson(BaseUserProfile data) =>
    json.encode(data.toJson());

//Address & Delivery Bounds

class BaseProfile {
  BaseProfile({
    this.profile,
    this.workTime,
    this.cover,
    this.logo,
    this.categories,
    this.eventTypes,
    this.contact,
    this.address,
    this.deliveryBounds,
  });

  BaseUserProfile profile;
  List<BaseWorkTime> workTime;
  CoverImage cover;
  CoverImage logo;
  List<BaseCategory> categories;
  List<BaseEventType> eventTypes;
  Contact contact;
  BaseAddress address;
  BaseDeliveryBounds deliveryBounds;

  factory BaseProfile.fromJson(Map<String, dynamic> json) => BaseProfile(
        profile: json["profile"] != null
            ? BaseUserProfile.fromJson(json["profile"])
            : null,
        workTime: json["work_time"] != null
            ? List<BaseWorkTime>.from(
                json["work_time"].map((x) => BaseWorkTime.fromJson(x)))
            : [],
        cover:
            json["cover"] != null ? CoverImage.fromJson(json["cover"]) : null,
        logo: json["logo"] != null ? CoverImage.fromJson(json["logo"]) : null,
        categories: json["categories"] != null
            ? List<BaseCategory>.from(
                json["categories"].map((x) => BaseCategory.fromJson(x)))
            : [],
        eventTypes: json["event_types"] != null
            ? List<BaseEventType>.from(
                json["event_types"].map((x) => BaseEventType.fromJson(x)))
            : [],
        contact:
            json["contact"] != null ? Contact.fromJson(json["contact"]) : null,
        address: json["address"] != null
            ? BaseAddress.fromJson(json["address"])
            : null,
        deliveryBounds: json["delivery_bounds"] != null
            ? BaseDeliveryBounds.fromJson(json["delivery_bounds"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "profile": profile.toJson(),
        "work_time": List<dynamic>.from(workTime.map((x) => x.toJson())),
        "cover": cover.toJson(),
        "logo": logo.toJson(),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "event_types": List<dynamic>.from(eventTypes.map((x) => x.toJson())),
        "contact": contact.toJson(),
        "address": address.toJson(),
        "delivery_bounds": deliveryBounds.toJson(),
      };
}

class BaseAddress {
  BaseAddress({
    this.country,
    this.showMarker,
    this.number,
    this.city,
    this.location,
    this.vendorId,
    this.postCode,
    this.createdAt,
    this.street,
    this.updatedAt,
  });

  BaseCountry country;
  String showMarker;
  String number;
  String city;
  BaseLocation location;
  String vendorId;
  String postCode;
  AddressCreatedAt createdAt;
  String street;
  AddressCreatedAt updatedAt;

  factory BaseAddress.fromJson(Map<String, dynamic> json) => BaseAddress(
        country: json["country"] != null
            ? BaseCountry.fromJson(json["country"])
            : null,
        showMarker: json["showMarker"],
        number: json["number"] ?? '',
        city: json["city"] ?? '',
        location: json["location"] != null
            ? BaseLocation.fromJson(json["location"])
            : null,
        vendorId: json["vendor_id"] ?? '',
        postCode: json["post_code"] ?? '',
        createdAt: json["created_at"] != null
            ? AddressCreatedAt.fromJson(json["created_at"])
            : null,
        street: json["street"] ?? '',
        updatedAt: json["updated_at"] != null
            ? AddressCreatedAt.fromJson(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "country": country.toJson(),
        "showMarker": showMarker,
        "number": number,
        "city": city,
        "location": location.toJson(),
        "vendor_id": vendorId,
        "post_code": postCode,
        "created_at": createdAt.toJson(),
        "street": street,
        "updated_at": updatedAt.toJson(),
      };
}

class BaseCountry {
  BaseCountry({
    this.name,
    this.countryId,
    this.id,
    this.times,
  });

  String name;
  String countryId;
  String id;
  Times times;

  factory BaseCountry.fromJson(Map<String, dynamic> json) => BaseCountry(
        name: json["name"],
        countryId: json["id"],
        id: json["_id"],
        times: json["times"] != null ? Times.fromJson(json["times"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": countryId,
        "_id": id,
        "times": times == null ? null : times.toJson(),
      };
}

class Times {
  Times({
    this.open,
    this.close,
  });

  Close open;
  Close close;

  factory Times.fromJson(Map<String, dynamic> json) => Times(
        open: Close.fromJson(json["open"]) ?? null,
        close: Close.fromJson(json["close"]) ?? null,
      );

  Map<String, dynamic> toJson() => {
        "open": open.toJson(),
        "close": close.toJson(),
      };
}

class Close {
  Close({
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

  factory Close.fromJson(Map<String, dynamic> json) => Close(
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

class AddressCreatedAt {
  AddressCreatedAt({
    this.year,
    this.month,
    this.day,
    this.hour,
    this.minute,
    this.second,
    this.nanosecond,
    this.timeZoneOffsetSeconds,
    this.timeZoneId,
  });

  Day year;
  Day month;
  Day day;
  Day hour;
  Day minute;
  Day second;
  Day nanosecond;
  Day timeZoneOffsetSeconds;
  dynamic timeZoneId;

  factory AddressCreatedAt.fromJson(Map<String, dynamic> json) =>
      AddressCreatedAt(
        year: json["year"] != null ? Day.fromJson(json["year"]) : null,
        month: json["month"] != null ? Day.fromJson(json["month"]) : null,
        day: json["day"] != null ? Day.fromJson(json["day"]) : null,
        hour: json["hour"] != null ? Day.fromJson(json["hour"]) : null,
        minute: json["minute"] != null ? Day.fromJson(json["minute"]) : null,
        second: json["second"] != null ? Day.fromJson(json["second"]) : null,
        nanosecond: json["nanosecond"] != null ? Day.fromJson(json["nanosecond"]) : null,
        timeZoneOffsetSeconds: json["timeZoneOffsetSeconds"] != null ? Day.fromJson(json["timeZoneOffsetSeconds"]) : null,
        timeZoneId: json["timeZoneId"],
      );

  Map<String, dynamic> toJson() => {
        "year": year.toJson(),
        "month": month.toJson(),
        "day": day.toJson(),
        "hour": hour.toJson(),
        "minute": minute.toJson(),
        "second": second.toJson(),
        "nanosecond": nanosecond.toJson(),
        "timeZoneOffsetSeconds": timeZoneOffsetSeconds.toJson(),
        "timeZoneId": timeZoneId,
      };
}

class Day {
  Day({
    this.low, 
    this.high,
  });

  int low;
  int high;

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        low: json["low"],
        high: json["high"],
      );

  Map<String, dynamic> toJson() => {
        "low": low,
        "high": high,
      };
}

class BaseLocation {
  BaseLocation({
    this.srid,
    this.x,
    this.y,
  });

  Day srid;
  double x;
  double y;

  factory BaseLocation.fromJson(Map<String, dynamic> json) => BaseLocation(
        srid: json["srid"] != null ? Day.fromJson(json["srid"]) : null,
        x: json["x"].toDouble() ?? 0.0,
        y: json["y"].toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "srid": srid.toJson(),
        "x": x,
        "y": y,
      };
}

class BaseCategory {
  BaseCategory({
    this.image,
    this.plural,
    this.updatedAt,
    this.name,
    this.createdAt,
    this.description,
    this.active,
    this.categoryId,
    this.id,
    this.picture,
  });

  String image;
  String plural;
  CategoryCreatedAt updatedAt;
  String name;
  CategoryCreatedAt createdAt;
  String description;
  bool active;
  String categoryId;
  String id;
  String picture;

  factory BaseCategory.fromJson(Map<String, dynamic> json) => BaseCategory(
        image: json["image"] ?? null,
        plural: json["plural"] ?? null,
        updatedAt: CategoryCreatedAt.fromJson(json["updated_at"]) ?? null,
        name: json["name"] ?? null,
        createdAt: CategoryCreatedAt.fromJson(json["created_at"]) ?? null,
        description: json["description"] ?? null,
        active: json["active"] ?? null,
        categoryId: json["id"] ?? null,
        id: json["_id"] ?? null,
        picture: json["picture"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "plural": plural,
        "updated_at": updatedAt.toJson(),
        "name": name,
        "created_at": createdAt.toJson(),
        "description": description,
        "active": active,
        "id": categoryId,
        "_id": id,
        "picture": picture,
      };
  @override
  String toString() {
    return '$name';
  }
}

class CategoryCreatedAt {
  CategoryCreatedAt({
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

  factory CategoryCreatedAt.fromJson(Map<String, dynamic> json) =>
      CategoryCreatedAt(
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

class BaseDeliveryBounds {
  BaseDeliveryBounds({
    this.vendorId,
    this.west,
    this.north,
    this.south,
    this.createdAt,
    this.updatedAt,
    this.east,
  });

  String vendorId;
  double west;
  double north;
  double south;
  AddressCreatedAt createdAt;
  AddressCreatedAt updatedAt;
  double east;

  factory BaseDeliveryBounds.fromJson(Map<String, dynamic> json) =>
      BaseDeliveryBounds(
        vendorId: json["vendor_id"],
        west: json["west"] != null ? json["west"].toDouble() : 0,
        north: json["north"] != null ? json["north"].toDouble() : 0,
        south: json["south"] != null ? json["south"].toDouble() : 0,
        createdAt: json["created_at"] != null
            ? AddressCreatedAt.fromJson(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? AddressCreatedAt.fromJson(json["updated_at"])
            : null,
        east: json["east"] != null ? json["east"].toDouble() : null,
      );

  Map<String, dynamic> toJson() => {
        "vendor_id": vendorId,
        "west": west,
        "north": north,
        "south": south,
        "created_at": createdAt.toJson(),
        "updated_at": updatedAt.toJson(),
        "east": east,
      };
}

class BaseEventType {
  BaseEventType({
    this.updatedAt,
    this.name,
    this.createdAt,
    this.eventTypeId,
    this.id,
  });

  CategoryCreatedAt updatedAt;
  String name;
  CategoryCreatedAt createdAt;
  String eventTypeId;
  String id;

  factory BaseEventType.fromJson(Map<String, dynamic> json) => BaseEventType(
        updatedAt: json['update_at'] == null
            ? CategoryCreatedAt.fromJson(json["updated_at"])
            : null,
        name: json["name"],
        createdAt: json['created_at'] == null
            ? CategoryCreatedAt.fromJson(json["created_at"])
            : null,
        eventTypeId: json["id"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "updated_at": updatedAt.toJson(),
        "name": name,
        "created_at": createdAt.toJson(),
        "id": eventTypeId,
        "_id": id,
      };
  @override
  String toString() {
    return "name $name";
  }
}

class BaseUserProfile {
  BaseUserProfile({
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
  CategoryCreatedAt createdAt;
  CategoryCreatedAt updatedAt;
  bool verified;

  factory BaseUserProfile.fromJson(Map<String, dynamic> json) =>
      BaseUserProfile(
        name: json["name"],
        permalink: json["permalink"],
        vendorId: json["vendor_id"],
        description: json["description"],
        category: json["category"] ?? null,
        createdAt: json['created_at'] != null
            ? CategoryCreatedAt.fromJson(json["created_at"])
            : null,
        updatedAt: json['created_at'] != null
            ? CategoryCreatedAt.fromJson(json["updated_at"])
            : null,
        verified: json["verified"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
      };

  @override
  String toString() {
    return "name $name description $description";
  }
}
