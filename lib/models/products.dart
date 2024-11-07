import 'dart:convert';

List<Products> productsFromJson(String str) => List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  int id;
  String title;
  double price;
  String description;
  Category category;
  String image;
  Rating rating;
  int quantity;
  bool isFavorite;

  Products({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    this.quantity = 1,
    this.isFavorite = false,
  });

  Products copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    Category? category,
    String? image,
    Rating? rating,
    int? quantity,
    bool? isFavorite,
  }) =>
      Products(
        id: id ?? this.id,
        title: title ?? this.title,
        price: price ?? this.price,
        description: description ?? this.description,
        category: category ?? this.category,
        image: image ?? this.image,
        rating: rating ?? this.rating,
        quantity: quantity ?? this.quantity,
        isFavorite: isFavorite ?? this.isFavorite,
      );

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        category: categoryValues.map[json["category"]]!,
        image: json["image"],
        rating: Rating.fromJson(json["rating"]),
        quantity: json["quantity"] ?? 1,
        isFavorite: json["favorite"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": categoryValues.reverse[category],
        "image": image,
        "rating": rating.toJson(),
        "quantity": quantity,
        "favorite": isFavorite,
      };

  @override
  String toString() {
    return 'Products(id: $id, title: $title, price: $price, description: $description, category: ${category.name}, image: $image, rating: ${rating.toString()}, quantity: $quantity, isFavorite: $isFavorite)';
  }
}

enum Category { ELECTRONICS, JEWELERY, MEN_S_CLOTHING, WOMEN_S_CLOTHING }

extension CategoryExtension on Category {
  String get name {
    switch (this) {
      case Category.ELECTRONICS:
        return "Electronics";
      case Category.JEWELERY:
        return "Jewelery";
      case Category.MEN_S_CLOTHING:
        return "Men's Clothing";
      case Category.WOMEN_S_CLOTHING:
        return "Women's Clothing";
      default:
        return '';
    }
  }
}

final categoryValues = EnumValues({
  "electronics": Category.ELECTRONICS,
  "jewelery": Category.JEWELERY,
  "men's clothing": Category.MEN_S_CLOTHING,
  "women's clothing": Category.WOMEN_S_CLOTHING
});

class Rating {
  double rate;
  int count;

  Rating({
    required this.rate,
    required this.count,
  });

  Rating copyWith({
    double? rate,
    int? count,
  }) =>
      Rating(
        rate: rate ?? this.rate,
        count: count ?? this.count,
      );

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: json["rate"]?.toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };

  @override
  String toString() {
    return 'Rating(rate: $rate, count: $count)';
  }
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
