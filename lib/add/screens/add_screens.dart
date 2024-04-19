import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => AddState();
}

class AddState extends State<Add> {
  static const String nameKey = 'data';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();


  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 48.0, left: 16, right: 16),
                  child: TextFormField(
                    controller: firstname,
                    obscureText: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter valid numberPlate";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your First Name',
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 48.0, left: 16, right: 16),
                  child: TextFormField(
                    controller: lastname,
                    obscureText: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter valid numberPlate";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your Last Name',
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 48.0, left: 16, right: 16),
                  child: TextFormField(
                    controller: phoneNumber,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      errorMaxLines: 3,
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade400, width: 1),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter valid name';
                      }
                      return null;
                    },
                    cursorColor: Colors.black,
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 48.0, left: 16, right: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        selectDate;
                      },
                      child: const Text('Pick Birth Date'),
                    )),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(title: const Text('Create Contact'), actions: [
        ElevatedButton(
          onPressed: () async {
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setStringList('data', [
              firstname.text,
              lastname.text,
              phoneNumber.text,
              selectedDate.toString()
            ]);
            if (formKey.currentState!.validate()) {
              Future.delayed(Duration.zero)
                  .then((value) => Navigator.pop(context, true));
            }
          },
          child: const Text(
            'Save',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ]),
    );
  }
}
