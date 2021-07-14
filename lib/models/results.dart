import 'package:nytimes/models/media.dart';

class Results {
  String source;
  String publishedDate;
  String byline;
  String title;
  String abstract;
  List<Media> media;
  String pic;

  Results({

        this.source,
        this.publishedDate,
        this.byline,
        this.title,
        this.abstract,
        this.media,
  this.pic});

 factory Results.fromJson(Map<String, dynamic> json) {
   var list= json['media'] as List;
   List<Media> mediaList = list.map((media)=>Media.fromJson(media)).toList();

    return Results(
      source: json['source'],
      publishedDate: json['published_date'],
      byline: json['byline'],
      title: json['title'],
      abstract: json['abstract'],
        media: mediaList,);

  }


}