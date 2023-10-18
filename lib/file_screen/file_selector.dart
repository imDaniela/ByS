import 'package:bys_app/file_screen/add_file_dialog.dart';
import 'package:bys_app/file_screen/file_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:bys_app/general/const.dart';

class FileSelector extends StatelessWidget {
  const FileSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GlobalConstants.rol == 2
          ? FloatingActionButton(
              backgroundColor: Color.fromRGBO(142, 11, 44, 1),
              child: Icon(
                Icons.add,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomFileDialog();
                  },
                );
              })
          : null,
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 60),
              child: Text(
                'Comunicaciones', // Add your label text here
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _Card("Ofertas", CupertinoIcons.money_euro_circle, context),
            _Card("Comunicados", CupertinoIcons.envelope, context),
            _Card("Tarifas", CupertinoIcons.creditcard, context),
            _Card("Documentos", CupertinoIcons.doc_plaintext, context),
          ])),
    );
  }

  Widget _Card(String tipo, IconData icon, BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FileScreen(
                tipo: tipo.toLowerCase(),
              ),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          padding: EdgeInsets.only(right: 30),
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
              color: Color.fromRGBO(142, 11, 44, 1),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(156, 156, 156, 1),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              Expanded(
                child: Text(tipo,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              )
            ],
          ),
        ));
  }
}
