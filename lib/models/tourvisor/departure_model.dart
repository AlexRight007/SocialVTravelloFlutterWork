class Departure {
  final int? id;
  final String? name;
  final String? namefrom;
  final int? national;

  Departure({
    this.id,
    this.name,
    this.namefrom,
    this.national,
  });

  factory Departure.fromJson(Map<String, dynamic> json) {
    return Departure(
      id: json['id'] as int?,
      name: json['name'] as String?,
      namefrom: json['namefrom'] as String?,
      national: json['national'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'namefrom': namefrom,
      'national': national,
    };
  }
}
