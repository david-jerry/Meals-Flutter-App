import 'package:flutter/material.dart';
import 'package:meals/screens/category/models/category_model.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem(
      {super.key, required this.category, required this.onSelectedCategory});

  final CategoryModel category;
  final void Function() onSelectedCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectedCategory,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        // set background decoration
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.88)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
