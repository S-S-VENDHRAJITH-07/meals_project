import 'package:flutter/material.dart';

import 'package:meals_app/provider/favourite_provider.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filter.dart';
import 'package:meals_app/screens/meal_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/provider/filters_provider.dart';

const  kInitialFilter={
  Filter.glutenFree:false,
  Filter.lactoseFree:false,
  Filter.vegetarian:false,
  Filter.vegan:false
};
class TabsScreen extends ConsumerStatefulWidget{
 @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen>{
  int _selectedPage=0;
 

  void _selectPage(int index){
    setState(() {
      _selectedPage=index;
    });
  }
  void showInfoMessage(String text){
   
  }
  
  void _setScreen(String identifier)async {
    Navigator.of(context).pop();
    if(identifier=="filter"){
       
      await Navigator.of(context).push<Map<Filter,bool>>(MaterialPageRoute(builder:  (context)=>const FilterScreen()));
     
    }
   

  }
  @override
  Widget build(BuildContext context) {
   
   
    var availableMeals = ref.watch(filteredMealsProvider);
  
    Widget activePage=CategoriesScreen(availableMeals:availableMeals);
    String activePageTitle="Categories";

    if(_selectedPage==1){
       final favouriteMeals=ref.watch(favouriteMealsProvider);
      activePage=MealScreen( meals: favouriteMeals);
      activePageTitle="Your Favourites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      
      ),
      drawer: Drawer(
        child:MainDrawer(onSelectScreen: _setScreen,),
      ),
      body:activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPage,
        items: [
          const BottomNavigationBarItem(icon:  Icon(Icons.set_meal),label: "Categories"),
          const BottomNavigationBarItem(icon:  Icon(Icons.star),label: "Favourites"),

        ]
        ),
      
    );
    
  }
}