import 'package:flutter/material.dart';

class RajuHotel extends StatefulWidget {
  const RajuHotel({Key? key}) : super(key: key);

  @override
  _RajuHotelState createState() => _RajuHotelState();
}

class _RajuHotelState extends State<RajuHotel> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Raju Hotel',
          style: TextStyle(
              fontSize: 50
          ),),
      ),
    );
  }
}
// For body, buttons for all the categories
/*Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: containerHeight,
                    child: Material(
                        borderRadius: BorderRadius.circular(20),
                        shadowColor: Colors.redAccent,
                        color: Colors.red,
                        elevation: 7,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: const Duration(milliseconds: 1000),
                                    child: const GroceryStore()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/groceryStore1.png'),
                              const Text('Grocery Store',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontSize: 20,
                                  )),
                            ],
                          ),
                        ))),
                const SizedBox(height: 10,),
                SizedBox(
                    height: containerHeight,
                    child: Material(
                        borderRadius: BorderRadius.circular(20),
                        shadowColor: Colors.white,
                        color: Colors.white,
                        elevation: 7,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: const Duration(milliseconds: 1000),
                                    child: const StationaryShop()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/stationaryShop.png'),
                              const Text('Stationary Shop',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montserrat',
                                    fontSize: 20,
                                  )),
                            ],
                          ),
                        ))),
                const SizedBox(height: 10,),
                SizedBox(
                    height: containerHeight,
                    child: Material(
                        borderRadius: BorderRadius.circular(20),
                        shadowColor: Colors.blueAccent,
                        color: Color(0XF93822FF),
                        elevation: 7,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: const Duration(milliseconds: 1000),
                                    child: const Restaurant()));
                          },
                          child: const Center(
                              child: Text('Restaurants',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontSize: 20,
                                  ))),
                        ))),
              ],
            ),
          )*/