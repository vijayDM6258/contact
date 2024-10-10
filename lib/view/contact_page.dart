import 'package:contact/model/Contact.dart';
import 'package:contact/provider/contact_provider.dart';
import 'package:contact/util.dart';
import 'package:contact/util/global.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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
                          launchUrl(Uri.parse("tel:${contact.number}"));
                        },
                        icon: Icon(Icons.call)),
                    PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Row(
                              children: [Icon(Icons.edit), Text("Edit")],
                            ),
                            value: "edit",
                          ),
                          PopupMenuItem(
                            child: Row(
                              children: [Icon(Icons.delete), Text("Delete")],
                            ),
                            value: "delete",
                          ),
                          PopupMenuItem(
                            child: Row(
                              children: [Icon(Icons.share), Text("Share")],
                            ),
                            value: "share",
                          ),
                          PopupMenuItem(
                            child: Row(
                              children: [Icon(Icons.mail), Text("Email")],
                            ),
                            value: "mail",
                          ),
                        ];
                      },
                      onSelected: (val) {
                        print("onSelected $val");
                        if (val == "edit") {
                          Navigator.pushNamed(context, PageName.addContact,
                              arguments: index);
                        }
                        if (val == "delete") {
                          value.removeContact(index);
                        }
                        if (val == "mail") {
                          launchUrl(Uri.parse("mailto:${contact.email}"));
                        }
                        if (val == "share") {
                          String shareText =
                              "Please call me i am waiting ${contact.number}";
                          Share.share(shareText);
                          Share.shareXFiles([XFile("path")]);
                        }
                      },
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          LocalAuthentication authentication = LocalAuthentication();
          if (await authentication.isDeviceSupported()) {
            print("isDeviceSupported");
            bool isAuth = await authentication.authenticate(
                localizedReason: "Please authenticate to add Contact");
            if (isAuth) {
              Navigator.pushNamed(context, PageName.addContact);
            }
            print("isAuth $isAuth");
          } else {
            print("isDeviceSupported false");
          }
        },
      ),
    );
  }
}
