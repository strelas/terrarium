import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:terrarium/main.dart';
import 'package:terrarium/screens/terrarium/cubit.dart';
import 'package:terrarium/screens/terrarium/state.dart';

const windowSize = Size(1200, 1200);

void main() {
  testWidgets('Clear terrarium test', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(windowSize);
    final cubit = TerrariumCubit();
    await tester.pumpWidget(MyApp(
      cubit: cubit,
    ));

    await tester.tap(find.text("Почистить террариум"));
    await tester.pump();
    expect(find.text("Загрязнение террариума: 0%"), findsOneWidget);
    await tester.pump(const Duration(minutes: 5));
    expect(find.text("Загрязнение террариума: 100%"), findsOneWidget);
  });

  testWidgets('Add animal test', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(windowSize);
    final cubit = TerrariumCubit();
    await tester.pumpWidget(MyApp(
      cubit: cubit,
    ));
    await tester.tap(find.text("Добавить животное"));
    await tester.pump();
    final firstItem = find.byType(Image, skipOffstage: false).first;
    await tester.ensureVisible(firstItem);
    await tester.pumpAndSettle();
    expect(firstItem, findsOneWidget);
    await tester.tap(firstItem);
    await tester.tap(find.text("Добавить", skipOffstage: false));
    await tester.pumpAndSettle();

    expect(find.image(Images.lion), findsOneWidget);
  });

  testWidgets('Add plant test', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(windowSize);
    final cubit = TerrariumCubit();
    await tester.pumpWidget(MyApp(
      cubit: cubit,
    ));
    await tester.tap(find.text("Добавить растение"));
    await tester.pump();
    final firstItem = find.byType(Image, skipOffstage: false).first;
    await tester.ensureVisible(firstItem);
    await tester.pumpAndSettle();
    expect(firstItem, findsOneWidget);
    await tester.tap(firstItem);
    await tester.tap(find.text("Добавить", skipOffstage: false));
    await tester.pumpAndSettle();

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('Add decoration test', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(windowSize);
    final cubit = TerrariumCubit();
    await tester.pumpWidget(MyApp(
      cubit: cubit,
    ));
    await tester.tap(find.text("Добавить декорацию"));
    await tester.pump();
    final firstItem = find.byType(Image, skipOffstage: false).first;
    await tester.ensureVisible(firstItem);
    await tester.pumpAndSettle();
    expect(firstItem, findsOneWidget);
    await tester.tap(firstItem);
    await tester.tap(find.text("Добавить", skipOffstage: false));
    await tester.pumpAndSettle();

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('Close choose dialog test', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(windowSize);
    final cubit = TerrariumCubit();
    await tester.pumpWidget(MyApp(
      cubit: cubit,
    ));
    await tester.tap(find.text("Добавить животное"));
    await tester.pump();
    final closeIcon = find.byIcon(Icons.close, skipOffstage: false);
    await tester.ensureVisible(closeIcon);
    await tester.pumpAndSettle();
    expect(closeIcon, findsOneWidget);
    await tester.tap(closeIcon);
    await tester.pumpAndSettle();

    expect(find.byType(Image, skipOffstage: true), findsNothing);
  });

  testWidgets('Animal status dialog test', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(windowSize);
    final cubit = TerrariumCubit();
    await tester.pumpWidget(MyApp(
      cubit: cubit,
    ));
    cubit.emit(TerrariumState(
      [
        ItemModel(
          id: 1,
          left: 0.5,
          top: 0.5,
          height: 0.1,
          width: 0.1,
          image: Images.lion,
          health: 50,
          type: Type.animal,
        ),
      ],
      100,
    ));
    await tester.pump();
    final element = find.image(Images.lion);
    expect(element, findsOneWidget);
    await tester.tap(element, buttons: kSecondaryButton);
    await tester.pump();
    final statusElement = find.text("Статус");
    await tester.ensureVisible(statusElement);
    await tester.pumpAndSettle();
    expect(statusElement, findsOneWidget);
    await tester.tap(statusElement);
    await tester.pump();

    final feedButton = find.text("Покормить", skipOffstage: false);
    await tester.ensureVisible(feedButton);
    await tester.pumpAndSettle();
    expect(feedButton, findsOneWidget);
    await tester.tap(feedButton);
    await tester.tap(feedButton);
    await tester.tap(feedButton);
    await tester.tap(feedButton);
    await tester.tap(feedButton);
    await tester.pump();

    expect(find.text("Здоровье: 100%", skipOffstage: false), findsOneWidget);

    final closeIcon = find.byIcon(Icons.close, skipOffstage: false);
    await tester.ensureVisible(closeIcon);
    await tester.pumpAndSettle();
    expect(closeIcon, findsOneWidget);
    await tester.tap(closeIcon);
    await tester.pumpAndSettle();

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('Plant status dialog test', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(windowSize);
    final cubit = TerrariumCubit();
    await tester.pumpWidget(MyApp(
      cubit: cubit,
    ));
    cubit.emit(TerrariumState(
      [
        ItemModel(
          id: 1,
          left: 0.5,
          top: 0.5,
          height: 0.1,
          width: 0.1,
          image: Images.lion,
          health: 50,
          type: Type.plant,
        ),
      ],
      100,
    ));
    await tester.pump();
    final element = find.image(Images.lion);
    expect(element, findsOneWidget);
    await tester.tap(element, buttons: kSecondaryButton);
    await tester.pump();
    final statusElement = find.text("Статус");
    await tester.ensureVisible(statusElement);
    await tester.pumpAndSettle();
    expect(statusElement, findsOneWidget);
    await tester.tap(statusElement);
    await tester.pump();

    final waterButton = find.text("Полить", skipOffstage: false);
    await tester.ensureVisible(waterButton);
    await tester.pumpAndSettle();
    expect(waterButton, findsOneWidget);
    await tester.tap(waterButton);
    await tester.tap(waterButton);
    await tester.tap(waterButton);
    await tester.tap(waterButton);
    await tester.tap(waterButton);
    await tester.pump();

    expect(find.text("Здоровье: 100%", skipOffstage: false), findsOneWidget);

    final closeIcon = find.byIcon(Icons.close, skipOffstage: false);
    await tester.ensureVisible(closeIcon);
    await tester.pumpAndSettle();
    expect(closeIcon, findsOneWidget);
    await tester.tap(closeIcon);
    await tester.pumpAndSettle();

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('Plant delete test', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(windowSize);
    final cubit = TerrariumCubit();
    await tester.pumpWidget(MyApp(
      cubit: cubit,
    ));
    cubit.emit(TerrariumState(
      [
        ItemModel(
          id: 1,
          left: 0.5,
          top: 0.5,
          height: 0.1,
          width: 0.1,
          image: Images.lion,
          health: 50,
          type: Type.plant,
        ),
      ],
      100,
    ));
    await tester.pump();
    final element = find.image(Images.lion);
    expect(element, findsOneWidget);
    await tester.tap(element, buttons: kSecondaryButton);
    await tester.pump();
    final statusElement = find.text("Удалить");
    await tester.ensureVisible(statusElement);
    await tester.pumpAndSettle();
    expect(statusElement, findsOneWidget);
    await tester.tap(statusElement);
    await tester.pump();
    expect(find.image(Images.lion), findsNothing);
  });
}
