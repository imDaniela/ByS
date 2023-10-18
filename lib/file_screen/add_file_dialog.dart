import 'package:bys_app/clientes_del_dia/bloc/cliente_bloc.dart';
import 'package:bys_app/file_screen/api/file_api.dart';
import 'package:bys_app/file_screen/file_input.dart';
import 'package:bys_app/inicio_sesion/bloc/clientesbloc/clientes_bloc.dart';

import 'package:bys_app/inicio_sesion/bloc/login_bloc.dart';
import 'package:bys_app/inicio_sesion/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import your BLoC package
import 'package:dropdown_search/dropdown_search.dart'; // Import dropdown_search package
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CustomFileDialog extends StatelessWidget {
  int? codcli;
  int? dia = 1;
  int? tarde = 1;
  String? tipo = "ofertas";
  XFile? file;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Añadir Archivo'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            // Searchable Dropdown
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginInitial || state is LogedIn) {
                  List<User> usuarios = [];
                  usuarios.add(User(CODREP: -1, NOM: 'Todos', id_rol: 1));
                  if (state.usuarios != null) {
                    usuarios.addAll(state.usuarios!);
                  }
                  return SearchableDropdown(
                    items: usuarios,
                    controller: controller,
                    onChanged: (cliente) {
                      print(cliente);
                      if (cliente != null) codcli = cliente.CODREP;
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
                if (_dia != null) tipo = _dia.toLowerCase();
              },
            ),
            FileInput(
              onChanged: (archivo) {
                file = archivo;
              },
            )
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
          onPressed: () async {
            // Handle form submission
            print('guardando');
            print(codcli);
            print(tipo);
            print(file);
            if (codcli != null && tipo != null && file != null) {
              http.Response resp =
                  ((await FilesApi.saveArchivo(codcli!, tipo!, file!)));
              if (resp.statusCode == 200) {
                Fluttertoast.showToast(
                    msg: "Se ha guardado el archivo con éxito",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Color.fromARGB(255, 0, 155, 0),
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.pop(context);
              }
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
  final Function(String?)? onChanged;
  const DayDropDown({Key? key, this.onChanged}) : super(key: key);

  @override
  State<DayDropDown> createState() => _DayDropDownState();
}

class _DayDropDownState extends State<DayDropDown> {
  List<String> daysOfWeek = [
    'Ofertas',
    'Comunicados',
    'Tarifas',
    'Documentos',
  ];
  String? tipo;
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
                  widget.onChanged!(newValue);
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
  final List<User> items;
  final Function(User?)? onChanged;
  const SearchableDropdown(
      {Key? key, required this.controller, required this.items, this.onChanged})
      : super(key: key);

  @override
  State<SearchableDropdown> createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  User? item;
  @override
  Widget build(BuildContext context) {
    return DropdownButton2<User>(
      underline: Container(),
      isExpanded: true,
      hint: Text(
        'Seleccionar Usuario',
        style: TextStyle(
          fontSize: 14,
          color: Theme.of(context).hintColor,
        ),
      ),
      items: widget.items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item.NOM,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
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
        height: 40,
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
          return element.value?.NOM
                  .toLowerCase()
                  .contains(busqueda.toLowerCase()) ??
              false;
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
