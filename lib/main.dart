import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'viewCompanyPage.dart';
import 'createCompanyPage.dart';



class CompanyList extends StatefulWidget {
  @override
  _CompanyListState createState() => _CompanyListState();
}


 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Roboto'),
      home: Scaffold(),
    );
  }

  


class _CompanyListState extends State<CompanyList> {
    List<Map<String, dynamic>> companies = [];
    List<Map<String, dynamic>> addresses = [];

    @override
    void initState() {
      super.initState();
      fetchData();
    }

    

   Future<void> fetchData() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/get/'));
  if (response.statusCode == 200) {
    
      final decodedResponse = utf8.decode(response.bodyBytes);
      setState(() {
        companies = (json.decode(decodedResponse)['company'] as List).cast<Map<String, dynamic>>();


    });
  } else {
    throw Exception('Failed to load data');
  }
}

    @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text('Company List')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateCompanyPage()),
              );
        },
        child: const Icon(Icons.add),
      ),
      
      body: Table(
        border: const TableBorder(bottom: BorderSide(color: Colors.grey)),
        children: [
          const TableRow(
            
            children: [
              Text('№'),
              Text('Название компании'),
              Text('ФИО'),
              Text('Телефон'),
              Text('email'),
              Text('сайт'),
              Text('Почтовый индекс'),
              Text('Адрес'),
              Text(''),
              Text('')
            ],
          ), 
          ...companies.map((company) {

            return TableRow(
           
                children:  [
                Text(company['id'].toString(), style: const TextStyle(fontFamily: 'Roboto')),
                Text(company['name_company'], style: const TextStyle(fontFamily: 'Roboto')),
                Text('${company['name_person']} ${company['surname']}  ${company['patronymic']}', style: const TextStyle(fontFamily: 'Roboto')),
                Text('${company['phone']}', style: const TextStyle(fontFamily: 'Roboto')),
                Text('${company['email']}', style: const TextStyle(fontFamily: 'Roboto')),
                Text('${company['web_link']}', style: const TextStyle(fontFamily: 'Roboto')),
                Text('${company['address']['postal_code'].toString()}', style: const TextStyle(fontFamily: 'Roboto')),
                Text('${company['address']['city']}, ${company['address']['street']}  ${company['address']['house_number'].toString()}/${company['address']['building_number']}', style: const TextStyle(fontFamily: 'Roboto')),
                 IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewCompanyPage(company : company)),
              );
            },
                 ),
                 IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              final url = Uri.parse('http://127.0.0.1:8000/destroy/${company['id']}/');
              http.delete(url).then((response) {
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
                 )
              ],
              
            );
            
          }),
          
        ],
      ),
    );

  }
}


  void main() => runApp(MaterialApp(home: CompanyList()));

