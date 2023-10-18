import 'package:bys_app/file_screen/ImageDialog.dart';
import 'package:bys_app/file_screen/api/file_api.dart';
import 'package:bys_app/file_screen/bloc/file_bloc.dart';
import 'package:bys_app/file_screen/delete_dialog.dart';
import 'package:bys_app/file_screen/pdf_screen.dart';
import 'package:bys_app/general/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bys_app/file_screen/modelo/Archivo.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class FileScreen extends StatefulWidget {
  final String tipo;
  const FileScreen({Key? key, required this.tipo}) : super(key: key);

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FileBloc>().add(Loadfiles(widget.tipo));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color.fromRGBO(142, 11, 44, 1),
            title: Text(
              widget.tipo[0].toString().toUpperCase() +
                  widget.tipo.substring(1).toLowerCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 35),
              onPressed: () => {Navigator.pop(context)},
            )),
        body: BlocBuilder<FileBloc, FileState>(builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: 20,
              ),
              state is FileList
                  ? Expanded(
                      child: RefreshIndicator(
                          onRefresh: () async {
                            context
                                .read<FileBloc>()
                                .add(Loadfiles(widget.tipo));
                          },
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 300,
                                    mainAxisExtent: 300,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            itemCount: state.archivos.length,
                            itemBuilder: (context, index) {
                              return FileCard(context, state.archivos[index]);
                            },
                          )))
                  : Container()
            ],
          );
        }));
  }

  List<Widget> Files(BuildContext context, List<Archivo>? archivos) {
    List<Widget> result = [];
    if (archivos == null) return [];
    archivos.forEach((element) {
      result.add(FileCard(context, element));
    });
    return result;
  }

  Widget FileCard(BuildContext context, Archivo element) {
    String extension = element.nombre.split(".")[1];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
          onLongPress: (() {
            if (GlobalConstants.rol != 2) return;
            DeleteDialog.showDeleteDialog(context, onDelete: () async {
              print(element.url);
              Response resp = await FilesApi.deleteArchivoFromUrl(element);
              if (resp.statusCode == 200) {
                Fluttertoast.showToast(
                    msg: "Se ha eliminado el archivo con éxito",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Color.fromARGB(255, 0, 155, 0),
                    textColor: Colors.white,
                    fontSize: 16.0);
                context.read<FileBloc>().add(Loadfiles(widget.tipo));
              }
            });
          }),
          onTap: () {
            if (extension == "pdf") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PdfScreen(element.url),
                ),
              );
            } else {
              showImageDialog(context, element.url);
            }
          },
          child: Column(children: [
            Container(
                height: 140,
                child: extension == "pdf"
                    ? Icon(
                        Icons.picture_as_pdf,
                        size: 90,
                      )
                    : CachedNetworkImage(
                        imageUrl: element.url,
                        fit: BoxFit.fitHeight,
                        height: 140,
                        httpHeaders: GlobalConstants.header(),
                      )),
            SizedBox(
              height: 15,
            ),
            Text(element.nombre)
          ])),
    );
  }
}
