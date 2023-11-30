import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fud/models/mRecipe/mRecipe.dart';
import 'package:fud/models/recipes/Recipe.dart';
import 'package:fud/data/remote/ApiService.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {


  @override
  MyHomePage createState() => MyHomePage();


}

class MyHomePage extends State<Home> {


  @override
  void initState() {
    super.initState();
    fetchrecipes();
  }

  void fetchrecipes() async
  {
    MRecipe recipe = await ApiService().getrecipes();
    print('recipelengthhaiye${recipe.recipes.length}');
    // try {
    //   Recipe recipe = await ApiService().getrecipes();
    //   print('recipe$recipe');
    // }
    // catch (e) {
    //   print('error $e');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
      (

      appBar: AppBar(
        title: Text('Dio Test'),
      ),
      body: Center(
        child: getrecipesUI()
        ,
      ),

    );
  }
/*
In Flutter, the FutureBuilder widget is used to asynchronously
 build the UI based on the result of a Future.
  It's a convenient way to handle asynchronous operations
   and update your user interface when the data becomes available.
FutureBuilder is a widget that takes two key parameters:
future: This parameter expects a Future object.
 It represents the asynchronous operation whose result you want to use to build the UI.
  In your case, you are calling ApiService().getRecipes() to get a Future that will fetch recipe data.
builder: This parameter is a callback function that takes two arguments, context and snapshot.
 It is called when the Future completes, and its result is available.
 The purpose of this callback is to build the UI based on the state of the Future.
  It's where you define how your UI should look based on whether the Future is still loading,
   has completed successfully, or encountered an error.
*/
  Column getrecipesUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Widget for displaying recipes goes here
        Expanded(
          child: FutureBuilder<MRecipe>(
            future: ApiService().getrecipes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a loading indicator while fetching data
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                // Handle error state
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData) {
                // Handle the case when no data is available
                return Center(
                  child: Text('No recipe data available.'),
                );
              } else {
                // Data is available, display the recipe content
                MRecipe? recipe = snapshot.data;
                log("${snapshot.data}");
                return RecipeWidget(snapshot);  // working :)

              //   return RecipeWidget(recipe as AsyncSnapshot<MRecipe>); // Casting error
              }
            },
          ),
        ),
      ],
    );

  }
  SizedBox RecipeWidget(AsyncSnapshot<MRecipe> snapshot)
  {
    log("total elements"+snapshot.data!.recipes.length.toString());
    return SizedBox(
      child: ListView.builder(
        scrollDirection: Axis.vertical ,
          itemCount: snapshot.data!.recipes.length,
          itemBuilder: (context,index){
            return SizedBox(
              height: 600,
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // Vertically center the icon and text
                      children: [
                        const Icon(
                          Icons.account_circle,
                          // Replace this with the icon you want to use for the profile
                          size: 24,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 8),
                        // Add some spacing between the icon and the text
                        Text(
                          "dfad",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            snapshot.data!.recipes[index].image,
                            height: 600,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                            bottom: 8,
                            left: 8,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.favorite_border,
                                  size: 24,
                                ),
                                onPressed: () {
                                  setState(() {
                                    // Toggle the 'liked' state of the photo
                                   // snapshot.data!.photos[index].liked =
                                    //!snapshot.data!.photos[index].liked;
                                  });
                                },
                              ),
                            )),

                        //download section
                        // Positioned(
                        //     bottom: 8,
                        //     right: 8,
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //         color: Colors.black.withOpacity(0.5),
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       child: IconButton(
                        //         icon: isDownloading
                        //             ? const Icon(
                        //           Icons.download,
                        //           color: Colors.white,
                        //           size: 24,
                        //         )
                        //             : const Icon(
                        //           Icons.downloading,
                        //           color: Colors.white,
                        //           size: 24,
                        //         ),
                        //         onPressed: () {
                        //           isDownloading = true;
                        //           Icons.downloading;
                        //           String url =
                        //               snapshot.data!.photos[index].src.original;
                        //           String fileName =
                        //           snapshot.data!.photos[index].id.toString();
                        //           showDialog(
                        //               context: context,
                        //               builder: (context) =>
                        //                   DownloadingDialog(url, fileName));
                        //         },
                        //       ),
                        //     ))
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

      ),
    );
  }

}