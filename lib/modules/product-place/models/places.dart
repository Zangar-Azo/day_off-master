class Places {
  final String description;
  final String placeID;

  Places({this.description, this.placeID});

  factory Places.fromJson(Map<String, dynamic> json) =>
      Places(description: json['description'], placeID: json['place_id']);

  @override
  String toString() {
    return description;
  }
}
