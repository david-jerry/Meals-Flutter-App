import 'package:flutter/material.dart';
import 'package:meals/commons/string_formats.dart';
import 'package:meals/screens/meals/commons/meal_meta.dart';
import 'package:meals/screens/meals/models/meals_model.dart';
import 'package:transparent_image/transparent_image.dart';

class MealCard extends StatelessWidget {
  const MealCard({
    super.key,
    required this.onSelectedMeal,
    required this.meal,
  });

  final Meal meal;
  final void Function() onSelectedMeal;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.hardEdge,
      elevation: 4,
      child: InkWell(
        onTap: onSelectedMeal,
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
              image:
                  NetworkImage(meal.imageUrl), //MemoryImage(kTransparentImage),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 23,
                  vertical: 6,
                ),
                color: const Color.fromARGB(171, 0, 0, 0),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealMeta(
                          label: '${meal.duration} min(s)',
                          icon: Icons.schedule,
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        MealMeta(
                          label: toTitle(meal.affordability.name),
                          icon: Icons.currency_exchange,
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        MealMeta(
                          label: toTitle(meal.complexity.name),
                          icon: Icons.work,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// for (final category in meal.categories)
//                           Padding(
//                             padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
//                             child: Text(
//                               category,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .labelSmall!
//                                   .copyWith(
//                                     color: Theme.of(context)
//                                         .colorScheme
//                                         .onBackground,
//                                   ),
//                             ),
//                           )

// ListView.builder(
//         itemCount: meals.length,
//         itemBuilder: (ctx, index) {
//           final meal = meals[index];
//           return ListTile(
//             title: Text(
//               meal.title,
//               style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                     color: Theme.of(context).colorScheme.onBackground,
//                   ),
//             ),
//             leading: CircleAvatar(
//               backgroundImage: NetworkImage(meal.imageUrl),
//             ),
//           );
//         },
//       );
