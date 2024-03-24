import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BluetoothScreen(),
    );
  }
}

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  List<BluetoothDiscoveryResult> devicesList = [];
  bool isDiscovering = false;

  @override
  void initState() {
    super.initState();
    _startDiscovery();
  }

  Future<void> _startDiscovery() async {
    setState(() {
      isDiscovering = true;
    });

    try {
      FlutterBluetoothSerial.instance.startDiscovery().listen((result) {
        setState(() {
          devicesList.add(result);
        });
      });
    } catch (ex) {
      print("Error: $ex");
    } finally {
      setState(() {
        isDiscovering = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Devices'),
      ),
      body: isDiscovering
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: devicesList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(devicesList[index].device.name ?? 'Unknown device'),
            subtitle: Text(devicesList[index].device.address),
          );
        },
      ),
    );
  }
}
