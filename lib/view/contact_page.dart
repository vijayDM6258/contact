import 'package:contact/model/Contact.dart';
import 'package:contact/provider/contact_provider.dart';
import 'package:contact/util.dart';
import 'package:contact/util/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<ContactProvider>(
        builder: (BuildContext context, ContactProvider value, Widget? child) {
          if (value.contactList.isEmpty) {
            return Center(
              child: Text(
                "No Contact",
                style: TextStyle(fontSize: 50),
              ),
            );
          }
          return ListView.builder(
            itemCount: value.contactList.length,
            itemBuilder: (context, index) {
              Contact contact = value.contactList[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text("${contact.name?.split("").first}"),
                ),
                title: Text(
                  contact.name ?? "",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  contact.number ?? "",
                  style: TextStyle(color: Colors.grey),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, PageName.addContact,
                              arguments: index);
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          value.removeContact(index);
                        },
                        icon: Icon(Icons.delete)),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, PageName.addContact);
        },
      ),
    );
  }
}
