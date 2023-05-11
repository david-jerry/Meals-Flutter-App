import 'package:flutter/material.dart';
import 'package:meals/screens/meals/meals_detail.dart';
import 'package:meals/screens/meals/models/meals_model.dart';
import 'package:meals/screens/meals/widgets/meals_card.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals});

  final String title;
  final List<Meal> meals; // NOTE: Returns a list of meals from the Meal model

  void _selectMeal(BuildContext context, Meal meal) {
    // navigate to the meal page for a specific category
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealDetail(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (title == 'Favorites') {
      return Scaffold(
        // use listview builder for performance enhanced way to show scrollable list item
        body: meals.isNotEmpty
            ? ListView.builder(
                itemCount: meals.length,
                itemBuilder: (ctx, index) {
                  final meal = meals[index];
                  return MealCard(
                    meal: meal,
                    onSelectedMeal: () {
                      _selectMeal(context, meal);
                    },
                  );
                },
              )
            : Center(
                child: Text(
                  'No Available Meals for this category!',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      // use listview builder for performance enhanced way to show scrollable list item
      body: meals.isNotEmpty
          ? ListView.builder(
              itemCount: meals.length,
              itemBuilder: (ctx, index) {
                final meal = meals[index];
                return MealCard(
                  meal: meal,
                  onSelectedMeal: () {
                    _selectMeal(context, meal);
                  },
                );
              },
            )
          : Center(
              child: Text(
                'No Available Meals for this category!',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
    );
  }
}
