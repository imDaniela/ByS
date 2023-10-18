import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class FileInput extends StatefulWidget {
  final Function(XFile? file) onChanged;
  const FileInput({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<FileInput> createState() => _FileInputState();
}

class _FileInputState extends State<FileInput> {
  XFile? _selectedImage;
  Future<void> _pickImage() async {
    XFile? pickedFile;
    final FilePickerResult? file_result = await FilePicker.platform.pickFiles();
    if (file_result?.files.single.path != null) {
      pickedFile = XFile(file_result!.files.single.path!);
      widget.onChanged(pickedFile);
    }
    setState(() {
      _selectedImage = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _pickImage();
      },
      child: Container(
        width: double.infinity,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(top: 20),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color.fromRGBO(212, 212, 212, 1),
        ),
        child: _selectedImage == null
            ? Text("Seleccione una imagen")
            : Text(_selectedImage!.name),
      ),
    );
  }
}
