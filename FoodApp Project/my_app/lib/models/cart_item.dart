class CartItem {
  final String title;
  final String description;
  final double price;
  final String imagePath;
  int quantity;

  CartItem({
    required this.title,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.quantity,
  });
}
