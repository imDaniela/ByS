import 'package:bys_app/clientes_del_dia/bloc/cliente_bloc.dart';
import 'package:bys_app/inicio_sesion/bloc/clientesbloc/clientes_bloc.dart';
import 'package:bys_app/inicio_sesion/bloc/clientesdia/bloc/clientesdia_bloc.dart';
import 'package:bys_app/inicio_sesion/model/ClientesDia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import your BLoC package
import 'package:dropdown_search/dropdown_search.dart'; // Import dropdown_search package
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDialog extends StatelessWidget {
  int? codcli;
  int? dia = 1;
  int? tarde = 1;

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Añadir Cliente'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            // Searchable Dropdown
            BlocBuilder<ClientesBloc, ClientesState>(
              builder: (context, state) {
                if (state is ClientesLoaded) {
                  return SearchableDropdown(
                    items: (state as ClientesLoaded).clientes,
                    controller: controller,
                    onChanged: (cliente) {
                      if (cliente != null) codcli = cliente.codcli;
                    },
                  );

                  /*DropdownSearch<String>(
                    popupProps: PopupProps.bottomSheet(),
                    itemAsString: (String u) => u,
                    onChanged: (String? data) => print(data),
                    items: (state as ClientesLoaded)
                        .clientes
                        .map((item) => item.nom)
                        .toList(),
                  );*/
                } else {
                  return CircularProgressIndicator(); // Loading indicator or placeholder
                }
              },
            ),
            DayDropDown(
              onChanged: (_dia) {
                if (_dia != null) dia = _dia + 1;
              },
            ),
            MananaTarde(
              onChanged: (_tarde) {
                if (_tarde != null) tarde = _tarde + 1;
              },
            )
            // Regular Dropdown
            //DropdownButton(
            //  items: [
            //    DropdownMenuItem(
            //      value: "morning",
            //      child: Text("Morning"),
            //    ),
            //    DropdownMenuItem(
            //      value: "afternoon",
            //      child: Text("Afternoon"),
            //    ),
            //  ],
            //  onChanged: (value) {
            //    // Handle dropdown value change
            //  },
            //  hint: Text("Select time"),
            //),

            // Radio Buttons
            /* Row(
              children: [
                Radio(
                  value: "morning",
                  groupValue: selectedTime,
                  onChanged: (value) {
                    // Handle radio button selection
                  },
                ),
                Text("Morning"),
                Radio(
                  value: "afternoon",
                  groupValue: selectedTime,
                  onChanged: (value) {
                    // Handle radio button selection
                  },
                ),
                Text("Afternoon"),
              ],
            ),*/

            // Day Selector
            // You can use a date picker or a list of days here
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Handle dialog dismissal
            Navigator.pop(context);
          },
          child: Text('Cerrar'),
        ),
        TextButton(
          onPressed: () {
            // Handle form submission
            if (codcli != null && dia != null && tarde != null) {
              context.read<ClientesdiaBloc>().add(AddClienteDiaEvent(
                  codcli: codcli!, dia: dia!, tarde: tarde!));
              Navigator.pop(context);
            }
          },
          child: Text('Guardar'),
        ),
      ],
    );
  }
}

class MananaTarde extends StatefulWidget {
  final Function(int?)? onChanged;
  const MananaTarde({Key? key, this.onChanged}) : super(key: key);

  @override
  State<MananaTarde> createState() => _MananaTardeState();
}

class _MananaTardeState extends State<MananaTarde> {
  String? selectedTime = 'mañana'; // Default selected time

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: InkWell(
                  onTap: () {
                    widget.onChanged!(0);

                    setState(() {
                      selectedTime = 'mañana';
                    });
                  },
                  child: Text('Mañana')),
              leading: Radio<String>(
                value: 'mañana',
                groupValue: selectedTime,
                onChanged: (String? value) {
                  widget.onChanged!(value == 'tarde' ? 1 : 0);

                  setState(() {
                    selectedTime = value;
                  });
                },
              ),
            )),
            Flexible(
                child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: InkWell(
                  onTap: () {
                    widget.onChanged!(1);

                    setState(() {
                      selectedTime = 'tarde';
                    });
                  },
                  child: Text('Tarde')),
              leading: Radio<String>(
                value: 'tarde',
                groupValue: selectedTime,
                onChanged: (String? value) {
                  // Handle "tarde" radio button selection

                  widget.onChanged!(value == 'tarde' ? 1 : 0);

                  setState(() {
                    selectedTime = value;
                  });
                },
              ),
            )),
          ],
        ));
  }
}

class DayDropDown extends StatefulWidget {
  final Function(int?)? onChanged;
  const DayDropDown({Key? key, this.onChanged}) : super(key: key);

  @override
  State<DayDropDown> createState() => _DayDropDownState();
}

class _DayDropDownState extends State<DayDropDown> {
  List<String> daysOfWeek = [
    'lunes',
    'martes',
    'miércoles',
    'jueves',
    'viernes',
    'sábado',
    'domingo'
  ];
  int? index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: const Color.fromRGBO(
              212, 212, 212, 1), // Set the background color
        ),
        child: DropdownButton<String>(
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            underline: Container(
              width: double.infinity,
              height: 0,
              color: Colors.transparent,
            ),
            value: index == null ? null : daysOfWeek[index!], // Default value
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  index = daysOfWeek.indexOf(newValue);
                  widget.onChanged!(index);
                });
              } else {
                index = null;
              }
            },
            items: daysOfWeek.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList()));
  }
}

class SearchableDropdown extends StatefulWidget {
  final TextEditingController controller;
  final List<ClientesDia> items;
  final Function(ClientesDia?)? onChanged;
  const SearchableDropdown(
      {Key? key, required this.controller, required this.items, this.onChanged})
      : super(key: key);

  @override
  State<SearchableDropdown> createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  ClientesDia? item;
  @override
  Widget build(BuildContext context) {
    return DropdownButton2<ClientesDia>(
      underline: Container(),
      isExpanded: true,
      hint: Text(
        'Seleccionar Cliente',
        style: TextStyle(
          fontSize: 14,
          color: Theme.of(context).hintColor,
        ),
      ),
      items: widget.items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item.codcli.toString() + ' - ' + item.nom,
                    style: const TextStyle(
                      fontSize: 14,
                    )),
              ))
          .toList(),
      value: item,
      onChanged: (value) {
        setState(() {
          item = value;
          print(item);
          widget.onChanged!(value);
        });
      },
      buttonStyleData: const ButtonStyleData(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 212, 212, 212),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 60,
        width: 300,
      ),
      dropdownStyleData: const DropdownStyleData(
        maxHeight: 300,
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 60,
      ),
      dropdownSearchData: DropdownSearchData(
        searchController: widget.controller,
        searchInnerWidgetHeight: 50,
        searchInnerWidget: Container(
          height: 50,
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 4,
            right: 8,
            left: 8,
          ),
          child: TextFormField(
            expands: true,
            maxLines: null,
            controller: widget.controller,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              hintText: 'Buscar',
              hintStyle: const TextStyle(fontSize: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        searchMatchFn: (element, busqueda) {
          if (element.value == null) return false;
          return (element.value!.codcli.toString() +
                  ' - ' +
                  element.value!.nom.toLowerCase())
              .contains(busqueda.toLowerCase());
        },
      ),
      //This to clear the search value when you close the menu
      onMenuStateChange: (isOpen) {
        if (!isOpen) {
          widget.controller.clear();
        }
      },
    );
  }
}
