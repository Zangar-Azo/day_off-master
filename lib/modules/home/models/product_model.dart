class ProductModel {
  final String name;
  final String price;
  final String oldPrice;
  final String description;
  final String brand;

  final String id;
  final String categoryId;
  String quantity;
  final String stock;
  final String rating;
  final String smallImg;
  final String largeImg;
  bool bought;
  bool isFavorite;

  ProductModel({
    this.id,
    this.categoryId,
    this.name,
    this.price,
    this.oldPrice,
    this.description,
    this.quantity,
    this.stock,
    this.rating,
    this.smallImg,
    this.largeImg,
    this.brand,
    this.bought = false,
    this.isFavorite = false,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['product_id'],
        categoryId: json['category_id'],
        name: json['model'],
        price: json['price'],
        oldPrice: json['old_price'],
        description: json['description'],
        quantity: json['quantity'],
        stock: json['stock'],
        smallImg: json['small_image'],
        largeImg: json['large_image'],
        rating: json['rating'],
        brand: json['brand'],
      );

  void increaseQuantity() {
    var nextQuantity = int.parse(quantity) + 1;
    quantity = nextQuantity.toString();
  }

  void decreaseQuantity() {
    var nextQuantity = int.parse(quantity) - 1;
    quantity = nextQuantity.toString();
  }

  void changeBoughtState() {
    bought = !bought;
  }
}
