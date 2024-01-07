import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtime_memo_ex01/model/memo.dart';

class MemoAddPage extends StatefulWidget {
  final DatabaseReference ref;
  const MemoAddPage(this.ref, {super.key});

  @override
  State<MemoAddPage> createState() => _MemoAddPageState();
}

class _MemoAddPageState extends State<MemoAddPage> {
  TextEditingController? titleController;
  TextEditingController? contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('메모 추가')),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                    labelText: '제목', fillColor: Colors.blue),
              ),
              Expanded(
                child: TextField(
                  controller: contentController,
                  decoration: const InputDecoration(
                      labelText: '내용', fillColor: Colors.blue),
                  maxLines: 100,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              MaterialButton(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2)),
                  onPressed: () {
                    widget.ref
                        .push()
                        .set(Memo(
                                titleController!.value.text,
                                contentController!.value.text,
                                DateTime.now().toIso8601String())
                            .toJson())
                        .then((_) {
                      Navigator.of(context).pop();
                    });
                  },
                  child: const Text('저장하기')),
            ],
          ),
        ),
      ),
    );
  }
}
