import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:giki_tuc/apis/pizzas_api.dart';
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
class Pizzas extends StatefulWidget {
  Pizzas({Key? key}) : super(key: key);

  @override
  PizzasState createState() => PizzasState();
}

class PizzasState extends State<Pizzas> {
  List<int> tempCounter = [];
  bool _initialized = false;
  late Future<Pizza> futurePizzas;

  @override
  void initState() {
    super.initState();
    futurePizzas = fetchPizzas();
  }


  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final darkThemeController = Get.find<DarkThemeController>();
    return FutureBuilder<Pizza>(
        future: futurePizzas,
        builder: (context, snapshot)
        {
          if (snapshot.hasData) {
            cartController.pizzaType = snapshot.data!.items;
            if (!_initialized) {
              for (int i = 0; i < cartController.pizzaType.length; i++) {
                cartController.extraToppings.add([false]);
                cartController.dropdownPizza.add(false);
                cartController.countersPizza.add(0);
                cartController.pizzas.add(0);
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
                      'Pizzas',
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
                        for(int i = 0; i < cartController.pizzaType.length; i++)
                          ListTile(
                            title: AnimatedCrossFade(
                              duration: const Duration(milliseconds: 500),
                              crossFadeState: cartController.dropdownPizza.elementAt(i)
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              firstChild: Column(
                                  mainAxisSize: MainAxisSize.min, children: [
                                ListTile(
                                  leading: Image.network(
                                    cartController.pizzaType[i]['photo_url'],
                                  ),
                                  title: Text(
                                    cartController.pizzaType[i]['name'],
                                    style: TextStyle(
                                        fontFamily: 'Description_Text',
                                        color: darkThemeController.darkMode.value ? Colors.white : Colors
                                            .black),
                                  ),
                                  subtitle: Text(
                                    'Price: Rs.${cartController.pizzaType[i]['price']}/- only',
                                    style: TextStyle(
                                        fontFamily: 'Description_Text',
                                        color: darkThemeController.darkMode.value ? Colors.white : Colors
                                            .black),
                                  ),
                                  trailing: Icon(
                                    cartController.dropdownPizza.elementAt(i)
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
                                    cartController.pizzaType[i]['photo_url'],
                                  ),
                                  title: Text(
                                    cartController.pizzaType[i]['name'],
                                    style: TextStyle(
                                        fontFamily: 'Description_Text',
                                        color: darkThemeController.darkMode.value ? Colors.white : Colors
                                            .black),
                                  ),
                                  subtitle: Text(
                                    'Price: Rs.${cartController.pizzaType[i]['price']}/- only',
                                    style: TextStyle(
                                        fontFamily: 'Description_Text',
                                        color: darkThemeController.darkMode.value ? Colors.white : Colors
                                            .black),
                                  ),
                                  trailing: Icon(
                                    cartController.dropdownPizza.elementAt(i)
                                        ? Icons.arrow_drop_up_outlined
                                        : Icons.arrow_drop_down_outlined,
                                    color: darkThemeController.darkMode.value ? Colors.white : Colors
                                        .black,
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                ),
                                ListTile(
                                  title: Text(
                                    cartController.pizzaType[i]['description'],
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
                                            if (!(cartController.pizzas[i] - 1 < 0)) {
                                              cartController.pizzas[i]--;
                                              cartController.pizzas[i] == 0? cartController.countersPizza[i] = 0: cartController.countersPizza[i] == 0? cartController.countersPizza[i] = 0: cartController.countersPizza[i]--;
                                              cartController.extraToppings.remove(i);
                                              cartController.decrement();
                                              if (cartController.pizzaType[i] == 0) {
                                                cartController.extraToppings[i][cartController.countersPizza[i]] = false;
                                              }
                                            }
                                          });
                                        },
                                        onLongPress: () {
                                          setState(() {
                                            cartController.decrementValue(cartController.pizzas[i]);
                                            cartController.pizzas[i] = 0;
                                            cartController.countersPizza[i] = 0;
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
                                        cartController.pizzas[i].toString(),
                                        style: TextStyle(
                                            fontFamily: 'Description_Text',
                                            color: darkThemeController.darkMode.value
                                                ? Colors.white
                                                : Colors.black),
                                      )),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            cartController.pizzas[i]++;
                                            cartController.increment();
                                            if (cartController.pizzas[i] == 1) {
                                              cartController.countersPizza[i] = 0;
                                              cartController.extraToppings[i][cartController.countersPizza[i]] = false;
                                            }
                                            else{
                                              cartController.extraToppings[i]
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
                                  title: cartController.pizzas[i] > 0 ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                if(cartController.countersPizza[i] == 0)
                                                  cartController.countersPizza[i] = 0;
                                                else
                                                  cartController.countersPizza[i]--;

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
                                          Obx( () => Text('Preference for ${cartController.countersPizza[i]+1}',
                                            style: TextStyle(
                                                fontFamily: 'Description_Text',
                                                color:
                                                darkThemeController.darkMode.value ? Colors.white : Colors
                                                    .black),)),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                if(cartController.countersPizza[i] >= cartController.pizzas[i] - 1)
                                                  cartController.countersPizza[i] = cartController.pizzas[i] - 1;
                                                else
                                                  cartController.countersPizza[i]++;
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
                                              value: cartController.extraToppings[i][cartController.countersPizza[i]],
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  cartController.extraToppings[i][cartController.countersPizza[i]] = value!;
                                                  print(cartController.extraToppings);
                                                });
                                              }),
                                          Text('Extra Toppings\t +Rs.30/-',
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
                                cartController.dropdownPizza[i] = !cartController.dropdownPizza.elementAt(i);
                                for (int j = 0; j < cartController.dropdownPizza.length; j++)
                                  if (j != i)
                                    cartController.dropdownPizza[j] = false;
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

