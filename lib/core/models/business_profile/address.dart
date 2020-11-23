import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
    Address({
        this.number,
        this.postCode,
        this.showMarker,
        this.street,
        this.city,
        this.country,
        this.deliveryBounds,
        this.location,
    });

    String number;
    String postCode;
    String showMarker;
    String street;
    String city;
    String country;
    DeliveryBounds deliveryBounds;
    ALocation location;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        number: json["number"],
        postCode: json["post_code"],
        showMarker: json["showMarker"],
        street: json["street"],
        city: json["city"],
        country: json["country"],
        deliveryBounds: DeliveryBounds.fromJson(json["delivery_bounds"]),
        location: ALocation.fromJson(json["location"]),
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "post_code": postCode,
        "showMarker": showMarker,
        "street": street,
        "city": city,
        "country": country,
        "delivery_bounds": deliveryBounds.toJson(),
        "location": location.toJson(),
    };
}

class DeliveryBounds {
    DeliveryBounds({
        this.east,
        this.north,
        this.south,
        this.west,
    });

    double east;
    double north;
    double south;
    double west;

    factory DeliveryBounds.fromJson(Map<String, dynamic> json) => DeliveryBounds(
        east: json["east"].toDouble(),
        north: json["north"].toDouble(),
        south: json["south"].toDouble(),
        west: json["west"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "east": east,
        "north": north,
        "south": south,
        "west": west,
    };
}

class ALocation {
    ALocation({
        this.x,
        this.y,
    });

    double x;
    double y;

    factory ALocation.fromJson(Map<String, dynamic> json) => ALocation(
        x: json["x"].toDouble(),
        y: json["y"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
    };
}