import 'package:flutter/material.dart';

class HintsPopupMenuDelete extends PopupMenuEntry<Response> {
  const HintsPopupMenuDelete({Key? key}) : super(key: key);

  @override
  double get height => 100;

  @override
  bool represents(Response? value) => true;

  @override
  State createState() => _HintsPopupMenuDeleteState();
}

class _HintsPopupMenuDeleteState extends State<HintsPopupMenuDelete> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop<Response>(Response.delete);
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

class HintsPopupMenuStatus extends PopupMenuEntry<Response> {
  const HintsPopupMenuStatus({Key? key}) : super(key: key);

  @override
  double get height => 100;

  @override
  bool represents(Response? value) => true;

  @override
  State createState() => _HintsPopupMenuStatusState();
}

class _HintsPopupMenuStatusState extends State<HintsPopupMenuStatus> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop<Response>(Response.status);
      },
      child: Container(
        color: Colors.white70,
        child: const Center(
            child: Text(
          "Статус",
        )),
      ),
    );
  }
}

enum Response { delete, status }
