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