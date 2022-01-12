
import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:giki_tuc/apis/sandwiches_api.dart';
import 'package:giki_tuc/controllers/cart_controller.dart';
import 'package:giki_tuc/controllers/dark_theme_controller.dart';
import 'package:page_transition/page_transition.dart';
import '../../cart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


// Functions
Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return Colors.green;
}
class Sandwiches extends StatefulWidget {
  Sandwiches({Key? key}) : super(key: key);

  @override
  SandwichesState createState() => SandwichesState();
}

class SandwichesState extends State<Sandwiches> {
  List<int> tempCounter = [];
  bool _initialized = false;
  late Future<Sandwich> futureSandwiches;

  @override
  void initState() {
    super.initState();
    futureSandwiches = fetchSandwiches();
  }


  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final darkThemeController = Get.find<DarkThemeController>();
    return FutureBuilder<Sandwich>(
        future: futureSandwiches,
        builder: (context, snapshot)
        {
          if (snapshot.hasData) {
            cartController.sandwichType = snapshot.data!.items;
            if (!_initialized) {
              for (int i = 0; i < cartController.sandwichType.length; i++) {
                cartController.cheeseSandwich.add([false]);
                cartController.friesSandwich.add([false]);
                cartController.dropdownSandwich.add(false);
                cartController.countersSandwich.add(0);
                cartController.sandwiches.add(0);
                _initialized = true;
              }
            }
            return WillPopScope(
              onWillPop: () async => false,
              child: Obx(() => Scaffold(
                  backgroundColor: darkThemeController.darkMode.value ? Colors.black : Colors.white,
                  appBar: AppBar(
                    leading: IconButton(
                      icon: Icon(
                          Icons.arrow_back
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    iconTheme: const IconThemeData(color: Colors.green),
                    // shadowColor: Colors.grey[500],
                    elevation: 0.5,
                    shadowColor: darkThemeController.darkMode.value ? Colors.white : Colors.black,
                    title: Text(
                      'Sandwiches',
                      style: TextStyle(
                          fontFamily: 'Headings',
                          color: darkThemeController.darkMode.value ? Colors.white : Colors.black),
                    ),
                    actions: [
                      IconButton(
                        tooltip: 'Dark Mode',
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            darkThemeController.darkMode.value = !darkThemeController.darkMode.value;
                          });
                        },
                        icon: Icon(
                          darkThemeController.darkMode.value ? Icons.wb_sunny_outlined : Icons.wb_sunny,
                          color: darkThemeController.darkMode.value ? Colors.white : Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Badge(
                          badgeContent: Obx( () => Text(cartController.total_items.value.toString())),
                          position: BadgePosition.topEnd(end: 0),
                          elevation: 0,
                          child: IconButton(
                            icon: Icon(
                              Icons.shopping_cart_outlined,),
                            onPressed: () {
                              Navigator.push(context,
                                  PageTransition(
                                      child: Cart(), type: PageTransitionType.fade));
                            },),
                        ),
                      )
                    ],
                    centerTitle: true,
                    backgroundColor: darkThemeController.darkMode.value ? Colors.black : Colors.white,
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        for(int i = 0; i < cartController.sandwichType.length; i++)
                          ListTile(
                            title: AnimatedCrossFade(
                              duration: const Duration(milliseconds: 500),
                              crossFadeState: cartController.dropdownSandwich.elementAt(i)
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              firstChild: Column(
                                  mainAxisSize: MainAxisSize.min, children: [
                                ListTile(
                                  leading: Image.network(
                                    cartController.sandwichType[i]['photo_url'],
                                  ),
                                  title: Text(
                                    cartController.sandwichType[i]['name'],
                                    style: TextStyle(
                                        fontFamily: 'Description_Text',
                                        color: darkThemeController.darkMode.value ? Colors.white : Colors
                                            .black),
                                  ),
                                  subtitle: Text(
                                    'Price: Rs.${cartController.sandwichType[i]['price']}/- only',
                                    style: TextStyle(
                                        fontFamily: 'Description_Text',
                                        color: darkThemeController.darkMode.value ? Colors.white : Colors
                                            .black),
                                  ),
                                  trailing: Icon(
                                    cartController.dropdownSandwich.elementAt(i)
                                        ? Icons.arrow_drop_up_outlined
                                        : Icons.arrow_drop_down_outlined,
                                    color: darkThemeController.darkMode.value ? Colors.white : Colors
                                        .black,
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ]),
                              secondChild:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                                ListTile(
                                  leading: Image.network(
                                    cartController.sandwichType[i]['photo_url'],
                                  ),
                                  title: Text(
                                    cartController.sandwichType[i]['name'],
                                    style: TextStyle(
                                        fontFamily: 'Description_Text',
                                        color: darkThemeController.darkMode.value ? Colors.white : Colors
                                            .black),
                                  ),
                                  subtitle: Text(
                                    'Price: Rs.${cartController.sandwichType[i]['price']}/- only',
                                    style: TextStyle(
                                        fontFamily: 'Description_Text',
                                        color: darkThemeController.darkMode.value ? Colors.white : Colors
                                            .black),
                                  ),
                                  trailing: Icon(
                                    cartController.dropdownSandwich.elementAt(i)
                                        ? Icons.arrow_drop_up_outlined
                                        : Icons.arrow_drop_down_outlined,
                                    color: darkThemeController.darkMode.value ? Colors.white : Colors
                                        .black,
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                ),
                                ListTile(
                                  title: Text(
                                    cartController.sandwichType[i]['description'],
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        fontFamily: 'Description_Text',
                                        color: darkThemeController.darkMode.value ? Colors.white : Colors
                                            .black),
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceAround,
                                    children: [
                                      Text(
                                        'Add to Cart',
                                        style: TextStyle(
                                            fontFamily: 'Description_Text',
                                            color: darkThemeController.darkMode.value
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            if (!(cartController.sandwiches[i] - 1 < 0)) {
                                              cartController.sandwiches[i]--;
                                              cartController.sandwiches[i] == 0? cartController.countersSandwich[i] = 0: cartController.countersSandwich[i] == 0? cartController.countersSandwich[i] = 0: cartController.countersSandwich[i]--;
                                              cartController.cheeseSandwich.remove(i);
                                              cartController.friesSandwich.remove(i);
                                              cartController.decrement();
                                              if (cartController.sandwichType[i] == 0) {
                                                cartController.cheeseSandwich[i][cartController.countersSandwich[i]] = false;
                                                cartController.friesSandwich[i][cartController.countersSandwich[i]] = false;
                                              }
                                            }
                                          });
                                        },
                                        onLongPress: () {
                                          setState(() {
                                            cartController.decrementValue(cartController.sandwiches[i]);
                                            cartController.sandwiches[i] = 0;
                                            cartController.countersSandwich[i] = 0;
                                          });
                                        },
                                        child: Text(
                                          '-',
                                          style: TextStyle(
                                              fontFamily: 'Description_Text',
                                              color:
                                              darkThemeController.darkMode.value ? Colors.white : Colors
                                                  .black),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary:
                                            darkThemeController.darkMode.value ? Colors.black : Colors
                                                .white),
                                      ),
                                      Obx( () =>Text(
                                        cartController.sandwiches[i].toString(),
                                        style: TextStyle(
                                            fontFamily: 'Description_Text',
                                            color: darkThemeController.darkMode.value
                                                ? Colors.white
                                                : Colors.black),
                                      )),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            cartController.sandwiches[i]++;
                                            cartController.increment();
                                            if (cartController.sandwiches[i] == 1) {
                                              cartController.countersSandwich[i] = 0;
                                              cartController.cheeseSandwich[i][cartController.countersSandwich[i]] = false;
                                              cartController.friesSandwich[i][cartController.countersSandwich[i]] = false;
                                            }
                                            else{
                                              cartController.cheeseSandwich[i]
                                                  .add(false);
                                              cartController.friesSandwich[i]
                                                  .add(false);
                                            }
                                          });
                                        },
                                        child: Text(
                                          '+',
                                          style: TextStyle(
                                              fontFamily: 'Description_Text',
                                              color:
                                              darkThemeController.darkMode.value ? Colors.white : Colors
                                                  .black),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary:
                                            darkThemeController.darkMode.value ? Colors.black : Colors
                                                .white),
                                      ),
                                    ],
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                ),
                                ListTile(
                                  title: cartController.sandwiches[i] > 0 ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                if(cartController.countersSandwich[i] == 0)
                                                  cartController.countersSandwich[i] = 0;
                                                else
                                                  cartController.countersSandwich[i]--;

                                              });

                                            },
                                            child: Icon(
                                                Icons.arrow_left_outlined,
                                                color: darkThemeController.darkMode.value ? Colors.white : Colors.black
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                primary:
                                                darkThemeController.darkMode.value ? Colors.black : Colors
                                                    .white),
                                          ),
                                          Obx( () => Text('Preference for ${cartController.countersSandwich[i]+1}',
                                            style: TextStyle(
                                                fontFamily: 'Description_Text',
                                                color:
                                                darkThemeController.darkMode.value ? Colors.white : Colors
                                                    .black),)),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                if(cartController.countersSandwich[i] >= cartController.sandwiches[i] - 1)
                                                  cartController.countersSandwich[i] = cartController.sandwiches[i] - 1;
                                                else
                                                  cartController.countersSandwich[i]++;
                                              });

                                            },
                                            child: Icon(
                                                Icons.arrow_right_outlined,
                                                color: darkThemeController.darkMode.value ? Colors.white : Colors.black
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                primary:
                                                darkThemeController.darkMode.value ? Colors.black : Colors
                                                    .white),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Checkbox(
                                              checkColor: Colors.white,
                                              fillColor:
                                              MaterialStateProperty.resolveWith(
                                                  getColor),
                                              value: cartController.cheeseSandwich[i][cartController.countersSandwich[i]],
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  cartController.cheeseSandwich[i][cartController.countersSandwich[i]] = value!;
                                                  print(cartController.cheeseSandwich);
                                                });
                                              }),
                                          Text('Cheese\t +Rs.30/-',
                                            style: TextStyle(
                                                fontFamily: 'Description_Text',
                                                color:
                                                darkThemeController.darkMode.value ? Colors.white : Colors
                                                    .black),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Checkbox(
                                              checkColor: Colors.white,
                                              fillColor:
                                              MaterialStateProperty.resolveWith(
                                                  getColor),
                                              value: cartController.friesSandwich[i][cartController.countersSandwich[i]],
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  cartController.friesSandwich[i][cartController.countersSandwich[i]] = value!;
                                                  print(cartController.friesSandwich);
                                                });
                                              }),
                                          Text('Fries\t +Rs.50/-',
                                            style: TextStyle(
                                                fontFamily: 'Description_Text',
                                                color:
                                                darkThemeController.darkMode.value ? Colors.white : Colors
                                                    .black),
                                          )
                                        ],
                                      ),
                                    ],
                                  ) : SizedBox(),
                                  contentPadding: EdgeInsets.zero,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ]),
                            ),
                            onTap: () {
                              setState(() {
                                cartController.dropdownSandwich[i] = !cartController.dropdownSandwich.elementAt(i);
                                for (int j = 0; j < cartController.dropdownSandwich.length; j++)
                                  if (j != i)
                                    cartController.dropdownSandwich[j] = false;
                              });
                            },
                          )
                      ],
                    ),
                  ))),
            );
          }
          else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          // By default, show a loading spinner.
          return SpinKitThreeBounce(
            color: darkThemeController.darkMode.value? Colors.white:Colors.black,
            size: 40.0,
          );
        }
    );
  }
}

