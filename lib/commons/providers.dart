import 'package:meals/screens/meals/data/meals_data.dart';
import 'package:meals/screens/meals/models/meals_model.dart';
import 'package:riverpod/riverpod.dart';

import '../screens/filters/filters.dart';

// meals provider
final mealsProvider = Provider((ref) {
  return dummyMeals;
});

// favorites provider
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavorite(Meal meal) {
    // regardless of adding or removing a meal we create
    // a new list for the provider state
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      // if the meal being requested in the list has no similar id to the meal
      // passed in other to remove a meal from the favorite meal list
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      // ...state is the list of meals
      // this part adds the meal to the list of favorite meals
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});

// filters provider
class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenfree: false,
          Filter.lactosefree: false,
          Filter.vegan: false,
          Filter.vegetarian: false,
        });

  void setFilter(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void selectFilter(Filter filter, bool isActive) {
    state = {
      ...state, // copies existing filter in the map to this new state
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>((ref) {
  return FiltersNotifier();
});

final filteredMealsProvider = Provider((ref) {
  // ensures the filteredMealsProvider is updated whenever the mealsProvider is updated
  final meals = ref.watch(mealsProvider);

  final activeFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (activeFilters[Filter.glutenfree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactosefree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});
