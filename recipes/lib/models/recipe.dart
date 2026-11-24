class Recipe {
  final int id;
  final String name;
  final String cuisine;
  final double cookTimeMinutes;
  final String difficulty;
  final double rating;

  const Recipe({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.cookTimeMinutes,
    required this.difficulty,
    required this.rating,
  });
}