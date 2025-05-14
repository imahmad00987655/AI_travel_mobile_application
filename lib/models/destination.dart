class Destination {
  final String name;
  final String description;
  final String image;
  final double price;
  final double rating;
  final int? reviews;

  Destination({
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.rating,
    this.reviews,
  });
} 