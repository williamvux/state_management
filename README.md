TODO: Manage state without additional package

## Features
Manage state without using additional packages.\n
Improve performance of application by reducing redundant rendering of other widgets.


## Usage
```dart
final class CounterProvider extends StateBloc {
  int count = 0;

  void increment() {
    count++;
    notify<CounterProvider>();
  }

  void decrement() {
    count--;
    notify<CounterProvider>();
  }
}
```