class CartItem {
  final String id;
  final String animalImage;
  final String animalId;
  final String name;
  final double price;
  final bool butcherService;
  final String deliveryDay; // First, Second, or Third day

  CartItem({
    required this.id,
    required this.animalImage,
    required this.animalId,
    required this.name,
    required this.price,
    required this.butcherService,
    required this.deliveryDay,
  });
}
