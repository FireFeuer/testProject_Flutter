import 'dart:convert';
import 'dart:developer';
import 'model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'viewAllCompanyPage.dart';


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
      home: ViewCompanyPage(company: {},),
    );
  }
}

class ViewCompanyPage extends StatefulWidget {
  final Map<String, dynamic> company;
   ViewCompanyPage({Key? key, required this.company}) : super(key: key);

  @override
  _ViewCompanyPage createState() => _ViewCompanyPage();
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




class _ViewCompanyPage extends State<ViewCompanyPage> {
  @override
  Widget build(BuildContext context) {
    nameCompanyController.text = widget.company['name_company'];
    namePersonController.text = widget.company['name_person'];
    surnameController.text = widget.company['surname'];
    patronymicController.text = widget.company['patronymic'];
    phoneController.text = widget.company['phone'];
    emailController.text = widget.company['email'];
    webLinkController.text = widget.company['web_link'];
    postalCodeController.text = widget.company['address']['postal_code'].toString();
    cityController.text = widget.company['address']['city'];
    streetController.text = widget.company['address']['street'];
    houseNumberController.text = widget.company['address']['house_number'].toString();
    buildingNumberController.text = widget.company['address']['building_number'];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.company['name_company']),
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

    final url = Uri.parse('http://127.0.0.1:8000/put/${widget.company['id']}/');
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
    http.put(url, body: jsonStr, headers: {'Content-Type': 'application/json',
    'Authorization': 'JWT ${GlobalVariables.accessToken}',}).then((response) {
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
