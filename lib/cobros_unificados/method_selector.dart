import 'package:bys_app/general/const.dart';
import 'package:flutter/material.dart';

class MethodSelector extends StatefulWidget {
  final Function(String)? onChanged;
  const MethodSelector({this.onChanged, Key? key}) : super(key: key);

  @override
  State<MethodSelector> createState() => _MethodSelectorState();
}

class _MethodSelectorState extends State<MethodSelector> {
  String selected_index = 'PV';
  void ChangeIndex(String cambio) {
    if (widget.onChanged != null) widget.onChanged!(cambio);
    setState(() {
      selected_index = cambio;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected_index = 'PV';
    if (widget.onChanged != null) widget.onChanged!('PV');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromRGBO(142, 11, 44, 1),
        padding: EdgeInsets.only(top: 50, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _customButton(
                onPressed: ChangeIndex,
                texto: 'Contado (PV)',
                value: 'PV',
                selected_index: selected_index),
            _customButton(
                onPressed: ChangeIndex,
                texto: 'Datáfono (TC)',
                value: 'TC',
                selected_index: selected_index),
            _customButton(
                onPressed: ChangeIndex,
                texto: 'Cheque (CH)',
                value: 'CH',
                selected_index: selected_index),
            _customButton(
                onPressed: ChangeIndex,
                texto: 'Transferencia (TF)',
                value: 'TF',
                selected_index: selected_index),
          ],
        ));
  }

  Widget _customButton(
      {Function? onPressed,
      String? texto,
      required String selected_index,
      required String value}) {
    const double size = 40;
    return Container(
        height: size,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: value == selected_index ? Colors.grey : null,
            borderRadius: BorderRadius.circular(80)),
        child: InkWell(
          onTap: () {
            if (onPressed != null) onPressed(value);
          },
          child: Center(
              child: Text(
            texto ?? '',
            style: const TextStyle(color: Colors.white),
          )),
        ));
  }
}
