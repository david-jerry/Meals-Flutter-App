import 'package:flutter/material.dart';
import 'package:meals/screens/category/data/category_data.dart';
import 'package:meals/screens/category/models/category_model.dart';
import 'package:meals/screens/category/widgets/category_grid.dart';
import 'package:meals/screens/meals/meals.dart';
import 'package:meals/screens/meals/models/meals_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.fMeals});

  final List<Meal> fMeals;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

// using with to add mixins in to the class either SingleTickerProviderStateMixin or TickerProviderStateMixin for multiple animations
class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  // explicit animations must be added to state builds so it can change the states of the app
  late AnimationController
      _animationController; // late tell flutter that the variable will have a value later

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, CategoryModel category) {
    // filter the meals by its category
    final filteredMeals = widget.fMeals
        .where(
          (meal) => meal.categories.contains(
            category.id,
          ), // check if the meal has a category id related to it
        )
        .toList();

    // navigate to the meal page for a specific category
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: Scaffold(
          body: GridView(
            padding: const EdgeInsets.fromLTRB(
              14,
              14,
              14,
              14,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            children: [
              // ALT: availableCategories.map((category) => CategoryGridItem(category: category))
              for (final category in availableCategories)
                CategoryGridItem(
                  category: category,
                  onSelectedCategory: () {
                    _selectCategory(context, category);
                  },
                ),
            ],
          ),
        ),
        builder: (context, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(0, 0.3),
              end: const Offset(0, 0),
            ).animate(CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInOut,
            )),
            child: child,
          );
        });
  }
}
