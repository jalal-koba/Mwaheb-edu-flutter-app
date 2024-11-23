class Section {
  final int id;
  final int? parentId;
  final String type;
  final String name;
  final String? image;
  final String description;
   final int? price;
   final String? introVideo;
 
  Section({
    required this.id,
    required this.parentId,
    required this.type,
    required this.name,
    required this.image,
    required this.description,
     required this.price,
     required this.introVideo,
   });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        parentId: json["parent_id"]??0,
        type: json["type"]??"",
        name: json["name"],
        image: json["image"],
        description: json["description"]??'',
         price: json["price"],
         introVideo: json["intro_video"],
       );
}

 