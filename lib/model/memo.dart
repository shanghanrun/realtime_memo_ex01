import 'package:firebase_database/firebase_database.dart';

class Memo {
  String? key;
  String title;
  String content;
  String createTime;

  Memo(this.title, this.content, this.createTime);

  Memo.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = (snapshot.value as Map<dynamic, dynamic>?)?['title'],
        content = (snapshot.value as Map<dynamic, dynamic>?)?['content'],
        createTime =
            (snapshot.value as Map<dynamic, dynamic>?)?['createTime'] ?? '';

  toJson() {
    return {
      'title': title,
      'content': content,
      'createTime': createTime,
    };
  }
}
