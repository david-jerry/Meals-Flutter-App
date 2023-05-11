import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.onSelectedPage,
  });

  final void Function(String identifier) onSelectedPage;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 4,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // drawer header
          DrawerHeader(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.black87.withOpacity(0.6)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.food_bank,
                  size: 34,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "Meals Shopper",
                  softWrap: true,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                )
              ],
            ),
          ),

          // add side bard links
          ListTile(
            onTap: () {
              onSelectedPage('meals');
            },
            leading: Icon(
              Icons.restaurant,
              size: 20,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Meals',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
          ListTile(
            onTap: () {
              onSelectedPage('filters');
            },
            leading: Icon(
              Icons.category,
              size: 20,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              'Filter',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
