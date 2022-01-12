
import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:giki_tuc/apis/ice_creams_api.dart';
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
class IceCreams extends StatefulWidget {
  IceCreams({Key? key}) : super(key: key);

  @override
  IceCreamsState createState() => IceCreamsState();
}

class IceCreamsState extends State<IceCreams> {
  List<int> tempCounter = [];
  bool _initialized = false;
  late Future<IceCream> futureIceCreams;

  @override
  void initState() {
    super.initState();
    futureIceCreams = fetchIceCreams();
  }


  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final darkThemeController = Get.find<DarkThemeController>();
    return FutureBuilder<IceCream>(
        future: futureIceCreams,
        builder: (context, snapshot)
        {
          if (snapshot.hasData) {
            cartController.iceCreamType = snapshot.data!.items;
            if (!_initialized) {
              for (int i = 0; i < cartController.iceCreamType.length; i++) {
                //cartController.cheese.add([false]);
                cartController.dropdownIceCream.add(false);
                cartController.countersIceCream.add(0);
                cartController.iceCreams.add(0);
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
                      'IceCreams',
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
                        for(int i = 0; i < cartController.iceCreamType.length; i++)
                          ListTile(
                            title: AnimatedCrossFade(
                              duration: const Duration(milliseconds: 500),
                              crossFadeState: cartController.dropdownIceCream.elementAt(i)
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              firstChild: Column(
                                  mainAxisSize: MainAxisSize.min, children: [
                                ListTile(
                                  leading: Image.network(
                                    cartController.iceCreamType[i]['photo_url'],
                                  ),
                                  title: Text(
                                    cartController.iceCreamType[i]['name'],
                                    style: TextStyle(
                                        fontFamily: 'Description_Text',
                                        color: darkThemeController.darkMode.value ? Colors.white : Colors
                                            .black),
                                  ),
                                  subtitle: Text(
                                    'Price: Rs.${cartController.iceCreamType[i]['price']}/- only',
                                    style: TextStyle(
                                        fontFamily: 'Description_Text',
                                        color: darkThemeController.darkMode.value ? Colors.white : Colors
                                            .black),
                                  ),
                                  trailing: Icon(
                                    cartController.dropdownIceCream.elementAt(i)
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
                                    cartController.iceCreamType[i]['photo_url'],
                                  ),
                                  title: Text(
                                    cartController.iceCreamType[i]['name'],
                                    style: TextStyle(
                                        fontFamily: 'Description_Text',
                                        color: darkThemeController.darkMode.value ? Colors.white : Colors
                                            .black),
                                  ),
                                  subtitle: Text(
                                    'Price: Rs.${cartController.iceCreamType[i]['price']}/- only',
                                    style: TextStyle(
                                        fontFamily: 'Description_Text',
                                        color: darkThemeController.darkMode.value ? Colors.white : Colors
                                            .black),
                                  ),
                                  trailing: Icon(
                                    cartController.dropdownIceCream.elementAt(i)
                                        ? Icons.arrow_drop_up_outlined
                                        : Icons.arrow_drop_down_outlined,
                                    color: darkThemeController.darkMode.value ? Colors.white : Colors
                                        .black,
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                ),
                                ListTile(
                                  title: Text(
                                    cartController.iceCreamType[i]['description'],
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
                                            if (!(cartController.iceCreams[i] - 1 < 0)) {
                                              cartController.iceCreams[i]--;
                                              cartController.iceCreams[i] == 0? cartController.countersIceCream[i] = 0: cartController.countersIceCream[i] == 0? cartController.countersIceCream[i] = 0: cartController.countersIceCream[i]--;
                                             // cartController.cheese.remove(i);
                                              cartController.decrement();
                                              if (cartController.iceCreamType[i] == 0) {
                                                //cartController.cheese[i][cartController.countersIceCream[i]] = false;
                                              }
                                            }
                                          });
                                        },
                                        onLongPress: () {
                                          setState(() {
                                            cartController.decrementValue(cartController.iceCreams[i]);
                                            cartController.iceCreams[i] = 0;
                                            cartController.countersIceCream[i] = 0;
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
                                        cartController.iceCreams[i].toString(),
                                        style: TextStyle(
                                            fontFamily: 'Description_Text',
                                            color: darkThemeController.darkMode.value
                                                ? Colors.white
                                                : Colors.black),
                                      )),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            cartController.iceCreams[i]++;
                                            cartController.increment();
                                            if (cartController.iceCreams[i] == 1) {
                                              cartController.countersIceCream[i] = 0;
                                              //cartController.cheese[i][cartController.countersIceCream[i]] = false;
                                            }
                                            else{
                                             // cartController.cheese[i].add(false);
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
                                  title: cartController.iceCreams[i] > 0 ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                if(cartController.countersIceCream[i] == 0)
                                                  cartController.countersIceCream[i] = 0;
                                                else
                                                  cartController.countersIceCream[i]--;

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
                                          Obx( () => Text('Preference for ${cartController.countersIceCream[i]+1}',
                                            style: TextStyle(
                                                fontFamily: 'Description_Text',
                                                color:
                                                darkThemeController.darkMode.value ? Colors.white : Colors
                                                    .black),)),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                if(cartController.countersIceCream[i] >= cartController.iceCreams[i] - 1)
                                                  cartController.countersIceCream[i] = cartController.iceCreams[i] - 1;
                                                else
                                                  cartController.countersIceCream[i]++;
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
                                      /*Row(
                                        children: [
                                          Checkbox(
                                              checkColor: Colors.white,
                                              fillColor:
                                              MaterialStateProperty.resolveWith(
                                                  getColor),
                                              value: cartController.cheese[i][cartController.countersIceCream[i]],
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  cartController.cheese[i][cartController.countersIceCream[i]] = value!;
                                                  print(cartController.cheese);
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
                                      ),*/
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
                                cartController.dropdownIceCream[i] = !cartController.dropdownIceCream.elementAt(i);
                                for (int j = 0; j < cartController.dropdownIceCream.length; j++)
                                  if (j != i)
                                    cartController.dropdownIceCream[j] = false;
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

