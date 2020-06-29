import 'dart:convert';
import 'dart:io';

import 'package:contactsapp/src/home/home_bloc.dart';
import 'package:contactsapp/src/home/home_module.dart';
import 'package:contactsapp/src/shared/repository/contact_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masked_text/masked_text.dart';
import 'package:file_picker/file_picker.dart';

import '../app_module.dart';

class AddPage extends StatefulWidget {
  static String tag = 'add-page';
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  final _cFirstName = TextEditingController();
  final _cLastName = TextEditingController();
  final _cJob = TextEditingController();
  final _cPhoneNumber = TextEditingController();
  final _cEmail = TextEditingController();
  final _cComments = TextEditingController();
  final _cAge = TextEditingController();
  final _cGender = TextEditingController();
  String gender;
  String photoBase64;
  HomeBloc bloc;
  ContactRepository contactRepository;

  @override
  void initState() {
    bloc = HomeModule.to.getBloc<HomeBloc>();
    contactRepository = AppModule.to.getDependency<ContactRepository>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextFormField inputFirstName = TextFormField(
      controller: _cFirstName,
      autofocus: true,
      keyboardType: TextInputType.text,
      inputFormatters: [
        LengthLimitingTextInputFormatter(45),
      ],
      decoration: InputDecoration(
        labelText: 'Prénom',
        icon: Icon(Icons.person),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Champ requis';
        }
        return null;
      },
    );

    TextFormField inputLastName = TextFormField(
      controller: _cLastName,
      keyboardType: TextInputType.text,
      inputFormatters: [
        LengthLimitingTextInputFormatter(25),
      ],
      decoration: InputDecoration(
        labelText: 'Nom',
        icon: Icon(Icons.person),
      ),
    );

    DropdownButtonFormField dropDownGender = new DropdownButtonFormField<String>(
      hint: Text('Genre'),
      value: gender,
      items: <String>['Homme', 'Femme', 'Autre'].map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
      onChanged: (String value){
        setState(() {
          gender = value;
        });
      },
      decoration: InputDecoration(
        icon: Icon(Icons.person),
      ),
    );


    TextFormField inputGender = TextFormField(
      controller: _cGender,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Genre',
        icon: Icon(Icons.web),
      ),
    );

    TextFormField inputAge = TextFormField(
      controller: _cAge,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Age',
        icon: Icon(Icons.cake),
      ),
    );

    TextFormField inputJob = TextFormField(
      controller: _cJob,
      inputFormatters: [
        LengthLimitingTextInputFormatter(45),
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Emploi',
        icon: Icon(Icons.work),
      ),
    );

    MaskedTextField inputPhoneNumber = new MaskedTextField(
      maskedTextFieldController: _cPhoneNumber,
      mask: "xx xx xx xx xx",
      maxLength: 14,
      keyboardType: TextInputType.phone,
      inputDecoration: new InputDecoration(
        labelText: "Téléphone",
        icon: Icon(Icons.phone),
      ),
    );

    TextFormField inputEmail = TextFormField(
      controller: _cEmail,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        icon: Icon(Icons.email),
      ),
    );

    TextFormField inputComments = TextFormField(
      controller: _cComments,
      maxLines: 4,
      inputFormatters: [
      ],
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Commentaires',
        icon: Icon(Icons.create),
      ),
    );

    final picture = Column(
      children: <Widget>[
        InkWell(
          child: photoBase64 != null ?
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: MemoryImage(base64Decode(photoBase64)),
                  fit: BoxFit.fill
              ),
            ),
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Icon(Icons.camera_alt, color: Colors.white)
              ),
            ),
          ):
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.indigo
            ),
            child: Align(
              alignment: FractionalOffset.center,
              child: Icon(Icons.camera_alt, color: Colors.white)
            ),
          ),
          onTap: () async {
            final fileBase64 = await getBase64FromFile();
            if (fileBase64 != null) {
              setState(() {
                photoBase64 = fileBase64;
              });
            }
          },
        )
      ],
    );

    ListView content = ListView(
      padding: EdgeInsets.all(20),
      children: <Widget>[
        picture,
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              inputFirstName,
              inputLastName,
              dropDownGender,
              inputAge,
              inputJob,
              inputPhoneNumber,
              inputEmail,
              inputComments,
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Nouveau contact"),
        actions: <Widget>[
          Container(
            width: 80,
            child: IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  contactRepository.insert({
                    'firstName': _cFirstName.text,
                    'lastName': _cLastName.text,
                    'gender': gender,
                    'age': _cAge.text,
                    'job': _cJob.text,
                    'phoneNumber': _cPhoneNumber.text,
                    'email': _cEmail.text,
                    'comments': _cComments.text,
                    'photo': photoBase64,
                    'favorite': 0,
                    'created': DateTime.now().toString()
                  }).then((saved) {
                    bloc.getListContact();
                    Navigator.of(context).pop();
                  });
                }
              },
            ),
          )
        ],
      ),
      body: content,
    );
  }

  Future<String> getBase64FromFile() async {
    File photo = await FilePicker.getFile(type: FileType.image);
    if(photo != null) {
      return base64Encode(photo.readAsBytesSync());
    }
    return null;
  }
}

