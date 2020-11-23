import 'dart:convert';

List<Country> countryFromJson(String str) => List<Country>.from(json.decode(str).map((x) => Country.fromJson(x)));

String countryToJson(List<Country> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Country {
    Country({
        this.countryId,
        this.name,
        this.id,
    });

    String countryId;
    String name;
    String id;

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        countryId: json["id"],
        name: json["name"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": countryId,
        "name": name,
        "_id": id,
    };
}
