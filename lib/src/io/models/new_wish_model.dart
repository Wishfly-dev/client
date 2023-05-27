class NewWishModel {
  final String title;
  final String description;

  NewWishModel({
    required this.title,
    required this.description,
  });

  @override
  String toString() => 'NewWishModel(title: $title, description: $description)';
}
