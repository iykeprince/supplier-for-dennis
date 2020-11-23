import 'dart:convert';

Contact contactFromJson(String str) => Contact.fromJson(json.decode(str));

String contactToJson(Contact data) => json.encode(data.toJson());

class Contact {
  Contact({
    this.website,
    this.phoneNumber,
    this.vendorId,
    this.email,
    this.facebook,
    this.createdAt,
    this.twitter,
    this.updatedAt,
    this.instagram,
    this.linkedIn,
  });

  String website;
  String phoneNumber;
  String vendorId;
  String email;
  String facebook;
  AtedAt createdAt;
  String twitter;
  AtedAt updatedAt;
  String instagram;
  String linkedIn;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        website: json["website"],
        phoneNumber: json["phone_number"],
        vendorId: json["vendor_id"],
        email: json["email"],
        facebook: json["facebook"],
        createdAt:
            json["created_at"] != null ? AtedAt.fromJson(json["created_at"]) : null,
        twitter: json["twitter"],
        updatedAt:
            json["updated_at"] != null ? AtedAt.fromJson(json["updated_at"]) : null,
        instagram: json["instagram"],
        linkedIn: json["linkedIn"],
      );

  Map<String, dynamic> toJson() => {
        "website": website,
        "phone_number": phoneNumber,
        "email": email,
        "facebook": facebook,
        "twitter": twitter,
        "instagram": instagram,
        "linkedIn": linkedIn,
      };

  @override
  String toString() {
    return "{website: $website, instagram: $instagram, linkedIn: $linkedIn, twitter: $twitter, email: $email, phone_number: $phoneNumber,}";
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
