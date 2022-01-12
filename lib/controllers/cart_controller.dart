import 'package:get/get.dart';

class CartController extends GetxController{

  var total_items = 0.obs;
  var total = 0.obs;
  //List Variables for Burger
  List<List<bool>> cheese = [];
  List<List<bool>> fries = [];
  List<bool> dropdownBurger = [];
  List<int> countersBurger = [];
  List<int> burgers = [];
  List burgerType = [];

  //List Variables for Pizza
  List<List<bool>> extraToppings = [];
  List<bool> dropdownPizza = [];
  List<int> countersPizza = [];
  List<int> pizzas = [];
  List pizzaType = [];

  //List Variables for Fries
  List<List<bool>> spicy = [];
  List<bool> dropdownFries = [];
  List<int> countersFries = [];
  List<int> friesNumber = [];
  List friesType = [];

  //List Variables for IceCream
  //List<List<bool>> spicy = [];
  List<bool> dropdownIceCream = [];
  List<int> countersIceCream = [];
  List<int> iceCreams = [];
  List iceCreamType = [];

  //List Variables for RollParatha
  List<List<bool>> cheeseRollParatha = [];
  List<List<bool>> friesRollParatha = [];
  List<bool> dropdownRollParatha = [];
  List<int> countersRollParatha = [];
  List<int> rollParathas = [];
  List rollParathaType = [];

  //List Variables for Sandwich
  List<List<bool>> cheeseSandwich = [];
  List<List<bool>> friesSandwich = [];
  List<bool> dropdownSandwich = [];
  List<int> countersSandwich = [];
  List<int> sandwiches = [];
  List sandwichType = [];

  void increment(){
    total_items.value ++;
  }
  void decrement(){
    total_items.value --;
  }
  void incrementValue(int value){
    total_items.value += value;
  }
  void decrementValue(int value){
    total_items.value -= value;
  }
  RxInt totalAmount(List burgerType,List<int> burgerNumber,List<List<bool>> cheese,List<List<bool>> fries,
      List pizzaType,List<int> pizzaNumber,List<List<bool>> extraToppings,
      List friesType,List<int> friesNumber,
      List iceCreamType,List<int> iceCreamNumber,
      List rollParathaType,List<int> rollParathaNumber,List<List<bool>> cheeseRollParatha,List<List<bool>> friesRollParatha,
      List sandwichType,List<int> sandwichNumber,List<List<bool>> cheeseSandwich,List<List<bool>> friesSandwich,

      )
  {
    total = 0.obs;
    int sum = 0;
    int preferenceTotal = 0;
    for(int i=0;i<burgerType.length;i++) {
      preferenceTotal = 0;
      for(int j=0;j<burgerNumber[i];j++)
        {
          preferenceTotal += (cheese[i][j]==true?30:0) + (fries[i][j]==true?50:0);
          print('Preference Total = $preferenceTotal');
        }
          sum = (burgerType[i]['price'] * burgerNumber[i]) + preferenceTotal;
      print('Sum = $sum');
          total = total + sum;
        }

    for(int i=0;i<pizzaType.length;i++) {
      preferenceTotal = 0;
      for(int j=0;j<pizzaNumber[i];j++)
      {
        preferenceTotal += extraToppings[i][j]==true?30:0;
        print('Preference Total = $preferenceTotal');
      }
      sum = (pizzaType[i]['price'] * pizzaNumber[i]) + preferenceTotal;
      print('Sum = $sum');
      total = total + sum;
    }

    for(int i=0;i<friesType.length;i++) {
      preferenceTotal = 0;
      sum = (friesType[i]['price'] * friesNumber[i]) + preferenceTotal;
      print('Sum = $sum');
      total = total + sum;
    }
    for(int i=0;i<iceCreamType.length;i++) {
      preferenceTotal = 0;
      sum = (iceCreamType[i]['price'] * friesNumber[i]) + preferenceTotal;
      print('Sum = $sum');
      total = total + sum;
    }

    for(int i=0;i<rollParathaType.length;i++) {
      preferenceTotal = 0;
      for(int j=0;j<rollParathaNumber[i];j++)
      {
        preferenceTotal += (cheeseRollParatha[i][j]==true?30:0) + (friesRollParatha[i][j]==true?50:0);
        print('Preference Total = $preferenceTotal');
      }
      sum = (rollParathaType[i]['price'] * rollParathaNumber[i]) + preferenceTotal;
      print('Sum = $sum');
      total = total + sum;
    }

    for(int i=0;i<sandwichType.length;i++) {
      preferenceTotal = 0;
      for(int j=0;j<sandwichNumber[i];j++)
      {
        preferenceTotal += (cheeseSandwich[i][j]==true?30:0) + (friesSandwich[i][j]==true?50:0);
        print('Preference Total = $preferenceTotal');
      }
      sum = (sandwichType[i]['price'] * sandwichNumber[i]) + preferenceTotal;
      print('Sum = $sum');
      total = total + sum;
    }



    return total;
    }

  String invoice(List burgerType,List<int> burgerNumber,List<List<bool>> cheese,List<List<bool>> fries){
    String invoiceDetail = '';
    int sum = 0;
    int preferenceTotal = 0;
    for(int i=0;i<burgerType.length;i++) {
      preferenceTotal = 0;
      for(int j=0;j<burgerNumber[i];j++)
      {
        preferenceTotal += (cheese[i][j]==true?30:0) + (fries[i][j]==true?50:0);
        print('Preference Total = $preferenceTotal');
      }
      sum = (burgerType[i]['price'] * burgerNumber[i]) + preferenceTotal;
      print('Sum = $sum');
      total = total + sum;
    }
    return invoiceDetail;
  }
}