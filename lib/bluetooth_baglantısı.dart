import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double hiz=0;
  TextEditingController sure_control = TextEditingController();
  TextEditingController sicaklik_control = TextEditingController();

  String dropdownValue = 'Saat yönünde';
  List<String> dropdownItems = ['Saat yönünde','Saat yönünün tersi'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homojenizator Kontrolcüsü'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left:10.0,
            top: 20.0,
            right: 10.0,
            bottom: 10.0
        ),
        child: Column(
          children: [
            // Metin kutuları
            TextField(
              controller: sure_control,
              decoration: InputDecoration(labelText: 'Süre (saniye):'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: sicaklik_control,
              decoration: InputDecoration(labelText: 'Sıcaklık : '),
              keyboardType: TextInputType.number,
            ),
            Row(children: [
              Expanded(
                  flex: 1,
                  child: Text("Hız :")
              ),
              Expanded(
                flex: 8,
                child: Slider(
                    value: hiz,
                    min : 0,
                    max: 255,
                    onChanged: (value){
                      setState(() {
                        hiz = value;
                      });
                    }
                ),
              ),
              Expanded(
                flex: 1,
                child:Text(hiz.toInt().toString()),
              )

            ],),
            SizedBox(height: 16),
            // Dropdown
            DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            SizedBox(height: 16),

            // Buton
            ElevatedButton(
              onPressed: () {
                // Butona basıldığında yapılacak işlemler buraya eklenebilir
                print('Sure: ${sure_control.text}');
                print('Hiz: ${hiz.toInt()}');
                print('Sicaklik: ${sicaklik_control.text}');
                print('Yon: $dropdownValue');
              },
              child: Text('Calistir !'),
            ),

            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {

              },
              child: Text('Baglan'),
            ),
          ],
        ),
      ),
    );
  }
}

