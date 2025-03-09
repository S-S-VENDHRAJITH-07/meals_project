import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/model/category.dart';
import 'package:meals_app/model/meal.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/screens/meal_screen.dart';
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key,required this.availableMeals});
  final List<Meal> availableMeals;
  
  void _selectCategory(BuildContext context,Category category){
    final filteredCategory= availableMeals.where((meals)=> meals.categories.contains(category.id)).toList();

    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>MealScreen(
    title:category.title,
    meals:filteredCategory,
    
    )));
  }
  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: EdgeInsets.all(24),
        gridDelegate:
           const  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3/2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20
              ),
        children:   [
          for(final cat in availableCategories)
            CategoryGridItem(category: cat,onselectMeals: () {
              _selectCategory(context,cat);
            },)
          
        ]  
      );
  }
}
