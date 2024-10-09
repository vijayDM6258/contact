import 'package:contact/model/Contact.dart';
import 'package:contact/provider/contact_provider.dart';
import 'package:contact/util/global.dart';
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
      body: Padding(
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
            )
          ],
        ),
      ),
    );
  }
}
