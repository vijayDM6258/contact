import 'package:contact/model/Contact.dart';
import 'package:contact/provider/contact_provider.dart';
import 'package:contact/util/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  int? editIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    editIndex = ModalRoute.of(context)?.settings.arguments as int?;
    if (editIndex != null) {
      Contact contact = Provider.of<ContactProvider>(context, listen: false)
          .contactList[editIndex!];
      nameController.text = contact.name ?? "";
      numberController.text = contact.number ?? "";
      emailController.text = contact.email ?? "";
      addressController.text = contact.address ?? "";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Name",
                ),
              ),
              TextFormField(
                controller: numberController,
                decoration: InputDecoration(
                  hintText: "Number",
                ),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                ),
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  hintText: "Address",
                ),
              ),
              TextFormField(
                controller: dobController,
                decoration: InputDecoration(
                  hintText: "Select DOB",
                ),
                readOnly: true,
                onTap: () async {
                  print("Select DOB");
                  DateTime? selectDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2005),
                      currentDate: DateTime.now(),
                      lastDate: DateTime(2050));
                  print("selectDate $selectDate");
                  if (selectDate != null) {
                    dobController.text =
                        "${selectDate?.day ?? ""}- ${selectDate?.month ?? ""}- ${selectDate?.year ?? ""}";
                  }
                },
              ),
              TextFormField(
                controller: timeController,
                decoration: InputDecoration(
                  hintText: "Select Time",
                ),
                readOnly: true,
                onTap: () async {
                  TimeOfDay? time = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  if (time != null) {
                    timeController.text = "${time.hour}:${time.minute}";
                  }
                },
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  print(nameController.text);
                  print(numberController.text);
                  print(emailController.text);
                  print(addressController.text);

                  Contact con = Contact(
                    name: nameController.text,
                    number: numberController.text,
                    email: emailController.text,
                    address: addressController.text,
                  );

                  if (editIndex == null) {
                    Provider.of<ContactProvider>(context, listen: false)
                        .addContact(con);
                  } else {
                    Provider.of<ContactProvider>(context, listen: false)
                        .editContact(con, editIndex!);
                  }

                  nameController.clear();
                  numberController.clear();
                  emailController.clear();
                  addressController.clear();
                  Navigator.pop(context);
                },
                child: Text(editIndex != null ? "Edit Contact" : "Add Contact"),
              ),
              Container(
                height: 350,
                color: Colors.black12,
                child: CupertinoDatePicker(
                  // use24hFormat: true,
                  mode: CupertinoDatePickerMode.time,
                  onDateTimeChanged: (value) {
                    print("onDateTimeChanged ${value}");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
