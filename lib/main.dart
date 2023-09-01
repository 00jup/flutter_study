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

  var total = 3;
  var name = ['박정욱', '홍길동', '피자집'];
  List<int> like = [0, 0, 0];

  addNumbers() {
    setState(() {
      total++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Text(name[0].toString()),
          onPressed: () {
            print(context.findAncestorWidgetOfExactType<MaterialApp>());
            print('1');
            showDialog(
                context: context,
                builder: (context) {
                  return DialogUI(addNumbers : addNumbers);
                });
          },
        ),
        appBar: AppBar(title: Text(total.toString()),),
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

class DialogUI extends StatelessWidget {
  const DialogUI({super.key, this.addNumbers});

  final addNumbers;

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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
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
                          onPressed: () {
                            addNumbers();
                          }, child: Text("OK")),
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
