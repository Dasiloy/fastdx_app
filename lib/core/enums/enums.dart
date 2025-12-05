//? USER
enum Role { vendor, customer }

//? MEALS
enum MealIngredientsEnum {
  salt,
  pepper,
  cheese,
  tomato,
  lettuce,
  onion,
  beef,
  chicken,
  fish,
  shrimp,
  sauce,
  mayo,
  ketchup,
  mustard,
  butter,
  milk,
  flour,
  rice,
  none,
}

enum MealCategoryEnum {
  burger,
  hotDog,
  pizza,
  pasta,
  fries,
  drink,
  chicken,
  dessert,
  seafood,
  sandwich,
  salad,
  rice,
}

//? ORDER
enum OrderPaymentStatusEnum { pending, paid, failed, refunded }

enum OrderPaymentMethodEnum { card, cash, wallet, transfer, paypal }

enum OrderDeliveryModeEnum { pickUp, delivery }

enum OrderStatusEnum { pending, dispatched, completed, accepted, cancelled }

//? UI
enum TapBehavior { none, gestureDetector, inkWell }
