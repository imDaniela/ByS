import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum PaymentMethod { contado, datafono, cheque, transferencia }

class SelectMetodo extends StatefulWidget {
  const SelectMetodo({Key? key}) : super(key: key);

  @override
  State<SelectMetodo> createState() => _SelectMetodoState();
}

class _SelectMetodoState extends State<SelectMetodo> {
  String _getDisplayText(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.contado:
        return 'Contado (PV)';
      case PaymentMethod.datafono:
        return 'Datáfono (TC)';
      case PaymentMethod.cheque:
        return 'Cheque (CH)';
      case PaymentMethod.transferencia:
        return 'Transferencia (TF)';
      default:
        return '';
    }
  }

  PaymentMethod? selectedPaymentMethod = PaymentMethod.contado;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10000000,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          InputDecorator(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0),
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
            child: DropdownButtonHideUnderline(
              child: DropdownButton<PaymentMethod>(
                value: selectedPaymentMethod,
                onChanged: (PaymentMethod? newValue) {
                  setState(() {
                    selectedPaymentMethod = newValue;
                  });
                },
                items: PaymentMethod.values.map((PaymentMethod method) {
                  return DropdownMenuItem<PaymentMethod>(
                    value: method,
                    child: Text(_getDisplayText(method)),
                  );
                }).toList(),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: IconButton(
              icon: Icon(Icons.arrow_drop_down),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
