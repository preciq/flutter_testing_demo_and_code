import 'dart:convert';
import 'package:http/http.dart' as http;

/// Sample Album class to demonstrate fetching data from the network and parsing JSON.
class Album {
  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  final int userId;
  final int id;
  final String title;

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'id': id,
    'title': title,
  };
}

/// Sample function to fetch an album from the network using the http package.
Future<Album> fetchAlbum(http.Client client) async {
  final response = await client.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
  );
  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
