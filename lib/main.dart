import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
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
    return MaterialApp(
        home: Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text(a.toString()),
        onPressed: () {
          setState(() {
            a++;
          });
        },
      ),
      appBar: AppBar(),
      body: Container(
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, i) {
                //print(i); //debuggin 가능함.
                return Container(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(like[i].toString()),
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          "홍길동",
                          style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w300),
                        ),

                        TextButton(onPressed: (){
                          setState(() {
                            like[i]++;
                          });
                        }, child: Container(
                          child: Text("좋아요"),
                        ))
                      ],
                    )); //i for문에서 개수 증가하는 것처럼 i가 증가한다. 목록 많이 필요할 때 ListView.builder
              })),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.all(10.0),
        child: bottomLayout(),
      ),
    ));
  }
}

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}
var like = 0;

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(like.toString()),
            SizedBox(
              width: 40,
            ),
            Text(
              "홍길동",
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w300),
            ),

            TextButton(onPressed: (){
              setState(() {
                like++;
              });
            }, child: Container(
              child: Text("좋아요"),
            ))
          ],
        ));
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
