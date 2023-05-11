import 'package:flutter/material.dart';
import 'package:meals/commons/providers.dart';
import 'package:meals/commons/scaffold_appbar.dart';
import 'package:meals/screens/category/category_screen.dart';
import 'package:meals/screens/filters/filters.dart';
import 'package:meals/screens/meals/meals.dart';
import 'package:meals/widgets/drawer_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// set global filters
const kInitialFilters = {
  Filter.glutenfree: false,
  Filter.lactosefree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

// view class function
class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

// view class state
class _TabScreenState extends ConsumerState<TabScreen> {
  // new variable for page index
  int _selectedPageIndex = 0;

  // set favorite meals list here

  // storing the filters manually without a provider class
  // Map<Filter, bool> _selectedFilters = kInitialFilters;

  // function to choose from the selected screens to switch into
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FilterScreen(),
        ),
      );

      // we can pass back async/future data from a
      // previous page using the generic widget push with <> angle brackets
      // final result = await Navigator.of(context).push<Map<Filter, bool>>(
      //   MaterialPageRoute(
      //     builder: (ctx) => const FilterScreen(),
      //   ),
      // );
      // if (kDebugMode) {
      //   print(result);
      // }

      // setState(() {
      //   _selectedFilters = result ??
      //       kInitialFilters; // using ?? allows us to add a default value
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    // filtered Meals
    final filteredMeals = ref.watch(
        filteredMealsProvider); // to return a list of meals without these filter

    // widget to toggle favorites
    Widget activeScreen = CategoryScreen(
      fMeals: filteredMeals,
    );

    // page title for the navigation function
    var pageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMealsNotifier = ref.watch(favoriteMealsProvider);
      activeScreen = MealsScreen(
        title: 'Favorites',
        meals: favoriteMealsNotifier,
      );
      pageTitle = 'Favorites';
    } else if (_selectedPageIndex == 0) {
      activeScreen = activeScreen;
      pageTitle = 'Categories';
    }

    return Scaffold(
      // App bar
      appBar: AppBar(
        title: AppBarTitle(pageTitle: pageTitle),
      ),

      // add side drawer for filtering
      drawer: MainDrawer(
        onSelectedPage: _setScreen,
      ),

      // body
      body: activeScreen,

      // bottom nav bar
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _selectPage(index);
        },
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')
        ],
      ),
    );
  }
}
