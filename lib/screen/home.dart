import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoice/service/pdf_service.dart';

class HoneScreen extends StatefulWidget {
  const HoneScreen({super.key});

  @override
  State<HoneScreen> createState() => _HoneScreenState();
}

class _HoneScreenState extends State<HoneScreen> {
  final PdfService pdfService = PdfService();
  List _orders = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/orders.json');
    final data = await json.decode(response);
    setState(() {
      _orders = data["orders"];
    });
  }

  @override
  void initState() {
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              final data = await pdfService.genrragePdf();
              pdfService.savePdfFile('Invoice PDF', data);
            },
            child: Text('Generate PDF')),
      ),
    );
  }
}
