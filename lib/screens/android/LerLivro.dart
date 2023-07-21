import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:flutter/services.dart';

class LerLivro extends StatefulWidget {
  final File file;
  const LerLivro({Key? key, required this.file}) : super(key: key);

  @override
  State<LerLivro> createState() => _LerLivroState();
}

class _LerLivroState extends State<LerLivro> {

  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);

    return MaterialApp(
      title: 'Ler livro',
      home: Scaffold(
          appBar: AppBar(
              title: Text('Ler livro'),
              backgroundColor: Colors.grey.shade800,
              leading: BackButton(
                onPressed: () =>
                    Navigator.of(context).pop()
              ),
              actions: <Widget>[
                IconButton(
                    onPressed: () =>
                        Navigator.of(context).pushReplacementNamed('/'),
                    icon: const Icon(Icons.exit_to_app))
              ]),
          body: PDFView(
            filePath: widget.file.path,
            swipeHorizontal: true,

          )
      ),
    );
  }
}
