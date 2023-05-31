import 'package:bys_app/general/const.dart';
import 'package:flutter/material.dart';

class DaySelector extends StatefulWidget {
  final Function(int)? onChanged;
  const DaySelector({this.onChanged, Key? key}) : super(key: key);

  @override
  State<DaySelector> createState() => _DaySelectorState();
}

class _DaySelectorState extends State<DaySelector> {
  int selected_index = 1;
  void ChangeIndex(int cambio) {
    if (widget.onChanged != null) widget.onChanged!(cambio);
    setState(() {
      selected_index = cambio;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected_index = GlobalConstants.getHoy();
    if (widget.onChanged != null) widget.onChanged!(selected_index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromRGBO(142, 11, 44, 1),
        padding: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _customButton(
                onPressed: ChangeIndex,
                texto: 'Lu',
                index: 1,
                selected_index: selected_index),
            _customButton(
                onPressed: ChangeIndex,
                texto: 'Ma',
                index: 2,
                selected_index: selected_index),
            _customButton(
                onPressed: ChangeIndex,
                texto: 'Mi',
                index: 3,
                selected_index: selected_index),
            _customButton(
                onPressed: ChangeIndex,
                texto: 'Ju',
                index: 4,
                selected_index: selected_index),
            _customButton(
                onPressed: ChangeIndex,
                texto: 'Vi',
                index: 5,
                selected_index: selected_index),
            _customButton(
                onPressed: ChangeIndex,
                texto: 'Sa',
                index: 6,
                selected_index: selected_index),
          ],
        ));
  }

  Widget _customButton(
      {Function? onPressed,
      String? texto,
      required int index,
      required int selected_index}) {
    const double size = 40;
    return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
            color: index == selected_index ? Colors.grey : null,
            borderRadius: BorderRadius.circular(80)),
        child: InkWell(
          onTap: () {
            if (onPressed != null) onPressed(index);
          },
          child: Center(
              child: Text(
            texto ?? '',
            style: const TextStyle(color: Colors.white),
          )),
        ));
  }
}
