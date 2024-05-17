class HotelType {
  final int? id;
  final String? name;

  HotelType({this.id, this.name});

  factory HotelType.fromJson(Map<String, dynamic> json) {
    return HotelType(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
