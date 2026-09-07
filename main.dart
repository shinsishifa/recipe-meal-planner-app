import 'package:flutter/material.dart';

void main() {
  runApp(const RecipePlannerApp());
}

class RecipePlannerApp extends StatelessWidget {
  const RecipePlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe & Meal Planner',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const RecipeHomeScreen(),
    );
  }
}

class Recipe {
  final String title;
  final String category;
  final int prepTime;
  final List<String> ingredients;
  final String instructions;

  Recipe({
    required this.title,
    required this.category,
    required this.prepTime,
    required this.ingredients,
    required this.instructions,
  });
}

class RecipeHomeScreen extends StatefulWidget {
  const RecipeHomeScreen({super.key});

  @override
  State<RecipeHomeScreen> createState() => _RecipeHomeScreenState();
}

class _RecipeHomeScreenState extends State<RecipeHomeScreen> {
  final List<Recipe> _allRecipes = [
    Recipe(
      title: 'Classic Chicken Biryani',
      category: 'Dinner',
      prepTime: 45,
      ingredients: ['Rice', 'Chicken', 'Spices', 'Yogurt', 'Onions'],
      instructions: 'Marinate chicken with spices. Layer with partially cooked rice and dum cook on low heat until tender.',
    ),
    Recipe(
      title: 'Avocado Toast & Egg',
      category: 'Breakfast',
      prepTime: 10,
      ingredients: ['Bread', 'Avocado', 'Egg', 'Salt & Pepper', 'Olive Oil'],
      instructions: 'Toast the bread. Mash avocado with seasoning and spread on toast. Top with a fried or poached egg.',
    ),
    Recipe(
      title: 'Mediterranean Salad',
      category: 'Lunch',
      prepTime: 15,
      ingredients: ['Cucumber', 'Tomatoes', 'Feta Cheese', 'Olives', 'Dressing'],
      instructions: 'Chop all vegetables into bite-sized pieces. Toss together with olives, feta cheese, and olive oil dressing.',
    ),
  ];

  String _selectedCategory = 'All';

  List<Recipe> get _filteredRecipes {
    if (_selectedCategory == 'All') return _allRecipes;
    return _allRecipes.where((r) => r.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2E7D32);
    const backgroundColor = Color(0xFFF1F8E9);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Recipe & Meal Planner'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Category Filter Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['All', 'Breakfast', 'Lunch', 'Dinner'].map((category) {
                final isSelected = _selectedCategory == category;
                return ChoiceChip(
                  label: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: primaryColor,
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Recipe List
            Expanded(
              child: ListView.builder(
                itemCount: _filteredRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = _filteredRecipes[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ExpansionTile(
                      leading: CircleAvatar(
                        backgroundColor: primaryColor,
                        child: Icon(
                          recipe.category == 'Breakfast'
                              ? Icons.wb_sunny
                              : recipe.category == 'Lunch'
                                  ? Icons.lunch_dining
                                  : Icons.dinner_dining,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        recipe.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('${recipe.category} • ⏱️ ${recipe.prepTime} mins'),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Ingredients:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text('• ${recipe.ingredients.join("\n• ")}'),
                              const SizedBox(height: 12),
                              const Text(
                                'Instructions:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(recipe.instructions),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
