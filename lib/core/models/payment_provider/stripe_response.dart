import 'dart:convert';

StripeResponse stripeResponseFromJson(String str) =>
    StripeResponse.fromJson(json.decode(str));

String stripeResponseToJson(StripeResponse data) => json.encode(data.toJson());

class StripeResponse {
  StripeResponse({
    this.livemode,
    this.vendorId,
    this.stripeUserId,
    this.createdAt,
    this.tokenType,
    this.linked,
    this.stripePublishableKey,
  });

  bool livemode;
  String vendorId;
  String stripeUserId;
  CreatedAt createdAt;
  String tokenType;
  bool linked;
  String stripePublishableKey;

  factory StripeResponse.fromJson(Map<String, dynamic> json) => StripeResponse(
        livemode: json["livemode"],
        vendorId: json["vendor_id"],
        stripeUserId: json["stripe_user_id"],
        createdAt: CreatedAt.fromJson(json["created_at"]),
        tokenType: json["token_type"],
        linked: json["linked"],
        stripePublishableKey: json["stripe_publishable_key"],
        
      );

  Map<String, dynamic> toJson() => {
        "livemode": livemode,
        "vendor_id": vendorId,
        "stripe_user_id": stripeUserId,
        "created_at": createdAt.toJson(),
        "token_type": tokenType,
        "linked": linked,
        "stripe_publishable_key": stripePublishableKey,
      };
}

class CreatedAt {
  CreatedAt({
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

  factory CreatedAt.fromJson(Map<String, dynamic> json) => CreatedAt(
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
