class Offer {
  final int id;
  final String name;
  final String description;
  final int discount;
  final String? image;
  final dynamic deletedAt;

  Offer({
    required this.id,
    required this.name,
    required this.description,
    required this.discount,
    required this.image,
    required this.deletedAt,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        discount: json["discount"],
        image: json["image"],
        deletedAt: json["deleted_at"],
      );
}
