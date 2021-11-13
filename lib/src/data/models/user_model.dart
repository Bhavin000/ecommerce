class UserModel {
  final List addedItems;
  final List savedItems;

  UserModel({
    required this.addedItems,
    required this.savedItems,
  });

  factory UserModel.fromJson(dynamic map) {
    return UserModel(
      addedItems: map['added_items'],
      savedItems: map['saved_items'],
    );
  }

  static toJson(UserModel model) {
    return {
      'added_items': model.addedItems,
      'saved_items': model.savedItems,
    };
  }
}
