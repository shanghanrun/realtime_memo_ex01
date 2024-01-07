import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtime_memo_ex01/memo_add_page.dart';
import 'package:realtime_memo_ex01/model/memo.dart';

class MemoPage extends StatefulWidget {
  const MemoPage({super.key});

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  DatabaseReference? dbRef;
  DatabaseReference? ref;
  // String dbUrl =   이제 주소는 사용하지 않는다.
  List<Memo> memos = [];

  @override
  void initState() {
    // initState는 async 못한다.
    super.initState();
    // FirebaseDatabase.initializeApp()은 await로 해야 되지만
    // 이미 main에서 했기 때문에 안해도 된다.
    dbRef = FirebaseDatabase.instance.ref(); // 인스턴스생성은 await필요없다.
    ref = dbRef!.child('memo');

    ref!.onChildAdded.listen((event) {
      print(event.snapshot.value
          .toString()); //리얼타임은 snapshot.value, 파이어스토어는 snapshot.data
      setState(() {
        memos.add(Memo.fromSnapshot(event.snapshot));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('메모 앱')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MemoAddPage(ref!)));
        },
      ),
      body: Container(
        child: Center(
          child: memos.isEmpty
              ? const CircularProgressIndicator()
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.5, // 가로:세로 비율
                  ),
                  itemCount: memos.length,
                  itemBuilder: (context, i) {
                    final memo = memos[i];
                    return Card(
                      child: GridTile(
                        header: Text(
                          memo.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        footer: Text(memo.createTime.substring(0, 10)),
                        child: Container(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: SingleChildScrollView(
                            child: GestureDetector(
                              child: Text(memo.content),
                              onTap: () async {
                                //메모 상세보기 화면으로 이동
                                Memo? modifiedMemo = await Navigator.of(context)
                                    .push(MaterialPageRoute<Memo>(
                                        builder: (context) =>
                                            MemoDetailPage(ref!, memo)));
                              },
                              onLongPress: () {
                                // 메모 삭제 기능
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                          title: Text(memo.title),
                                          content: const Text('정말 삭제하시겠습니까?'),
                                          actions: [TextButton()]);
                                    });
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}
