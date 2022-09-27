import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class VisualizadorPdfPage extends StatefulWidget {
  const VisualizadorPdfPage({super.key});

  @override
  State<VisualizadorPdfPage> createState() => _VisualizadorPdfPageState();
}

class _VisualizadorPdfPageState extends State<VisualizadorPdfPage> {
  PdfController? pdfController;
  int paginaAtual = 0;
  int totalDePaginas = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
            title: const Text(
              "Visualizador de PDF",
            ),
            actions: [
              if (pdfController != null)
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('$paginaAtual de $totalDePaginas'),
                ))
            ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            FilePickerResult? resultado = await FilePicker.platform.pickFiles();
            setState(() {
              if (resultado != null) {
                pdfController = null;
                pdfController = PdfController(
                    document:
                        PdfDocument.openFile(resultado.files.single.path!));
              }
            });
          },
          tooltip: 'Selecionar',
          child: const Icon(Icons.note_add_rounded),
        ),
        body: pdfController != null
            ? PdfView(
                controller: pdfController!,
                scrollDirection: Axis.vertical,
                documentLoader: const SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
                onDocumentLoaded: (document) {
                  setState(() {
                    totalDePaginas = document.pagesCount;
                  });
                },
                onPageChanged: (page) {
                  setState(() {
                    paginaAtual = page;
                  });
                },
                renderer: (PdfPage page) => page.render(
                  width: page.width,
                  height: page.height,
                  backgroundColor: '#FFFFFF',
                ),
              )
            : const SizedBox(
                child: Center(
                    child: Text(
                  'Selecione um arquivo tocando no botão flutuante.',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
              ));
  }
}
