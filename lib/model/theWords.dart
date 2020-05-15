import 'model.dart';

class Words extends Model {

  static String table = 'words';

  int id;
  String word;

  Words({ this.id, this.word });

  Map<String, dynamic> toMap() {

    Map<String, dynamic> map = {
      'word': word,
    };

    if (id != null) { map['id'] = id; }
    return map;
  }

  static Words fromMap(Map<String, dynamic> map) {

    return Words(
        id: map['id'],
        word: map['word'],
    );
  }
}