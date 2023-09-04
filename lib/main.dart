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

  Widget sizedIcon(IconData iconData) {
    return Icon(iconData, size: 100);
  }

  var total = 3;
  List<Map<String, String>> contacts = [
    {'name': '박정욱', 'phone': '01054333333'},
    {'name': 'hello', 'phone': '011111'},
    {'name': 'pizza', 'phone': '01022222222'}
  ];

  addName(String input1, String input2) {
    setState(() {
      total++;
      var newPerson = Contact(
          givenName: input1, phones: [Item(label: 'mobile', value: input2)]);
      ContactsService.addContact(newPerson);
      contacts.add({'name': input1, 'phone': input2});
      // newPerson.givenName = input1;
      // newPerson.phones = input2 as List<Item>?;
      // ContactsService.addContact(newPerson);
      // name.add(input1);
    });
  }

  getPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      print('허락됨');
      var contacts = await ContactsService.getContacts();

      print(contacts[0].givenName);
      print(contacts[0].phones);
    } else if (status.isDenied) {
      print('거절됨');
      Permission.contacts.request();
    }
  }

////Applications/Android\Studio.app/Contents/jbr/Contents/Home/bin/keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
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
        child: Text(contacts[0]['name'].toString()),
        onPressed: () {
          print(context.findAncestorWidgetOfExactType<MaterialApp>());
          showDialog(
            context: context,
            builder: (context) {
              return DialogUI(addName: addName);
            },
          );
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(total.toString()),
        actions: [
          IconButton(
              onPressed: () {
                getPermission();
              },
              icon: Icon(Icons.contacts))
        ],
      ),
      body: Container(
          child: ListView.builder(
        itemCount: total,
        itemBuilder: (context, i) {
          //print(i); //debuggin 가능함.
          return ListTile(
            leading: Icon(Icons.contact_page),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  contacts[i]['name'].toString(),
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w300),
                ),
                Text(
                  contacts[i]['phone'].toString(),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.cancel_outlined),
              onPressed: () {
                setState(
                  () {
                    contacts.removeAt(i);
                    total--;
                  },
                );
              },
            ),
          );
        },
      )
          //i for문에서 개수 증가하는 것처럼 i가 증가한다. 목록 많이 필요할 때 ListView.builder
          ),
    );
  }
}

class DialogUI extends StatelessWidget {
  DialogUI({super.key, this.addName});

  final Function(String, String)? addName;
  var inputData1, inputData2;

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
                      inputData1 = text;
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: "이름을 입력하세요",
                      filled: true,
                      fillColor: Colors.blue.shade100,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    )),
                TextField(
                    onChanged: (text) {
                      inputData2 = text;
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.phone),
                      hintText: "전화번호를 입력하세요",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    )),
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
                            if (inputData1 != Null && inputData2 != Null) {
                              addName!(inputData1, inputData2);
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
