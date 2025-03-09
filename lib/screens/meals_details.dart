import 'package:flutter/material.dart';

import 'package:meals_app/model/meal.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/favourite_provider.dart';

class MealsDetails extends ConsumerWidget{
  const MealsDetails({super.key,required this.meal});
  
  final Meal meal;
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final isFavorite = ref.watch(favouriteMealsProvider).contains(meal);
   return Scaffold(
    appBar: AppBar(
      title: Text(meal.title),
      actions: [
        IconButton(onPressed: (){
            final wasAdded=ref.read(favouriteMealsProvider.notifier).toggleFavourite(meal);
            ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(wasAdded?'Added to favourites':'Removed from favourites'),
      )
    );
        }, 
        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border)),
      ],
    ),
    
    body: SingleChildScrollView(
      child: Column(
        children: [
          Image.network(meal.imageUrl,
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,),
          const SizedBox(height: 14,),
          
          Text("Ingredients",style:Theme.of(context).textTheme.titleLarge!.copyWith(
            color:Theme.of(context).colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),),
          const SizedBox(height: 15,),
          for(final ingredients in meal.ingredients)
          Text(ingredients,
          style:Theme.of(context).textTheme.bodyMedium!.copyWith(
            color:Theme.of(context).colorScheme.onSurface
           )),
           const SizedBox(height: 25,),
      
            Text("Steps",style:Theme.of(context).textTheme.titleLarge!.copyWith(
            color:Theme.of(context).colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),),
          const SizedBox(height: 15,),
          for(final step in meal.steps)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
            child: Text(step,
            
            textAlign: TextAlign.center,
            style:Theme.of(context).textTheme.bodyMedium!.copyWith(
              color:Theme.of(context).colorScheme.onSurface,
             
             )),
          ),
      
        ],
      ),
    ),
    );
   
    
  }
}