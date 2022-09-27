import 'package:flutter/material.dart';
import 'package:visualizadorpdf/views/visualizador_pdf_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visualizador PDF',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const VisualizadorPdfPage(),
    );
  }
}
