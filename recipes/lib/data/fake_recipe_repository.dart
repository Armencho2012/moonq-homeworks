import 'package:recipes/models/recipe.dart';

class FakeRecipeRepository {
  final List<Recipe> _recipes = [
    Recipe(id: 1, name: 'Dolma', cuisine: 'Armenian', cookTimeMinutes: 90, difficulty: 'Medium', rating: 4.8),
    Recipe(id: 2, name: 'Margherita Pizza', cuisine: 'Italian', cookTimeMinutes: 40, difficulty: 'Easy', rating: 4.5),
    Recipe(id: 3, name: 'Beef Wellington', cuisine: 'British', cookTimeMinutes: 150, difficulty: 'Hard', rating: 4.7),
    Recipe(id: 4, name: 'Pad Thai', cuisine: 'Thai', cookTimeMinutes: 30, difficulty: 'Medium', rating: 4.4),
    Recipe(id: 5, name: 'Greek Salad', cuisine: 'Greek', cookTimeMinutes: 15, difficulty: 'Easy', rating: 4.2),
    Recipe(id: 6, name: 'Khorovats', cuisine: 'Armenian', cookTimeMinutes: 60, difficulty: 'Medium', rating: 4.9),
  ];
  Future<List<Recipe>> fetchRecipes() async{
    return Future.delayed(const Duration(seconds: 2), ()=>_recipes);
  }
}