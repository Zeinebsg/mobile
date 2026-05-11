import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiNinjasQrWidget extends StatefulWidget {
  final String qrData;
  final double width;
  final double height;
  final EdgeInsetsGeometry? padding;

  const ApiNinjasQrWidget({
    super.key,
    required this.qrData,
    this.width = 220.0,
    this.height = 220.0,
    this.padding,
  });

  @override
  State<ApiNinjasQrWidget> createState() => _ApiNinjasQrWidgetState();
}

class _ApiNinjasQrWidgetState extends State<ApiNinjasQrWidget> {
  late Future<Uint8List> _qrImageFuture;

  @override
  void initState() {
    super.initState();
    _qrImageFuture = _fetchQrCode();
  }

  Future<Uint8List> _fetchQrCode() async {
    final String apiKey = 'anIAV9MBU8YYKdqr4KtBCj3guQT7LVrkcodjRUjC';
    final String encodedData = Uri.encodeComponent(widget.qrData);
    final String url =
        'https://api.api-ninjas.com/v1/qrcode?data=$encodedData&format=png';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'X-Api-Key': apiKey,
          'Accept': 'image/png',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        throw Exception('Failed to fetch QR code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching QR code: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: _qrImageFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: widget.width,
            height: widget.height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return SizedBox(
            width: widget.width,
            height: widget.height,
            child: Center(
              child: Icon(
                Icons.qr_code_2_rounded,
                size: 64.0,
                color: Colors.grey,
              ),
            ),
          );
        } else if (snapshot.hasData) {
          return Padding(
            padding: widget.padding ?? EdgeInsets.zero,
            child: Image.memory(
              snapshot.data!,
              width: widget.width,
              height: widget.height,
              fit: BoxFit.cover,
            ),
          );
        } else {
          return SizedBox(
            width: widget.width,
            height: widget.height,
            child: const Center(
              child: Icon(Icons.qr_code_2_rounded),
            ),
          );
        }
      },
    );
  }
}
