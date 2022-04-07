import 'package:flutter/material.dart';

class HintsPopupMenuEntry extends PopupMenuEntry<bool> {
  const HintsPopupMenuEntry({Key? key}) : super(key: key);

  @override
  double get height => 100;

  @override
  bool represents(bool? value) => true;

  @override
  State createState() => _HintsPopupMenuEntryState();
}

class _HintsPopupMenuEntryState extends State<HintsPopupMenuEntry> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop<bool>(true);
      },
      child: Container(
        color: Colors.white70,
        child: const Center(
            child: Text(
              "Удалить",
              style: TextStyle(color: Colors.red),
            )),
      ),
    );
  }
}
