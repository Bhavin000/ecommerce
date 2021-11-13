class ItemModel {
  final String createdBy;
  final String title;
  final String description;
  final String price;
  final String imageUrl;

  ItemModel({
    required this.createdBy,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory ItemModel.fromJson(dynamic map) {
    return ItemModel(
      createdBy: map['created_by'],
      title: map['title'],
      description: map['description'],
      price: map['price'],
      imageUrl: map['image_url'],
    );
  }

  static toJson(ItemModel model) {
    return {
      'created_by': model.createdBy,
      'title': model.title,
      'description': model.description,
      'price': model.price,
      'image_url': model.imageUrl,
    };
  }
}
