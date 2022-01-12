
import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:giki_tuc/apis/roll_parathas_api.dart';
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
class RollParathas extends StatefulWidget {
  RollParathas({Key? key}) : super(key: key);

  @override
  RollParathasState createState() => RollParathasState();
}

class RollParathasState extends State<RollParathas> {
  List<int> tempCounter = [];
  bool _initialized = false;
  late Future<RollParatha> futureRollParathas;

  @override
  void initState() {
    super.initState();
    futureRollParathas = fetchRollParathas();
  }


  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final darkThemeController = Get.find<DarkThemeController>();
    return FutureBuilder<RollParatha>(
        future: futureRollParathas,
        builder: (context, snapshot)
        {
          if (snapshot.hasData) {
            cartController.rollParathaType = snapshot.data!.items;
            if (!_initialized) {
              for (int i = 0; i < cartController.rollParathaType.length; i++) {
                cartController.cheeseRollParatha.add([false]);
                cartController.friesRollParatha.add([false]);
                cartController.dropdownRollParatha.add(false);
                cartController.countersRollParatha.add(0);
                cartController.rollParathas.add(0);
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
                      'RollParathas',
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
                        for(int i = 0; i < cartController.rollParathaType.length; i++)
                          ListTile(
                            title: AnimatedCrossFade(
                              duration: const Duration(milliseconds: 500),
                              crossFadeState: cartController.dropdownRollParatha.elementAt(i)
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              firstChild: Column(
                                  mainAxisSize: MainAxisSize.min, children: [
                                ListTile(
                                  leading: Image.network(
                                    cartController.rollParathaType[i]['photo_url'],
                                  ),
                                  title: Text(
                                    cartController.rollParathaType[i]['name'],
                                    style: TextStyle(
                                        fontFamily: 'Description_Text',
                                        color: darkThemeController.darkMode.value ? Colors.white : Colors
                                            .black),
                                  ),
                                  subtitle: Text(
                                    'Price: Rs.${cartController.rollParathaType[i]['price']}/- only',
                                    style: TextStyle(
                                        fontFamily: 'Description_Text',
                                        color: darkThemeController.darkMode.value ? Colors.white : Colors
                                            .black),
                                  ),
                                  trailing: Icon(
                                    cartController.dropdownRollParatha.elementAt(i)
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
                                    cartController.rollParathaType[i]['photo_url'],
                                  ),
                                  title: Text(
                                    cartController.rollParathaType[i]['name'],
                                    style: TextStyle(
                                        fontFamily: 'Description_Text',
                                        color: darkThemeController.darkMode.value ? Colors.white : Colors
                                            .black),
                                  ),
                                  subtitle: Text(
                                    'Price: Rs.${cartController.rollParathaType[i]['price']}/- only',
                                    style: TextStyle(
                                        fontFamily: 'Description_Text',
                                        color: darkThemeController.darkMode.value ? Colors.white : Colors
                                            .black),
                                  ),
                                  trailing: Icon(
                                    cartController.dropdownRollParatha.elementAt(i)
                                        ? Icons.arrow_drop_up_outlined
                                        : Icons.arrow_drop_down_outlined,
                                    color: darkThemeController.darkMode.value ? Colors.white : Colors
                                        .black,
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                ),
                                ListTile(
                                  title: Text(
                                    cartController.rollParathaType[i]['description'],
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
                                            if (!(cartController.rollParathas[i] - 1 < 0)) {
                                              cartController.rollParathas[i]--;
                                              cartController.rollParathas[i] == 0? cartController.countersRollParatha[i] = 0: cartController.countersRollParatha[i] == 0? cartController.countersRollParatha[i] = 0: cartController.countersRollParatha[i]--;
                                              cartController.cheeseRollParatha.remove(i);
                                              cartController.friesRollParatha.remove(i);
                                              cartController.decrement();
                                              if (cartController.rollParathaType[i] == 0) {
                                                cartController.cheeseRollParatha[i][cartController.countersRollParatha[i]] = false;
                                                cartController.friesRollParatha[i][cartController.countersRollParatha[i]] = false;
                                              }
                                            }
                                          });
                                        },
                                        onLongPress: () {
                                          setState(() {
                                            cartController.decrementValue(cartController.rollParathas[i]);
                                            cartController.rollParathas[i] = 0;
                                            cartController.countersRollParatha[i] = 0;
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
                                        cartController.rollParathas[i].toString(),
                                        style: TextStyle(
                                            fontFamily: 'Description_Text',
                                            color: darkThemeController.darkMode.value
                                                ? Colors.white
                                                : Colors.black),
                                      )),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            cartController.rollParathas[i]++;
                                            cartController.increment();
                                            if (cartController.rollParathas[i] == 1) {
                                              cartController.countersRollParatha[i] = 0;
                                              cartController.cheeseRollParatha[i][cartController.countersRollParatha[i]] = false;
                                              cartController.friesRollParatha[i][cartController.countersRollParatha[i]] = false;
                                            }
                                            else{
                                              cartController.cheeseRollParatha[i]
                                                  .add(false);
                                              cartController.friesRollParatha[i]
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
                                  title: cartController.rollParathas[i] > 0 ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                if(cartController.countersRollParatha[i] == 0)
                                                  cartController.countersRollParatha[i] = 0;
                                                else
                                                  cartController.countersRollParatha[i]--;

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
                                          Obx( () => Text('Preference for ${cartController.countersRollParatha[i]+1}',
                                            style: TextStyle(
                                                fontFamily: 'Description_Text',
                                                color:
                                                darkThemeController.darkMode.value ? Colors.white : Colors
                                                    .black),)),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                if(cartController.countersRollParatha[i] >= cartController.rollParathas[i] - 1)
                                                  cartController.countersRollParatha[i] = cartController.rollParathas[i] - 1;
                                                else
                                                  cartController.countersRollParatha[i]++;
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
                                              value: cartController.cheeseRollParatha[i][cartController.countersRollParatha[i]],
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  cartController.cheeseRollParatha[i][cartController.countersRollParatha[i]] = value!;
                                                  print(cartController.cheeseRollParatha);
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
                                              value: cartController.friesRollParatha[i][cartController.countersRollParatha[i]],
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  cartController.friesRollParatha[i][cartController.countersRollParatha[i]] = value!;
                                                  print(cartController.friesRollParatha);
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
                                cartController.dropdownRollParatha[i] = !cartController.dropdownRollParatha.elementAt(i);
                                for (int j = 0; j < cartController.dropdownRollParatha.length; j++)
                                  if (j != i)
                                    cartController.dropdownRollParatha[j] = false;
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

