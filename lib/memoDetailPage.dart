import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtime_memo_ex01/model/memo.dart';

class MemoDetailPage extends StatefulWidget {
  final DatabaseReference ref;
  final Memo memo;
  const MemoDetailPage(this.ref, this.memo, {super.key});

  @override
  State<MemoDetailPage> createState() => _MemoDetailPageState();
}

class _MemoDetailPageState extends State<MemoDetailPage> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.memo.title);
    contentController = TextEditingController(text: widget.memo.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.memo.title)),
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
                  decoration: const InputDecoration(labelText: '내용'),
                  maxLines: 100,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              MaterialButton(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2)),
                  onPressed: () {
                    final memo = Memo(titleController.value.text,
                        contentController.value.text, widget.memo.createTime);
                    widget.ref
                        .child(widget.memo.key!)
                        .set(memo.toJson())
                        .then((_) {
                      Navigator.of(context).pop(memo);
                    });
                  },
                  child: const Text('수정하기')),
            ],
          ),
        ),
      ),
    );
  }
}
