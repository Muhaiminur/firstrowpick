class Datum {
  int? id;
  String? title;
  String? description;
  String? postedBy;
  String? image;
  String? imageUrl;
  String? status;

  Datum({
    this.id,
    this.title,
    this.description,
    this.postedBy,
    this.image,
    this.imageUrl,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] ?? 0,
        title: json['title'] ?? "",
        description: json['description'] ?? "",
        postedBy: json['posted_by'] ?? "",
        image: json['image'] ?? "",
        imageUrl: json['image_url'] ?? "",
        status: json['status'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'posted_by': postedBy,
        'image': image,
        'status': status,
        'image_url': imageUrl
      };
}
