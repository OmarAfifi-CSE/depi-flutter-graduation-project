class Product {
  final String name;
  final String brand;
  final double price;
  final String imageUrl;
  final bool isSelected;

  Product({
    required this.name,
    required this.brand,
    required this.price,
    required this.imageUrl,
    this.isSelected = false,
  });
}