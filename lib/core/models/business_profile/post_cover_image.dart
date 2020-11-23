import 'dart:convert';

PostCoverImage postCoverImageFromJson(String str) => PostCoverImage.fromJson(json.decode(str));

String postCoverImageToJson(PostCoverImage data) => json.encode(data.toJson());

class PostCoverImage {
    PostCoverImage({
        this.cover,
    });

    String cover;

    factory PostCoverImage.fromJson(Map<String, dynamic> json) => PostCoverImage(
        cover: json["cover"],
    );

    Map<String, dynamic> toJson() => {
        "cover": cover,
    };
}
