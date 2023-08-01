import 'package:bys_app/file_screen/ImageDialog.dart';
import 'package:bys_app/file_screen/bloc/file_bloc.dart';
import 'package:bys_app/file_screen/pdf_screen.dart';
import 'package:bys_app/general/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FileScreen extends StatefulWidget {
  const FileScreen({Key? key}) : super(key: key);

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FileBloc>().add(Loadfiles());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<FileBloc, FileState>(builder: (context, state) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 60),
            child: Text(
              'Comunicaciones', // Add your label text here
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          state is FileList
              ? Expanded(
                  child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 240,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: state.archivos.length,
                  itemBuilder: (context, index) {
                    return FileCard(context, state.archivos[index]);
                  },
                ))
              : Container()
        ],
      );
    }));
  }

  List<Widget> Files(BuildContext context, List<String>? archivos) {
    List<Widget> result = [];
    if (archivos == null) return [];
    archivos.forEach((element) {
      result.add(FileCard(context, element));
    });
    return result;
  }

  Widget FileCard(BuildContext context, String element) {
    String extension = element.split(".")[1];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
          onTap: () {
            if (extension == "pdf") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PdfScreen(
                      '${GlobalConstants.apiEndPoint}get-archivo/${element}'),
                ),
              );
            } else {
              showImageDialog(context,
                  '${GlobalConstants.apiEndPoint}get-archivo/${element}');
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
                        imageUrl:
                            '${GlobalConstants.apiEndPoint}get-archivo/${element}',
                        height: 200,
                        httpHeaders: GlobalConstants.header(),
                      )),
            SizedBox(
              height: 15,
            ),
            Text(element)
          ])),
    );
  }
}
