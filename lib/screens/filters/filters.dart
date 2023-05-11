import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/commons/providers.dart';
import 'package:meals/commons/scaffold_appbar.dart';
// import 'package:meals/tabs.dart';
// import 'package:meals/widgets/drawer_widget.dart';

enum Filter {
  glutenfree,
  lactosefree,
  vegan,
  vegetarian,
}

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilter = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(pageTitle: 'Filter'),
      ),

      // body of the filters
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            SwitchListTile(
              value: activeFilter[Filter.glutenfree]!,
              onChanged: (isChecked) {
                ref
                    .read(filtersProvider.notifier)
                    .selectFilter(Filter.glutenfree, isChecked);
              },
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w900,
                    ),
              ),
              subtitle: Text(
                'Only Gluten_free Meals',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w900,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 4, right: 4),
            ),

            // vegan switch
            SwitchListTile(
              value: activeFilter[Filter.vegan]!,
              onChanged: (isChecked) {
                ref
                    .read(filtersProvider.notifier)
                    .selectFilter(Filter.vegan, isChecked);
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w900,
                    ),
              ),
              subtitle: Text(
                'Only Vegan Meals',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w900,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 4, right: 4),
            ),

            // vegetarian switch
            SwitchListTile(
              value: activeFilter[Filter.vegetarian]!,
              onChanged: (isChecked) {
                ref
                    .read(filtersProvider.notifier)
                    .selectFilter(Filter.vegetarian, isChecked);
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w900,
                    ),
              ),
              subtitle: Text(
                'Only Veggie Meals',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w900,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 4, right: 4),
            ),

            // lactose switch
            SwitchListTile(
              value: activeFilter[Filter.lactosefree]!,
              onChanged: (isChecked) {
                ref
                    .read(filtersProvider.notifier)
                    .selectFilter(Filter.lactosefree, isChecked);
              },
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w900,
                    ),
              ),
              subtitle: Text(
                'Only Lactose Free Meals',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w900,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 4, right: 4),
            )
          ],
        ),
      ),
    );
  }
}























































































// class FilterScreen extends ConsumerStatefulWidget {
//   const FilterScreen({super.key});

//   // store current filters

//   @override
//   ConsumerState<FilterScreen> createState() => _FilterScreenState();
// }

// class _FilterScreenState extends ConsumerState<FilterScreen> {
//   bool _glutenFree = false;
//   bool _isVegan = false;
//   bool _isVegetarian = false;
//   bool _lactoseFree = false;

//   // void _setScreen(String identifier) {
//   //   if (identifier == 'meals') {
//   //     Navigator.of(context).pop();
//   //     Navigator.of(context).pushReplacement(
//   //       MaterialPageRoute(
//   //         builder: (ctx) => const TabScreen(),
//   //       ),
//   //     );
//   //   } else {
//   //     Navigator.of(context).pop();
//   //   }
//   // }

//   // use initState() to set the previous state of the filters
//   @override
//   void initState() {
//     super.initState();

//     final activeFilters = ref.read(filtersProvider);

//     _glutenFree = activeFilters[Filter.glutenfree]!;
//     _isVegan = activeFilters[Filter.vegan]!;
//     _isVegetarian = activeFilters[Filter.vegetarian]!;
//     _lactoseFree = activeFilters[Filter.lactosefree]!;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const AppBarTitle(pageTitle: 'Filter'),
//       ),

//       // add drawer menu
//       // drawer: MainDrawer(
//       //   onSelectedPage: _setScreen,
//       // ),

//       // body of the filters
//       body: WillPopScope(
//         // passing the filter data back to the main screen widget
//         onWillPop: () async {
//           ref.read(filtersProvider.notifier).setFilter({
//             Filter.glutenfree: _glutenFree,
//             Filter.lactosefree: _lactoseFree,
//             Filter.vegan: _isVegan,
//             Filter.vegetarian: _isVegetarian,
//           });

//           return true; // to allow flutter perform it pop action as normal without the manual means of using Navigator.pop()

//           // instead of passing the set filters to pop we instead set them in our provider
//           // Navigator.of(context).pop({
//           //   Filter.glutenfree: _glutenFree,
//           //   Filter.lactosefree: _lactoseFree,
//           //   Filter.vegan: _isVegan,
//           //   Filter.vegetarian: _isVegetarian,
//           // });
//           // return false;
//         },

//         // main content for the filtering screen
//         child: Padding(
//           padding: const EdgeInsets.all(14.0),
//           child: Column(
//             children: [
//               SwitchListTile(
//                 value: _glutenFree,
//                 onChanged: (isChecked) {
//                   setState(() {
//                     _glutenFree = isChecked;
//                   });
//                 },
//                 title: Text(
//                   'Gluten-free',
//                   style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                         color: Theme.of(context).colorScheme.onBackground,
//                         fontWeight: FontWeight.w900,
//                       ),
//                 ),
//                 subtitle: Text(
//                   'Only Gluten_free Meals',
//                   style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                         color: Theme.of(context).colorScheme.onBackground,
//                         fontWeight: FontWeight.w900,
//                       ),
//                 ),
//                 activeColor: Theme.of(context).colorScheme.tertiary,
//                 contentPadding: const EdgeInsets.only(left: 4, right: 4),
//               ),
//               SwitchListTile(
//                 value: _isVegan,
//                 onChanged: (isChecked) {
//                   setState(() {
//                     _isVegan = isChecked;
//                   });
//                 },
//                 title: Text(
//                   'Vegan',
//                   style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                         color: Theme.of(context).colorScheme.onBackground,
//                         fontWeight: FontWeight.w900,
//                       ),
//                 ),
//                 subtitle: Text(
//                   'Only Vegan Meals',
//                   style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                         color: Theme.of(context).colorScheme.onBackground,
//                         fontWeight: FontWeight.w900,
//                       ),
//                 ),
//                 activeColor: Theme.of(context).colorScheme.tertiary,
//                 contentPadding: const EdgeInsets.only(left: 4, right: 4),
//               ),
//               SwitchListTile(
//                 value: _isVegetarian,
//                 onChanged: (isChecked) {
//                   setState(() {
//                     _isVegetarian = isChecked;
//                   });
//                 },
//                 title: Text(
//                   'Vegetarian',
//                   style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                         color: Theme.of(context).colorScheme.onBackground,
//                         fontWeight: FontWeight.w900,
//                       ),
//                 ),
//                 subtitle: Text(
//                   'Only Veggie Meals',
//                   style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                         color: Theme.of(context).colorScheme.onBackground,
//                         fontWeight: FontWeight.w900,
//                       ),
//                 ),
//                 activeColor: Theme.of(context).colorScheme.tertiary,
//                 contentPadding: const EdgeInsets.only(left: 4, right: 4),
//               ),
//               SwitchListTile(
//                 value: _lactoseFree,
//                 onChanged: (isChecked) {
//                   setState(() {
//                     _lactoseFree = isChecked;
//                   });
//                 },
//                 title: Text(
//                   'Lactose-free',
//                   style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                         color: Theme.of(context).colorScheme.onBackground,
//                         fontWeight: FontWeight.w900,
//                       ),
//                 ),
//                 subtitle: Text(
//                   'Only Lactose Free Meals',
//                   style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                         color: Theme.of(context).colorScheme.onBackground,
//                         fontWeight: FontWeight.w900,
//                       ),
//                 ),
//                 activeColor: Theme.of(context).colorScheme.tertiary,
//                 contentPadding: const EdgeInsets.only(left: 4, right: 4),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
