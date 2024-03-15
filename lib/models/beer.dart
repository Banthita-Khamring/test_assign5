// POJO (Plain Old Java Object)
class Beer {
  final String? name;
  final String? price;
  final int? reviews;
  final double? average;
  final String? image;

  Beer({
    required this.name,
    required this.price,
    required this.reviews,
    required this.average,
    required this.image,
  });

  factory Beer.fromJson(Map<String, dynamic> json) {
    return Beer(
      name: json['name'],
      price: json['price'],
      reviews: json['rating']['reviews'],
      average: json['rating']['average'],
      image: json['image'],
    );
  }
}