import 'package:bys_app/general/const.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  final TextEditingController controller;
  const DatePicker({Key? key, required this.controller}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? selectedDate;

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        if (selectedDate != null) {
          widget.controller.text = GlobalConstants.format.format(selectedDate!);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10000000,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            controller: widget.controller,
            cursorColor: const Color.fromRGBO(142, 11, 44, 1),
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(50.0),
              ),
              filled: true,
              fillColor: const Color.fromRGBO(212, 212, 212, 1),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromRGBO(142, 11, 44, 1),
                ),
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                _selectDate(
                    context); // Call the function to show the date picker
              },
            ),
          ),
        ],
      ),
    );
  }
}
