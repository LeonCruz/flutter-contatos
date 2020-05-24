import 'dart:io';
import 'package:contatos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class ContactDetail extends StatefulWidget {
  @override
  _ContactDetailState createState() => _ContactDetailState();

  final Contact contact;
  ContactDetail({this.contact});
}

class _ContactDetailState extends State<ContactDetail> {
  Contact _editedContact;

  final _nameFocus = FocusNode();

  final _nameController =  TextEditingController();
  final _emailController =  TextEditingController();
  final _phoneController =  TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact.toMap());
      _nameController.text = _editedContact.name;
      _emailController.text = _editedContact.email;
      _phoneController.text = _editedContact.phone;
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editedContact.name ?? 'Novo Contato'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.save),
        onPressed: () {
          if (_editedContact.name != null && _editedContact.name.isNotEmpty) {
            Navigator.pop(context, _editedContact);
          }
          else {
            FocusScope.of(context).requestFocus(_nameFocus);
          }
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: _editedContact.img != null
                            ? FileImage(File(_editedContact.img))
                            : AssetImage('lib/assets/person.png'))),
              ),
            ),
            TextField(
              focusNode: _nameFocus,
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
              onChanged: (text) {
                setState(() {
                  _editedContact.name = text;
                });
              },
            ),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email', 
              ),
              onChanged: (text) {
                _editedContact.email = text;
              },
            ),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Telefone',
              ),
              onChanged: (text) {
                _editedContact.phone = text;
              },
            ),
          ],
        ),
      ),
    );
  }
}
