import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

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

  getPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      print('허락됨');
      var contacts = await ContactsService.getContacts();
      print(contacts[0].givenName);
    } else if (status.isDenied) {
      print('거절됨');
      Permission.contacts.request();
    }
  }

  Widget sizedIcon(IconData iconData) {
    return Icon(iconData, size: 50);
  }

  var total = 3;
  var name = [
    {'박정욱':'1111'}, {'홍길동':'2222'}, {'피자집':'3333'}
  ];
  List<int> like = [0, 0, 0];
  var new_name = '';

  addNumbers() {
    setState(() {
      total++;
    });
  }

  addName(var new_name) {
    setState(() {
      name.add(new_name);
      name.sort((a,b) => a.keys.first.compareTo(b.keys.first));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    openAppSettings();
    // 연락처 기능이 필요할 때 띄우기
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Text(name[0].keys.first.toString()),
          onPressed: () {
            print(context.findAncestorWidgetOfExactType<MaterialApp>());
            print('1');
            showDialog(
                context: context,
                builder: (context) {
                  return DialogUI(addNumbers: addNumbers, addName: addName);
                });
          },
        ),
        appBar: AppBar(
          title: Text(total.toString()), actions: [
            IconButton(onPressed: (){getPermission();}, icon: Icon(Icons.contacts))
        ],
        ),
        body: Container(
            child: ListView.builder(
          itemCount: total,
          itemBuilder: (context, i) {
            //print(i); //debuggin 가능함.
            return ListTile(
              leading: Icon(Icons.contact_page),
              title:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Text(
                name[i].keys.first.toString(),
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w300),
              ),
                Text(name[i].values.last.toString(),),],),
              trailing: IconButton(icon: Icon(Icons.cancel_outlined), onPressed: (){
                setState(() {
                  name.removeAt(i);
                });
              },)
            );
          },
        )
            //i for문에서 개수 증가하는 것처럼 i가 증가한다. 목록 많이 필요할 때 ListView.builder
            ));
  }
}

class DialogUI extends StatelessWidget {
  DialogUI({super.key, this.addNumbers, this.addName});

  final addNumbers, addName;
  var inputData;

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
                TextField(
                  onChanged: (text) {
                    inputData = text;
                  },
                ),
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
                            if(inputData != Null){
                              addNumbers();
                              addName(inputData);
                              Navigator.pop(context);
                            }

                          },
                          child: Text("OK")),
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
