import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _upload() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'],
      );
      if (result != null) {
        final dio = Dio();
        final file = result.files.first;
        FormData formData = FormData.fromMap({
          "file": MultipartFile.fromBytes(file.bytes!, filename: file.name),
        });

        var res = await dio.post(
          'https://myapi.raphaelpontes2.repl.co/file-upload',
          data: formData,
        );
        print(res.data);
      } else {
        print("result is null");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            //
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _upload,
        tooltip: 'Upload',
        child: const Icon(Icons.upload_file),
      ),
    );
  }
}
