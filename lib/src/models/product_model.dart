class Product {
  final String title;
  final String description;
  final int rentCost;
  final int productPrice;
  final double rating;
  final String owner;
  final List<String>? images;
  String? currentRenter;

  Product({
    required this.title,
    required this.description,
    required this.rentCost,
    required this.productPrice,
    required this.rating,
    required this.owner,
    required this.images,
    this.currentRenter,
  });

  Map<String, dynamic> toJSON() {
    return {
      'title': title,
      'description': description,
      'rentCost': rentCost,
      'productPrice': productPrice,
      'rating': rating,
      'owner': owner,
      'images': images,
    };
  }
}

List<Product> demoProducts = [
  Product(
    title: 'Wireless Controller for PS4™',
    description: '',
    rentCost: 200000,
    productPrice: 5000000,
    rating: 4.8,
    owner: 'Test',
    images: [
      'assets/images/ps4_console_white_1.png',
      'assets/images/ps4_console_white_2.png',
      'assets/images/ps4_console_white_3.png',
      'assets/images/ps4_console_white_4.png',
    ],
  ),
];
