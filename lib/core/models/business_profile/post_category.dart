import 'dart:convert';

PostCategory postCategoryFromJson(String str) => PostCategory.fromJson(json.decode(str));

String postCategoryToJson(PostCategory data) => json.encode(data.toJson());

class PostCategory {
    PostCategory({
        this.categories,
    });

    List<String> categories;

    factory PostCategory.fromJson(Map<String, dynamic> json) => PostCategory(
        categories: List<String>.from(json["categories"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x)),
    };
}
