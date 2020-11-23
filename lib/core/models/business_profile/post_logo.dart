import 'dart:convert';

LogoImage logoImageFromJson(String str) => LogoImage.fromJson(json.decode(str));

String logoImageToJson(LogoImage data) => json.encode(data.toJson());

class LogoImage {
    LogoImage({
        this.logo,
    });

    String logo;

    factory LogoImage.fromJson(Map<String, dynamic> json) => LogoImage(
        logo: json["logo"],
    );

    Map<String, dynamic> toJson() => {
        "logo": logo,
    };
}
