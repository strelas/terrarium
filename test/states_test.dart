import 'package:flutter_test/flutter_test.dart';
import 'package:terrarium/screens/terrarium/state.dart';

void main() {
  test('fromJson toJson test', () {
    final state = TerrariumState(
      [
        ItemModel(
            id: 1,
            left: 0.5,
            top: 0.5,
            height: 0.1,
            width: 0.1,
            image: Images.stone,
            health: 55,
            type: Type.plant)
      ],
      100,
      true,
    );
    final fromJsonState = TerrariumState.fromJson(state.toJson());
    expect(state, fromJsonState);
    expect(state.hashCode, fromJsonState.hashCode);
  });
}
