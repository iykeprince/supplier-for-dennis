import 'dart:convert';

PortfolioResponse portfolioResponseFromJson(String str) => PortfolioResponse.fromJson(json.decode(str));

String portfolioResponseToJson(PortfolioResponse data) => json.encode(data.toJson());

class PortfolioResponse {
    PortfolioResponse({
        this.previewS,
        this.createdAt,
        this.previewM,
        this.raw,
        this.path1M,
        this.previewL,
        this.uuid,
        this.tags,
        this.previewXl,
        this.path,
        this.previewXxs,
        this.updatedAt,
        this.previewXs,
        this.vendorId,
        this.name,
        this.id,
        this.portfolioResponseId,
        this.key,
    });

    PreviewL previewS;
    AtedAt createdAt;
    PreviewL previewM;
    PreviewL raw;
    String path1M;
    PreviewL previewL;
    String uuid;
    List<String> tags;
    PreviewL previewXl;
    String path;
    PreviewL previewXxs;
    AtedAt updatedAt;
    PreviewL previewXs;
    String vendorId;
    String name;
    String id;
    String portfolioResponseId;
    String key;

    factory PortfolioResponse.fromJson(Map<String, dynamic> json) => PortfolioResponse(
        previewS: json["preview_s"] != null ? PreviewL.fromJson(json["preview_s"]) : null,
        createdAt: json["created_at"] != null ? AtedAt.fromJson(json["created_at"]) : null,
        previewM: json["preview_m"] != null ? PreviewL.fromJson(json["preview_m"]) : null,
        raw: json["raw"] != null ? PreviewL.fromJson(json["raw"]) : null,
        path1M: json["path1m"],
        previewL: json["preview_l"] != null ? PreviewL.fromJson(json["preview_l"]) : null,
        uuid: json["uuid"],
        tags: json["tags"] != null ? List<String>.from(json["tags"].map((x) => x)) : null,
        previewXl: json["preview_xl"] != null ? PreviewL.fromJson(json["preview_xl"]) : null,
        path: json["path"],
        previewXxs: json["preview_xxs"] != null ? PreviewL.fromJson(json["preview_xxs"]) : null,
        updatedAt: json["updated_at"] != null ? AtedAt.fromJson(json["updated_at"]) : null,
        previewXs: json["preview_xs"] != null ? PreviewL.fromJson(json["preview_xs"]) : null,
        vendorId: json["vendor_id"],
        name: json["name"],
        id: json["_id"],
        portfolioResponseId: json["id"],
        key: json["key"],
    );

    Map<String, dynamic> toJson() => {
        "preview_s": previewS.toJson(),
        "created_at": createdAt.toJson(),
        "preview_m": previewM.toJson(),
        "raw": raw.toJson(),
        "path1m": path1M,
        "preview_l": previewL.toJson(),
        "uuid": uuid,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "preview_xl": previewXl.toJson(),
        "path": path,
        "preview_xxs": previewXxs.toJson(),
        "updated_at": updatedAt.toJson(),
        "preview_xs": previewXs.toJson(),
        "vendor_id": vendorId,
        "name": name,
        "_id": id,
        "id": portfolioResponseId,
        "key": key,
    };
}

class AtedAt {
    AtedAt({
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

    factory AtedAt.fromJson(Map<String, dynamic> json) => AtedAt(
        year: Day.fromJson(json["year"]),
        month: Day.fromJson(json["month"]),
        day: Day.fromJson(json["day"]),
        hour: Day.fromJson(json["hour"]),
        minute: Day.fromJson(json["minute"]),
        second: Day.fromJson(json["second"]),
        nanosecond: Day.fromJson(json["nanosecond"]),
        timeZoneOffsetSeconds: Day.fromJson(json["timeZoneOffsetSeconds"]),
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

class PreviewL {
    PreviewL({
        this.width,
        this.height,
        this.path,
    });

    int width;
    int height;
    String path;

    factory PreviewL.fromJson(Map<String, dynamic> json) => PreviewL(
        width: json["width"],
        height: json["height"],
        path: json["path"],
    );

    Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "path": path,
    };
}
