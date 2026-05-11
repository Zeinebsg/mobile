import 'package:http/http.dart' as http;

Future<http.StreamedResponse> getStreamedResponse(http.BaseRequest request) async {
  return await request.send();
}