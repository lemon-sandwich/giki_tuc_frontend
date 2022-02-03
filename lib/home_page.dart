
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giki_tuc/controllers/dark_theme_controller.dart';
import 'package:giki_tuc/services/search_bar.dart';
import 'package:giki_tuc/user_data/orders.dart';
import 'package:giki_tuc/user_data/profile.dart';
import 'package:page_transition/page_transition.dart';
import 'cart.dart';
import 'categories/burgers.dart';
import 'categories/fries.dart';
import 'categories/ice_creams.dart';
import 'categories/pizzas.dart';
import 'categories/roll_parathas.dart';
import 'categories/sandwiches.dart';
import 'controllers/cart_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  double containerHeight = 50;
  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final darkThemeController = Get.find<DarkThemeController>();
    return SafeArea(
      child: Obx(() => Scaffold(
          backgroundColor: darkThemeController.darkMode.value? Colors.black: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.green),
         // shadowColor: Colors.grey[500],
          elevation: 0.5,
          shadowColor: darkThemeController.darkMode.value? Colors.white: Colors.black,
          title: Text('Home',
        style: TextStyle(
          fontFamily: 'Headings',
          color: darkThemeController.darkMode.value? Colors.white : Colors.black
        ),),
        actions: [
          IconButton(
            tooltip: 'Dark Mode',
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            onPressed: () {
              setState(()
              {
                darkThemeController.darkMode.value = !darkThemeController.darkMode.value;
              });
            },
            icon: Icon(
                darkThemeController.darkMode.value? Icons.wb_sunny_outlined: Icons.wb_sunny,
              color: darkThemeController.darkMode.value? Colors.white : Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Badge(
              badgeContent: Text(cartController.total_items.toString()),
              position: BadgePosition.topEnd(end: 0),
              elevation: 0,
              child: IconButton(icon: Icon(
                Icons.shopping_cart_outlined,),
                onPressed: () {
                  /*Navigator.push(context,
                      PageTransition(child: Cart(), type: PageTransitionType.fade)).
                  then((value) => null);*/
                  Get.to(()=> Cart(),transition: Transition.fade);
                },),
            ),
          )

        ],
        centerTitle: true,
          backgroundColor: darkThemeController.darkMode.value? Colors.black: Colors.white,
        ),
          drawer: Drawer(
            elevation: 100,
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: Container(
              color: darkThemeController.darkMode.value? Colors.black: Colors.white,
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.home,
                            color: darkThemeController.darkMode.value? Colors.white: Colors.black,
                          ),
                          const SizedBox(width: 5,),
                          Text('Home'.toUpperCase(),
                          style: TextStyle(
                              color: darkThemeController.darkMode.value? Colors.white: Colors.black,
                          ),),
                        ],
                      ),
                      onTap: () {
                        Get.back();
                      },
                    ),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image(
                              image: const AssetImage('images/cuisine.png'),
                            color: darkThemeController.darkMode.value? Colors.white: Colors.black,
                            height: 25,
                          ),
                          const SizedBox(width: 5,),
                          Text('Cuisines'.toUpperCase(),
                            style: TextStyle(
                              color: darkThemeController.darkMode.value? Colors.white: Colors.black,
                            ),),
                        ],
                      ),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                      },
                    ),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                              Icons.search,
                            color: darkThemeController.darkMode.value? Colors.white: Colors.black,
                          ),
                          const SizedBox(width: 5,),
                          Text('Search'.toUpperCase(),
                            style: TextStyle(
                              color: darkThemeController.darkMode.value? Colors.white: Colors.black,
                            ),),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          //Navigator.pop(context);
                          Get.back();
                          showSearch(context: context, delegate: DataSearch());/*
                          Navigator.push(context,
                              PageTransition(child: SearchBar(), type: PageTransitionType.fade));*/
                        });
                      },
                    ),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                              Icons.shopping_cart_outlined,
                            color: darkThemeController.darkMode.value? Colors.white: Colors.black,
                          ),
                          const SizedBox(width: 5,),
                          Text('Cart'.toUpperCase(),
                            style: TextStyle(
                              color: darkThemeController.darkMode.value? Colors.white: Colors.black,
                            ),),
                        ],
                      ),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                      },
                    ),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                              Icons.account_circle_rounded,
                            color: darkThemeController.darkMode.value? Colors.white: Colors.black,
                          ),
                          const SizedBox(width: 5,),
                          Text('Profile'.toUpperCase(),
                            style: TextStyle(
                              color: darkThemeController.darkMode.value? Colors.white: Colors.black,
                            ),),
                        ],
                      ),
                      onTap: () {
                        /*Navigator.push(context,
                            PageTransition(child: Profile(), type: PageTransitionType.fade));*/
                        Get.to(()=> Profile(),transition: Transition.fade);
                      },
                    ),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image(
                              image: const AssetImage('images/cargo.png'),
                            height: 25,
                            color: darkThemeController.darkMode.value? Colors.white: Colors.black,
                          ),
                          const SizedBox(width: 5,),
                          Text('Orders'.toUpperCase(),
                            style: TextStyle(
                              color: darkThemeController.darkMode.value? Colors.white: Colors.black,
                            ),),
                        ],
                      ),
                      onTap: () {
                        /*Navigator.push(context,
                            PageTransition(child: Orders(), type: PageTransitionType.fade));*/
                        Get.to(()=> Orders(),transition: Transition.fade);
                      },
                    ),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                              Icons.logout_outlined,
                            color: darkThemeController.darkMode.value? Colors.white: Colors.black,
                          ),
                          const SizedBox(width: 5,),
                          Text('LogOut'.toUpperCase(),
                            style: TextStyle(
                              color: darkThemeController.darkMode.value? Colors.white: Colors.black,
                            ),),
                        ],
                      ),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10,top: 10,bottom:20,right:10),
          child: ListView(
            children: [
              Text('Categories',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Headings',
                  color: darkThemeController.darkMode.value? Colors.white: Colors.black,
                ),
              ),
              SizedBox(
                height: 150,
                child: ListView(
                  // This next line does the trick.
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(10),
                  children: <Widget>[

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              Navigator.push(context,
                              PageTransition(child: Burgers(), type: PageTransitionType.fade));
                              /*Get.to(()=> Burgers(),transition: Transition.fade);*/
                              //setState((){});
                            },
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  height: 70,
                                  width: 70,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage('https://twisper.com/wp-content/uploads/2020/03/close-up-photo-of-burger-3915906-scaled.jpg'),
                                        fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Text('Burgers',
                                  style : TextStyle(
                                    fontFamily: 'Headings',
                                        fontSize: 20,
                                    color: darkThemeController.darkMode.value? Colors.white: Colors.black,
                                  )
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              /*Navigator.push(context,
                                  PageTransition(child: const Pizzas(),type: PageTransitionType.fade));*/
                              Get.to(()=> Pizzas(),transition: Transition.fade);
                            },
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  height: 70,
                                  width: 70,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage('https://www.kingarthurbaking.com/sites/default/files/styles/featured_image/public/2020-01/crispy-cheesy-pan-pizza.jpg?itok=_yKBfQnU'),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Text('Pizzas',
                                    style : TextStyle(
                                      fontFamily: 'Headings',
                                      fontSize: 20,
                                      color: darkThemeController.darkMode.value? Colors.white: Colors.black,
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              /*Navigator.push(context,
                                  PageTransition(child: const Sandwiches(), type: PageTransitionType.fade));*/
                              Get.to(()=> Sandwiches(),transition: Transition.fade);
                            },
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  height: 70,
                                  width: 70,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage('https://www.mirchitales.com/wp-content/uploads/2021/04/Chicken-Club-Sandwich-Featured-Image-2.jpg'),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Text('Sandwiches',
                                    style : TextStyle(
                                      fontFamily: 'Headings',
                                      fontSize: 20,
                                      color: darkThemeController.darkMode.value? Colors.white: Colors.black,
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              /*Navigator.push(context,
                                  PageTransition(child: const IceCreams(), type: PageTransitionType.fade));*/
                              Get.to(()=> IceCreams(),transition: Transition.fade);
                            },
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  height: 70,
                                  width: 70,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage('https://media.istockphoto.com/photos/colorful-ice-cream-scoops-background-picture-id920706624?k=20&m=920706624&s=170667a&w=0&h=Y2zDbBQgqqlsH_fNaJ3MwoIYCU2e9Mu2QqE0ZhuoQJU='),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Text('Ice Creams',
                                    style : TextStyle(
                                      fontFamily: 'Headings',
                                      fontSize: 20,
                                      color: darkThemeController.darkMode.value? Colors.white: Colors.black,
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              /*Navigator.push(context,
                                  PageTransition(child: const RollParathas(), type: PageTransitionType.fade));*/
                              Get.to(()=> RollParathas(),transition: Transition.fade);
                            },
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  height: 70,
                                  width: 70,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage('http://1.bp.blogspot.com/-R-sdT38R5cI/TjndoHxz-BI/AAAAAAAAAAM/g6zs4ZVf6f8/s1600/paratha%255B1%255D.jpg'),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Text('Roll Paratha',
                                    style : TextStyle(
                                      fontFamily: 'Headings',
                                      fontSize: 20,
                                      color: darkThemeController.darkMode.value? Colors.white: Colors.black,
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              /*Navigator.push(context,
                                  PageTransition(child: const Fries(), type: PageTransitionType.fade));*/
                              Get.to(()=> Fries(),transition: Transition.fade);
                            },
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  height: 70,
                                  width: 70,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage('https://recipe30.com/wp-content/uploads/2017/06/French-fries.jpg'),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Text('Fries',
                                    style : TextStyle(
                                      fontFamily: 'Headings',
                                      fontSize: 20,
                                      color: darkThemeController.darkMode.value? Colors.white: Colors.black,
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),


                  ],
                ),
              ),
              Text('Best Deals',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Headings',
                  color: darkThemeController.darkMode.value? Colors.white: Colors.black,
                ),
              ),
              Container(
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://twisper.com/wp-content/uploads/2020/03/close-up-photo-of-burger-3915906-scaled.jpg'),
                      fit: BoxFit.cover,
                    ),
              ),
              )

            ],
          ),
        )


      )),
    );
  }
}
