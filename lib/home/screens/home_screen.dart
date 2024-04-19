import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../add/screens/add_screens.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController search = TextEditingController();
  List<String> person = [];

  @override
  void initState() {
    super.initState();
    getPersonData();
  }

  Future<void> searchBox(String query) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final dataList = sp.getStringList(AddState.nameKey);
    final suggestion = dataList?.where((e) {
      final name = dataList.first.toLowerCase();
      final input = query.toLowerCase();
      return name.contains(input);
    }).toList();
    setState(() {
      person = suggestion!;
    });
  }

  void getPersonData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var details = pref.getStringList(AddState.nameKey);
    final List<String> dummyList = List.from(details ?? []);
    if (dummyList.isNotEmpty) {
      person.addAll(dummyList);
      pref.setStringList(AddState.nameKey, person);
    }
    setState(() {
      //personData = details ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: search,
          obscureText: false,
          decoration: const InputDecoration(
            hintText: 'Search Contact',
            border: OutlineInputBorder(),
            prefixIcon: Icon(CupertinoIcons.search),
          ),
          onChanged: searchBox,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: person.length,
          itemBuilder: (context, index) {
            return SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  person[index],
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Add()),
          ).then(
            (value) {
              if (value) {
                getPersonData();
              }
            },
          );
        },
        child: const Icon(CupertinoIcons.plus),
      ),
    );
  }
}
