import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:nytimes/models/results.dart';

class PostsRepository {
  Future<List<Results>> getPosts() async {
    final response = await get(Uri.parse(
        'https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=tuGR3D5e8ooU0VysO6Wvki9OwKXOx0xW'));
    if (response.statusCode == 200) {
      Results result = Results();
      List<Results> results = List<Results>();
      List<Results> resultsNoMedia = List<Results>();

      final parsed = json.decode(response.body);
      List data = parsed["results"];

      data.forEach((element) {
        result = Results.fromJson(element);
        if (result.media.isEmpty)
          resultsNoMedia.add(result);
        else {
          result.pic = result.media.first.mediaMetadata[2].url;
          print(result.pic);
          results.add(result);
        }
      });

      var newReasult = results + resultsNoMedia;
      newReasult.sort((a, b) => a.publishedDate.compareTo(b.publishedDate));

      return newReasult;
    }
  }
}
