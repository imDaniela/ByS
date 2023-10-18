import 'package:bys_app/general/const.dart';
import 'package:bys_app/inicio_sesion/bloc/clientesdia/bloc/clientesdia_bloc.dart';
import 'package:bys_app/inicio_sesion/bloc/login_bloc.dart';
import 'package:bys_app/inicio_sesion/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                ),
                Center(
                    child: Text(
                  GlobalConstants.name?.trim() ?? '',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )),
                SizedBox(
                  height: 40,
                ),
                GlobalConstants.rol == 2
                    ? BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state_login) => Container(
                            margin: EdgeInsets.only(
                                bottom: 20, left: 20, right: 20),
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: const Color.fromRGBO(
                                  212, 212, 212, 1), // Set the background color
                            ),
                            child: DropdownButton<User>(
                              isExpanded: true,
                              value: dropdownValue,
                              elevation: 16,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              underline: Container(
                                width: double.infinity,
                                height: 0,
                                color: Colors.transparent,
                              ),
                              onChanged: (User? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownValue = value!;
                                  GlobalConstants.codrep =
                                      dropdownValue?.CODREP;
                                });
                              },
                              items: state_login is LoginInitial ||
                                      state_login is LogedIn
                                  ? state_login.usuarios
                                      ?.map<DropdownMenuItem<User>>(
                                          (User value) {
                                      return DropdownMenuItem<User>(
                                        value: value,
                                        child: Text(value.NOM),
                                      );
                                    }).toList()
                                  : [],
                            )))
                    : Container(),
                Container(
                    width: double.infinity,
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    margin: const EdgeInsets.only(
                      left: 40.0, // Set the left margin value
                      top: 40.0, // Set the top margin value
                      right: 40.0, // Set the right margin value
                      bottom: 10.0, // Set the bottom margin value
                    ),
                    child: ElevatedButton(
                      child: const Text('Cerrar sesion'),
                      onPressed: () {
                        context.read<LoginBloc>().add(LogOut());

                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('login', (route) => false);
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
