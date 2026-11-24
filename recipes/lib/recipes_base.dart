import 'package:material_ui/material_ui.dart';
import 'package:recipes/screens/recipes_main.dart';

class RecipesBase extends StatelessWidget {
  const RecipesBase({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipes App',
      home: RecipesMain()
    );
  }
}