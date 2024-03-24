import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CreateCompanyPage(),
    );
  }
}

class CreateCompanyPage extends StatefulWidget {
   CreateCompanyPage({Key? key}) : super(key: key);

  @override
  _CreateCompanyPage createState() => _CreateCompanyPage();
}

final nameCompanyController = TextEditingController();
final namePersonController = TextEditingController();
final surnameController = TextEditingController();
final patronymicController = TextEditingController();
final phoneController = TextEditingController();
final emailController = TextEditingController();
final webLinkController = TextEditingController();
final postalCodeController = TextEditingController();
final cityController = TextEditingController();
final streetController = TextEditingController();
final houseNumberController = TextEditingController();
final buildingNumberController = TextEditingController();




class _CreateCompanyPage extends State<CreateCompanyPage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Name company'),
              controller: nameCompanyController,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Name person'),
                controller: namePersonController,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Surname'),
                controller: surnameController,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Patronymic'),
                controller: patronymicController,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Phone'),
                controller: phoneController,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Email'),
                controller: emailController,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Web link'),
                controller: webLinkController,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Postal code'),
                controller: postalCodeController,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'City'),
                controller: cityController,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Street'),
                controller: streetController,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'House number'),
                controller: houseNumberController,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Building number'),
                controller: buildingNumberController,
            ),
          ],
        ),
      ),
   floatingActionButton: FloatingActionButton(
  onPressed: () {
    final nameCompany = nameCompanyController.text;
    final namePerson = namePersonController.text;
    final surname = surnameController.text;
    final patronymic = patronymicController.text;
    final phone = phoneController.text;
    final email = emailController.text;
    final webLink = webLinkController.text;
    final postalCode = postalCodeController.text;
    final city = cityController.text;
    final street = streetController.text;
    final houseNumber = houseNumberController.text;
    final buildingNumber = buildingNumberController.text;

    final url = Uri.parse('http://127.0.0.1:8000/post/');
    final body = {
      'name_company': nameCompany,
      'name_person': namePerson,
      'surname': surname,
      'patronymic': patronymic,
      'phone': phone,
      'email': email,
      'web_link': webLink,
      'address.postal_code': postalCode,
      'address.city': city,
      'address.street': street,
      'address.house_number': houseNumber,
      'address.building_number': buildingNumber,

    };
    String jsonStr = jsonEncode(body);
    http.post(url, body: jsonStr, headers: { "Content-Type" : "application/json"}).then((response) {
      if (response.statusCode == 200) {
      Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompanyList()),
              );
      } else {
       
      }
    }).catchError((error) {
       
    });
  },
  child: const Icon(Icons.edit),
),
    );
  }
}
