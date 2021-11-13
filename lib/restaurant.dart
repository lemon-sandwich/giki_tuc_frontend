import 'package:flutter/material.dart';
import 'package:giki_tuc/restaurants/ayaan_hotel.dart';
import 'package:giki_tuc/restaurants/hot_and_spicy.dart';
import 'package:giki_tuc/restaurants/raju_hotel.dart';
import 'package:page_transition/page_transition.dart';

class Restaurant extends StatefulWidget {
  const Restaurant({Key? key}) : super(key: key);

  @override
  _RestaurantState createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  get pressed => null;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 16,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                duration: const Duration(milliseconds: 1000),
                                child: const AyaanHotel()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
                        child: Text(
                          'Ayaan Hotel',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w600,),
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 16,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 1000),
                              child: const HotAndSpicy()));
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
                      child: Text(
                        'Hot & Spicy',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,),
                      ),
                    ),
                  ),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 16,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 1000),
                              child: const RajuHotel()));
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
                      child: Text(
                        'Raju Hotel',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,),
                      ),
                    ),
                  ),
                ),
              ],
            ),

          )

      ),
    );
  }
}
