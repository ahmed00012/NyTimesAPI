import 'package:nytimes/models/mediaMetadata.dart';

class Media {
  List<MediaMetadata> mediaMetadata;

  Media({
        this.mediaMetadata});

  Media.fromJson(Map<String, dynamic> json) {
    var list= json['media-metadata'] as List;
    List<MediaMetadata> metadataList = list.map((metadata)=>MediaMetadata.fromJson(metadata)).toList();

    mediaMetadata = metadataList;

  }


}