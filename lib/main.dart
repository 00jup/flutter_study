import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  get screenWidth => null;

  Widget sizedIcon(IconData iconData) {
    return Icon(iconData, size: 50);
  }

  var a = 1;
  List<int> like = [0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Text(a.toString()),
          onPressed: () {
            print(context.findAncestorWidgetOfExactType<MaterialApp>());
            print('1');
            showDialog(
                context: context,
                builder: (context) {
                  return DialogUI(state : a);
                });
          },
        ),
        appBar: AppBar(),
        body: Container(
            child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, i) {
            //print(i); //debuggin 가능함.
            return ListTile(
              leading: Icon(Icons.contact_page),
              title: Text(
                "박정욱",
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w300),
              ),
            );
          },
        )
            //i for문에서 개수 증가하는 것처럼 i가 증가한다. 목록 많이 필요할 때 ListView.builder
            ));
  }
}

class DialogUI extends StatefulWidget {
  const DialogUI({super.key, this.state});
  final state;
  @override
  State<DialogUI> createState() => _DialogUIState();
}

class _DialogUIState extends State<DialogUI> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: SizedBox(
            width: 300,
            height: 300,
            child: Column(
              children: [
                Text(
                  "Contact",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
                TextField(),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel")),
                      TextButton(
                          onPressed: () {}, child: Text("OK")),
                    ],
                  ),
                )
              ],
            )));
  }
}


class bottomLayout extends StatelessWidget {
  const bottomLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.call),
          Icon(Icons.message),
          Icon(Icons.contact_page),
        ],
      ),
    );
  }
}
