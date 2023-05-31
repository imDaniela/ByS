import 'package:flutter/material.dart';
import 'package:bys_app/clientes_del_dia/list_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bys_app/inicio_sesion/bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

const List<String> list = <String>['One', 'Two'];

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Image.asset('assets/images/bys_logo.png',
                        width: 200, height: 200)),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          'Nombre de usuario', // Add your label text here
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue,
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                      // TextField(
                      //     controller: nameController,
                      //     cursorColor: const Color.fromRGBO(142, 11, 44, 1),
                      //     decoration: InputDecoration(
                      //       border: OutlineInputBorder(
                      //         borderSide: BorderSide.none,
                      //         borderRadius: BorderRadius.circular(50.0),
                      //       ),
                      //       filled: true, // Enable filling the TextField background
                      //       fillColor: const Color.fromRGBO(
                      //           212, 212, 212, 1), // Set the background color
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide: const BorderSide(
                      //             color: Color.fromRGBO(142, 11, 44,
                      //                 1)), // Set the border color when focused
                      //         borderRadius: BorderRadius.circular(50.0),
                      //       ),
                      //     )),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            'Contraseña', // Add your label text here
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      TextField(
                          obscureText: true,
                          controller: passwordController,
                          cursorColor: const Color.fromRGBO(142, 11, 44, 1),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            filled:
                                true, // Enable filling the TextField background
                            fillColor: const Color.fromRGBO(
                                212, 212, 212, 1), // Set the background color
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(142, 11, 44,
                                      1)), // Set the border color when focused
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    margin: const EdgeInsets.only(
                      left: 40.0, // Set the left margin value
                      top: 40.0, // Set the top margin value
                      right: 40.0, // Set the right margin value
                      bottom: 10.0, // Set the bottom margin value
                    ),
                    child: ElevatedButton(
                      child: const Text('Ingresar'),
                      onPressed: () {
                        context.read<LoginBloc>().add(AuthenticateCredentias(
                            username: '1', password: passwordController.text));
                        // print(nameController.text);
                        // print(passwordController.text);
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => View()),
                        );*/
                      },
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(142, 11, 44,
                              1), // Set the background color using full hexadecimal color code
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                50), // Set the border radius value
                          )),
                    )),
              ],
            )));
  }
}
