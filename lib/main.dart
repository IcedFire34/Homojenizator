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
  List<BluetoothDevice> devicesList = [];

  @override
  void initState() {
    super.initState();
    _getBondedDevices();
    _startDiscovery();
  }

  Future<void> _getBondedDevices() async {
    List<BluetoothDevice> bondedDevices = [];

    try {
      bondedDevices = await FlutterBluetoothSerial.instance.getBondedDevices();
    } catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      devicesList = bondedDevices;
    });
  }

  void _startDiscovery() {
    FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        devicesList.add(r.device);
      });
    });
  }

  void _sendData(BluetoothDevice device) async {
    try {
      await FlutterBluetoothSerial.instance.connect(device);
      print("Cihaza bağlandı: ${device.name}");
      await FlutterBluetoothSerial.instance.write("e");
      print("Veri gönderildi: e");
      await FlutterBluetoothSerial.instance.disconnect();
      print("Cihazdan bağlantı kesildi: ${device.name}");
    } catch (e) {
      print("Hata oluştu: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Devices'),
      ),
      body: ListView.builder(
        itemCount: devicesList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(devicesList[index].name ?? 'Unknown device'),
            subtitle: Text(devicesList[index].address),
            onTap: () => _sendData(devicesList[index]),
          );
        },
      ),
    );
  }
}
