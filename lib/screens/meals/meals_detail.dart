import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/commons/providers.dart';
import 'package:meals/commons/snackbar_messages.dart';
import 'package:meals/commons/string_formats.dart';
import 'package:meals/screens/meals/commons/meal_meta.dart';
import 'package:meals/screens/meals/models/meals_model.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetail extends ConsumerWidget {
  const MealDetail({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals =
        ref.watch(favoriteMealsProvider); //get all favorite meals
    final isFavorite = favoriteMeals
        .contains(meal); // check if the current meal is in the favoriteList

    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),

        // favorite action button
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavorite(meal);

              if (wasAdded) {
                showSuccessMessage(context,
                    'You have successfully added ${meal.title} to the favorite list');
              } else {
                showErrorMessage(context,
                    'You have successfully removed ${meal.title} from the favorite list');
              }
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(
                    begin: 0.5,
                    end: 1.0,
                  ).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                key: ValueKey(isFavorite),
              ),
            ),
          )
        ],
      ),

      // Body
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            // meal image and the meta tags for this specific meal
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.hardEdge,
              elevation: 4,
              child: Stack(
                children: [
                  Hero(
                    tag: meal.id,
                    child: FadeInImage(
                      placeholder: MemoryImage(kTransparentImage),
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                      image: NetworkImage(
                          meal.imageUrl), //MemoryImage(kTransparentImage),
                    ),
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
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
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

            // Space between the top image and the description
            const SizedBox(
              height: 14,
            ),

            // description details
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(109, 0, 0, 0),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // ingredients section
                          Text(
                            "Ingredients",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              children:
                                  meal.ingredients.asMap().entries.map((entry) {
                                int index = entry.key + 1;
                                String step = entry.value;
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    children: [
                                      Text(
                                        '$index',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        step,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground,
                                            ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),

                          const SizedBox(
                            height: 14,
                          ),

                          // Preparation steps
                          Text(
                            "Preparation Steps",
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          Column(
                            children: meal.steps.asMap().entries.map((entry) {
                              int index = entry.key + 1;
                              String step = entry.value;
                              return ListTile(
                                title: Text(
                                  'Step $index',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                subtitle: Text(
                                  step,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
