class HotelServiceGroup {
  final int? id;
  final String? name;
  final int? order;
  final List<HotelServiceGroup>? childrens;
  final bool? popular;
  final int? groupId;

  HotelServiceGroup({
    this.id,
    this.name,
    this.order,
    this.childrens,
    this.popular,
    this.groupId,
  });

  factory HotelServiceGroup.fromJson(Map<String, dynamic> json) {
    return HotelServiceGroup(
      id: json['id'],
      name: json['name'],
      order: json['order'],
      childrens: json['childrens'] != null
          ? List<HotelServiceGroup>.from(
              json['childrens']
                  .map((child) => HotelServiceGroup.fromJson(child)),
            )
          : null,
      popular: json['popular'],
      groupId: json['groupId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'order': order,
      'childrens': childrens != null
          ? List<dynamic>.from(childrens!.map((child) => child.toJson()))
          : null,
      'popular': popular,
      'groupId': groupId,
    };
  }
}
