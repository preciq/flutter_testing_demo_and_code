import 'dart:convert';

import 'package:flutter_testing_demo_and_code/fetch_album_network.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum(http.Client client) async {
  final response = await client.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
  );
  if (response.statusCode == 200) {
    // Parse JSON on success
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // Throw on failure
    throw Exception('Failed to load album');
  }
}
