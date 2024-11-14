TODO: Manage state without additional package

## Features
<p>Manage state without using additional packages.</p>
<p>Improve performance of application by reducing redundant rendering of other widgets.</p>


## Usage

```yaml
dependencies:
  flutter:
    sdk: flutter

  carousel_pro:
    git:
      url: https://github.com/williamvux/state_management.git
      ref: main
```

```dart
//Create provider for state
import 'package:state_management/state_management.dart';

final class CartProvider extends StateBloc {
  final Map<String, bool> map;

  CartProvider({required this.map});

  void checkCart(String key, bool isChecked) {
    map[key] = isChecked;
    notify<CartProvider>();
  }

  void checkAll(bool value) {
    map.updateAll((_, v) => v = value);
    notify<CartProvider>();
  }
}

```
```dart

//Create state provider that map data


final class ShoppingCart extends StatelessWidget {
  static const String routeName = '/shopping-cart';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => BlocProvider(
        create: (context) => CartBloc()..add(const GetItemsCart()),
        child: const ShoppingCart(),
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          label.shoppingCart,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: StateProvider(
          create: (context) => CartProvider(
            map: mapRoom.map(
                  (key, value) => MapEntry(key, false),
            ),
          ),
          child: Column(
            children: [
              CartHeader(label: label),
              Expanded(
                child: ListCartItems(label: label, rooms: rooms, mapRoom: mapRoom),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


```

```dart
//Register builder for state
final class CartHeader extends StatelessWidget {
  const CartHeader({super.key, required this.label});

  final LanguageLabel label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Transform.scale(
                scale: 1.25,
                child: StateBuilder<CartProvider>(
                  builder: (_, state) {
                    return Checkbox(
                      checkColor: Colors.white,
                      splashRadius: 8,
                      activeColor: AppConstants.accent,
                      side: const BorderSide(color: Colors.white, width: 2),
                      value: state.map.values.every((value) => value),
                      onChanged: (value) {
                        state.checkAll(value ?? false);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

## Result

<div style="width: 150px">
<img src="assets/result.gif">
</div>