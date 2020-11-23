import 'dart:convert';

DefaultResponse defaultResponseFromJson(String str) => DefaultResponse.fromJson(json.decode(str));

String defaultResponseToJson(DefaultResponse data) => json.encode(data.toJson());

class DefaultResponse {
    DefaultResponse({
        this.name,
        this.message,
    });

    String name;
    String message;

    factory DefaultResponse.fromJson(Map<String, dynamic> json) => DefaultResponse(
        name: json["name"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "message": message,
    };
}
