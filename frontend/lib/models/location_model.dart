
class Location {
  final String name;
  final String country;
  final int temp;
  final String condition;
  final int min;
  final int max;

  Location({
    required this.name,
    required this.country,
    required this.temp,
    required this.condition,
    required this.min,
    required this.max,
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'country': country,
        'temp': temp,
        'condition': condition,
        'min': min,
        'max': max,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Location &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          country == other.country;

  @override
  int get hashCode => name.hashCode ^ country.hashCode;
}