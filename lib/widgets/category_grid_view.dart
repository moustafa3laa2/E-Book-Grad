import 'package:bookstore/views/selected_category.dart';
import 'package:bookstore/widgets/category_card.dart';
import 'package:flutter/material.dart';

class CategoryGridView extends StatelessWidget {
  const CategoryGridView({
    super.key,
    required this.categoryItems,
    required this.getLocalizedCategoryItems,
  });

  final List<String> categoryItems;
  final List<String> getLocalizedCategoryItems;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: categoryItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
        itemBuilder: (context, index) {
          return SizedBox(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => SelectedCategory(
                      categoryName: categoryItems[index],
                      getLocalizedCategoryItems:
                      getLocalizedCategoryItems[index],
                    ),
                  ),
                );
              },
              child: CategoryCard(
                title: getLocalizedCategoryItems[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
