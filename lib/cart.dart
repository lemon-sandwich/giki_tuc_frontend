import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:giki_tuc/services/payment.dart';
import 'controllers/cart_controller.dart';
import 'controllers/dark_theme_controller.dart';

class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {


  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final darkThemeController = Get.find<DarkThemeController>();
    final total = cartController.totalAmount(
        cartController.burgerType,cartController.burgers,cartController.cheese,cartController.fries,
      cartController.pizzaType,cartController.pizzas,cartController.extraToppings,
    cartController.friesType,cartController.friesNumber,
      cartController.iceCreamType,cartController.iceCreams,
      cartController.rollParathaType,cartController.rollParathas,cartController.cheeseRollParatha,cartController.friesRollParatha,
      cartController.sandwichType,cartController.sandwiches,cartController.cheeseSandwich,cartController.friesSandwich,) + 30;
    return Scaffold(
      backgroundColor: darkThemeController.darkMode.value? Colors.black:Colors.white,
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
        title: Text('Cart',
        style: TextStyle(
          fontFamily: 'Headings',
          color: darkThemeController.darkMode.value? Colors.white:Colors.black,
        ),),
        centerTitle: true,
        backgroundColor: darkThemeController.darkMode.value? Colors.black:Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            for(int i = 0; i < cartController.burgerType.length; i++)
              cartController.burgers[i] != 0? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${cartController.burgerType[i]['name']}',
                  style: TextStyle(
                    color: darkThemeController.darkMode.value? Colors.white:Colors.black,
                  ),),
                  SizedBox(height: 30,),
                  Text('x${cartController.burgers[i]}',
                  style: TextStyle(
                    color: darkThemeController.darkMode.value? Colors.white:Colors.black,
                  ),)
                ],
              ):SizedBox(),
            for(int i = 0; i < cartController.pizzaType.length; i++)
              cartController.pizzas[i] != 0? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${cartController.pizzaType[i]['name']}',
                    style: TextStyle(
                      color: darkThemeController.darkMode.value? Colors.white:Colors.black,
                    ),),
                  SizedBox(height: 30,),
                  Text('x${cartController.pizzas[i]}',
                    style: TextStyle(
                      color: darkThemeController.darkMode.value? Colors.white:Colors.black,
                    ),)
                ],
              ):SizedBox(),
            for(int i = 0; i < cartController.friesType.length; i++)
              cartController.friesNumber[i] != 0? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${cartController.friesType[i]['name']}',
                    style: TextStyle(
                      color: darkThemeController.darkMode.value? Colors.white:Colors.black,
                    ),),
                  SizedBox(height: 30,),
                  Text('x${cartController.friesNumber[i]}',
                    style: TextStyle(
                      color: darkThemeController.darkMode.value? Colors.white:Colors.black,
                    ),)
                ],
              ):SizedBox(),
            for(int i = 0; i < cartController.iceCreamType.length; i++)
              cartController.iceCreams[i] != 0? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${cartController.iceCreamType[i]['name']}',
                    style: TextStyle(
                      color: darkThemeController.darkMode.value? Colors.white:Colors.black,
                    ),),
                  SizedBox(height: 30,),
                  Text('x${cartController.iceCreams[i]}',
                    style: TextStyle(
                      color: darkThemeController.darkMode.value? Colors.white:Colors.black,
                    ),)
                ],
              ):SizedBox(),
            Divider(
              color: darkThemeController.darkMode.value? Colors.white:Colors.black,
            ),
            Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Amount: ',
                      style: TextStyle(
                        color: darkThemeController.darkMode.value? Colors.white:Colors.black,
                      ),),
                    Obx( () => Text('Rs.${ total - 30}/-',
                      style: TextStyle(
                        color: darkThemeController.darkMode.value? Colors.white:Colors.black,
                      ),)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delivery Charges: ',
                      style: TextStyle(
                        color: darkThemeController.darkMode.value? Colors.white:Colors.black,
                      ),),
                    Text('Rs.30/-',
                      style: TextStyle(
                        color: darkThemeController.darkMode.value? Colors.white:Colors.black,
                      ),),
                  ],
                ),
                Divider(
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total: ',
                      style: TextStyle(
                        color: darkThemeController.darkMode.value? Colors.white:Colors.black,
                      ),),
                    Text('Rs./$total-',
                      style: TextStyle(
                        color: darkThemeController.darkMode.value? Colors.white:Colors.black,
                      ),),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: darkThemeController.darkMode.value? Colors.white: Colors.black,
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Payment',
                style: TextStyle(
                  color: darkThemeController.darkMode.value? Colors.black:Colors.white,
                ),),

              Icon(
                Icons.arrow_forward,
                color: darkThemeController.darkMode.value? Colors.black:Colors.white,
              )
            ],
          ),
          onPressed: () {
            Get.to(()=> Payment(),transition: Transition.fade);
          },
        ),
      ),
    );
  }
}
