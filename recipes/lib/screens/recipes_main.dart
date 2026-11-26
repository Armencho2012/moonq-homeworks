import 'package:material_ui/material_ui.dart';
import 'package:recipes/data/fake_recipe_repository.dart';
import 'package:recipes/models/recipe.dart';
import 'package:recipes/widgets/loading_screen.dart';

class RecipesMain extends StatefulWidget {
  const RecipesMain({super.key});

  @override
  State<RecipesMain> createState() => _RecipesMainState();
}

class _RecipesMainState extends State<RecipesMain> {
  final FakeRecipeRepository _repository = FakeRecipeRepository();
  late Future<List<Recipe>> _future;

  @override
  void initState() {
    super.initState();
    _future = _repository.fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recipes',
          style: TextStyle(color: Colors.indigo),
        ),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingScreen());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Failed to load recipes'),
                  Text(snapshot.error.toString()),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _future = _repository.fetchRecipes();
                      });
                    },
                    child: const Text('Կրկին փորձել'),
                  )
                ],
              ),
            );
          }
          final recipes = snapshot.data ?? [];
          if (recipes.isEmpty) {
            return const Center(child: Text('No recipes found'));
          }
          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                child: ListTile(
                  title: Text(recipe.name),
                  subtitle: Text(
                    '${recipe.cuisine} • ${recipe.cookTimeMinutes.toStringAsFixed(0)} րոպե',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(recipe.rating.toStringAsFixed(1)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}