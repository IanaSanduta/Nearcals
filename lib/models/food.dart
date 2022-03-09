class Food {
  final String name;
  final String brandName;
  final int calories;

  String getname() => name;

  Food({required this.name, required this.brandName, required this.calories});

  factory Food.fromJson(dynamic json) {
    return Food(
        name: json['item_name'] as String,
        brandName: json['brand_name'] as String,
        calories: json['nf_calories'] as int);
  }

  static List<Food> caloriesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Food.fromJson(data);
    }).toList();
  }

  @override
  String toString(){
    return 'Recipe {name: $name, brandName: $brandName, nf_calories: $calories}';
  }
}
