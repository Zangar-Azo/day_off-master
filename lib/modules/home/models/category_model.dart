class CategoryModel {
  final String name;
  final String url;
  final String number;

  final String id;

  CategoryModel({this.id, this.name, this.url, this.number});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['category_id'],
        url: json['url'],
        name: json['name'],
        number: json['products_count'],
      );

  Map<String, dynamic> toJson() => {
        'category_id': id,
        'url': url,
        'name': name,
        'products_count': number,
      };
}
