import 'dart:convert';

AddressResponse addressResponseFromJson(String str) =>
    AddressResponse.fromJson(json.decode(str));

String addressResponseToJson(AddressResponse data) =>
    json.encode(data.toJson());

class AddressResponse {
  AddressResponse({
    this.address,
    this.deliveryBounds, 
  });

  ResAddress address;
  ResDeliveryBounds deliveryBounds;

  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      AddressResponse(
        address: json["address"] != null
            ? ResAddress.fromJson(json["address"])
            : null,
        deliveryBounds: json["delivery_bounds"] != null
            ? ResDeliveryBounds.fromJson(json["delivery_bounds"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "address": address.toJson(),
        "delivery_bounds": deliveryBounds.toJson(),
      };

  @override
  String toString() {
    return 'address: ${address.toJson()} delivery_bounds: ${deliveryBounds.toJson()}';
  }
}

class ResAddress {
  ResAddress({
    this.country,
    this.number,
    this.city,
    this.location,
    this.vendorId,
    this.showMarker,
    this.postCode,
    this.createdAt,
    this.street,
    this.updatedAt,
  });

  ResCountry country;
  String number;
  String city;
  ResLocation location;
  String vendorId;
  String showMarker;
  String postCode;
  ResAtedAt createdAt;
  String street;
  ResAtedAt updatedAt;

  factory ResAddress.fromJson(Map<String, dynamic> json) => ResAddress(
        country: json["country"] != null
            ? ResCountry.fromJson(json["country"])
            : null,
        number: json["number"],
        city: json["city"],
        location: json["location"] != null
            ? ResLocation.fromJson(json["location"])
            : null,
        vendorId: json["vendor_id"],
        showMarker: json["showMarker"],
        postCode: json["post_code"],
        createdAt: json["created_at"] != null
            ? ResAtedAt.fromJson(json["created_at"])
            : null,
        street: json["street"],
        updatedAt: json["updated_at"] != null
            ? ResAtedAt.fromJson(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "country": country.toJson(),
        "number": number,
        "city": city,
        "location": location.toJson(),
        "vendor_id": vendorId,
        "showMarker": showMarker,
        "post_code": postCode,
        "created_at": createdAt.toJson(),
        "street": street,
        "updated_at": updatedAt.toJson(),
      };
}

class ResCountry {
  ResCountry({
    this.name,
    this.countryId,
    this.id,
  });

  String name;
  String countryId;
  String id;

  factory ResCountry.fromJson(Map<String, dynamic> json) => ResCountry(
        name: json["name"],
        countryId: json["id"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": countryId,
        "_id": id,
      };
}

class ResAtedAt {
  ResAtedAt({
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

  factory ResAtedAt.fromJson(Map<String, dynamic> json) => ResAtedAt(
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

class ResLocation {
  ResLocation({
    this.srid,
    this.x,
    this.y,
  });

  ResSrid srid;
  double x;
  double y;

  factory ResLocation.fromJson(Map<String, dynamic> json) => ResLocation(
        srid: json["srid"] != null ? ResSrid.fromJson(json["srid"]) : null,
        x: json["x"].toDouble(),
        y: json["y"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "srid": srid.toJson(),
        "x": x,
        "y": y,
      };
}

class ResSrid {
  ResSrid({
    this.low,
    this.high,
  });

  int low;
  int high;

  factory ResSrid.fromJson(Map<String, dynamic> json) => ResSrid(
        low: json["low"],
        high: json["high"],
      );

  Map<String, dynamic> toJson() => {
        "low": low,
        "high": high,
      };
}

class ResDeliveryBounds {
  ResDeliveryBounds({
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
  ResAtedAt createdAt;
  ResAtedAt updatedAt;
  double east;

  factory ResDeliveryBounds.fromJson(Map<String, dynamic> json) =>
      ResDeliveryBounds(
        vendorId: json["vendor_id"],
        west: json["west"].toDouble(),
        north: json["north"].toDouble(),
        south: json["south"].toDouble(),
        createdAt: json["created_at"] != null
            ? ResAtedAt.fromJson(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? ResAtedAt.fromJson(json["updated_at"])
            : null,
        east: json["east"].toDouble(),
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
