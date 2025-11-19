// To parse this JSON data, do
//
//     final productEntry = productEntryFromJson(jsonString);

import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) => List<ProductEntry>.from(json.decode(str).map((x) => ProductEntry.fromJson(x)));

String productEntryToJson(List<ProductEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductEntry {
    String id;
    String name;
    int price;
    String description;
    dynamic thumbnail;
    String category;
    bool isFeatured;
    int stock;
    String brand;
    int rating;
    String? userId;
    String? userUsername;
    bool isOwner;
    String detailUrl;
    String deleteUrl;

    ProductEntry({
        required this.id,
        required this.name,
        required this.price,
        required this.description,
        required this.thumbnail,
        required this.category,
        required this.isFeatured,
        required this.stock,
        required this.brand,
        required this.rating,
        required this.userId,
        required this.userUsername,
        required this.isOwner,
        required this.detailUrl,
        required this.deleteUrl,
    });

    factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        category: json["category"],
        isFeatured: json["is_featured"],
        stock: json["stock"],
        brand: json["brand"],
        rating: json["rating"],
        userId: json["user_id"],
        userUsername: json["user_username"],
        isOwner: json["is_owner"],
        detailUrl: json["detail_url"],
        deleteUrl: json["delete_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "thumbnail": thumbnail,
        "category": category,
        "is_featured": isFeatured,
        "stock": stock,
        "brand": brand,
        "rating": rating,
        "user_id": userId,
        "user_username": userUsername,
        "is_owner": isOwner,
        "detail_url": detailUrl,
        "delete_url": deleteUrl,
    };
}