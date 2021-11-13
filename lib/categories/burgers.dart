import 'dart:convert';
import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:giki_tuc/apis/burgers_api.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import '../../cart.dart';
import '../../home_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../home_page.dart';

class Burgers extends StatefulWidget {
  Burgers({Key? key}) : super(key: key);

  @override
  _BurgersState createState() => _BurgersState();
}

class _BurgersState extends State<Burgers> {

  //List Variables
  List<bool> _cheese = [];
  List<bool> _fries = [];
  List<bool> _dropdown = [];
  List<int> _counters = [];
  List<int> _burgers = [];
  List burgers = [];

  int _total_items = 0;
  bool _initialized = false;
  late Future<Burger> futureBurgers;

  @override
  void initState() {
    super.initState();
    futureBurgers = fetchBurgers();
  }

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
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Burger>(
        future: futureBurgers,
        builder: (context, snapshot)
    {
      if (snapshot.hasData) {
        burgers = snapshot.data!.items;
        if (!_initialized) {
          for (int i = 0; i < burgers.length; i++) {
            _cheese.add(false);
            _fries.add(false);
            _dropdown.add(false);
            _counters.add(0);
            _burgers.add(0);
            _initialized = true;
          }
        }
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
              backgroundColor: darkMode ? Colors.black : Colors.white,
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(
                      Icons.arrow_back
                  ),
                  onPressed: () {
                    for(int i=0;i<burgers.length;i++)
                      collector.add({
                        '$i': '${burgers[i]}',
                        'ordered' : '${_burgers[i]}',
                        'cheese': '${_cheese[i]}',
                        'fries': '${_fries[i]}',
                        'total': '$_total_items'
                      });
                    Navigator.of(context).pop();
                  },
                ),
                iconTheme: const IconThemeData(color: Colors.green),
                // shadowColor: Colors.grey[500],
                elevation: 0.5,
                shadowColor: darkMode ? Colors.white : Colors.black,
                title: Text(
                  'Burgers',
                  style: TextStyle(
                      fontFamily: 'Headings',
                      color: darkMode ? Colors.white : Colors.black),
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
                        darkMode = !darkMode;
                      });
                    },
                    icon: Icon(
                      darkMode ? Icons.wb_sunny_outlined : Icons.wb_sunny,
                      color: darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Badge(
                      badgeContent: Text(_total_items.toString()),
                      position: BadgePosition.topEnd(end: 0),
                      elevation: 0,
                      child: IconButton(icon: Icon(
                        Icons.shopping_cart_outlined,),
                        onPressed: () {
                        for(int i=0;i<burgers.length;i++)
                          collector.add({
                            '$i': '${burgers[i]}',
                            'ordered' : '${_burgers[i]}',
                            'cheese': '${_cheese[i]}',
                            'fries': '${_fries[i]}',
                            'total': '$_total_items'
                          });
                          Navigator.push(context,
                              PageTransition(
                                  child: Cart(), type: PageTransitionType.fade));
                        },),
                    ),
                  )
                ],
                centerTitle: true,
                backgroundColor: darkMode ? Colors.black : Colors.white,
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                        children: [
                          for(int i = 0; i < burgers.length; i++)
                            ListTile(
                              title: AnimatedCrossFade(
                                duration: const Duration(milliseconds: 500),
                                crossFadeState: _dropdown.elementAt(i)
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                firstChild: Column(
                                    mainAxisSize: MainAxisSize.min, children: [
                                  ListTile(
                                    leading: Image.network(
                                      burgers[i]['photo_url'],
                                    ),
                                    title: Text(
                                      burgers[i]['name'],
                                      style: TextStyle(
                                          fontFamily: 'Description_Text',
                                          color: darkMode ? Colors.white : Colors
                                              .black),
                                    ),
                                    subtitle: Text(
                                      'Price: Rs.${burgers[i]['price']}/- only',
                                      style: TextStyle(
                                          fontFamily: 'Description_Text',
                                          color: darkMode ? Colors.white : Colors
                                              .black),
                                    ),
                                    trailing: Icon(
                                      _dropdown.elementAt(i)
                                          ? Icons.arrow_drop_up_outlined
                                          : Icons.arrow_drop_down_outlined,
                                      color: darkMode ? Colors.white : Colors
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
                                      burgers[i]['photo_url'],
                                    ),
                                    title: Text(
                                      burgers[i]['name'],
                                      style: TextStyle(
                                          fontFamily: 'Description_Text',
                                          color: darkMode ? Colors.white : Colors
                                              .black),
                                    ),
                                    subtitle: Text(
                                      'Price: Rs.${burgers[i]['price']}/- only',
                                      style: TextStyle(
                                          fontFamily: 'Description_Text',
                                          color: darkMode ? Colors.white : Colors
                                              .black),
                                    ),
                                    trailing: Icon(
                                      _dropdown.elementAt(i)
                                          ? Icons.arrow_drop_up_outlined
                                          : Icons.arrow_drop_down_outlined,
                                      color: darkMode ? Colors.white : Colors
                                          .black,
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  ListTile(
                                    title: Text(
                                      burgers[i]['description'],
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontFamily: 'Description_Text',
                                          color: darkMode ? Colors.white : Colors
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
                                              color: darkMode
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              if (!(_burgers[i] - 1 < 0)) {
                                                _burgers[i]--;
                                                _total_items --;
                                                if (burgers[i] == 0) {
                                                  _cheese[i] = false;
                                                  _fries[i] = false;
                                                }
                                              }
                                            });
                                          },
                                          onLongPress: () {
                                            setState(() {
                                              _total_items -= _burgers[i];
                                              _burgers[i] = 0;
                                            });
                                          },
                                          child: Text(
                                            '-',
                                            style: TextStyle(
                                                fontFamily: 'Description_Text',
                                                color:
                                                darkMode ? Colors.white : Colors
                                                    .black),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              primary:
                                              darkMode ? Colors.black : Colors
                                                  .white),
                                        ),
                                        Text(
                                          _burgers[i].toString(),
                                          style: TextStyle(
                                              fontFamily: 'Description_Text',
                                              color: darkMode
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              _burgers[i]++;
                                              _total_items++;
                                              if (_burgers[i] == 1) {
                                                _cheese[i] = false;
                                                _fries[i] = false;
                                              }
                                            });
                                          },
                                          child: Text(
                                            '+',
                                            style: TextStyle(
                                                fontFamily: 'Description_Text',
                                                color:
                                                darkMode ? Colors.white : Colors
                                                    .black),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              primary:
                                              darkMode ? Colors.black : Colors
                                                  .white),
                                        ),
                                      ],
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  ListTile(
                                    title: _burgers[i] > 0 ? Column(
                                      children: [
                                        Row(
                                          children: [
                                            Checkbox(
                                                checkColor: Colors.white,
                                                fillColor:
                                                MaterialStateProperty.resolveWith(
                                                    getColor),
                                                value: _cheese[i],
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _cheese[i] = value!;
                                                  });
                                                }),
                                            Text('Cheese\t +Rs.30/-',
                                              style: TextStyle(
                                                  fontFamily: 'Description_Text',
                                                  color:
                                                  darkMode ? Colors.white : Colors
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
                                                value: _fries[i],
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _fries[i] = value!;
                                                  });
                                                }),
                                            Text('Fries\t +Rs.50/-',
                                              style: TextStyle(
                                                  fontFamily: 'Description_Text',
                                                  color:
                                                  darkMode ? Colors.white : Colors
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
                                  _dropdown[i] = !_dropdown.elementAt(i);
                                  for (int j = 0; j < _dropdown.length; j++)
                                    if (j != i)
                                      _dropdown[j] = false;
                                });
                              },
                            )
                        ],
                      ),
              )),
        );
      }
      else if (snapshot.hasError) {
        return Text('${snapshot.error}');
      }
      // By default, show a loading spinner.
      return SpinKitThreeBounce(
        color: darkMode? Colors.white:Colors.black,
        size: 40.0,
      );
    }
    );
  }
}

