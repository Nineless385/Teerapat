import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nineless/showproducttype.dart';
import 'addproduct.dart';
import 'showproductgrid.dart';

//Method หลักที่ Run
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
              apiKey: "AIzaSyDk5c4hdnRlFRXYV_a9y0IaaPMetBs0-TA",
              authDomain: "rmutt-secb-45fab.firebaseapp.com",
              databaseURL: "https://rmutt-secb-45fab-default-rtdb.firebaseio.com",
              projectId: "rmutt-secb-45fab",
              storageBucket: "rmutt-secb-45fab.firebasestorage.app",
              messagingSenderId: "826834465505",
              appId: "1:826834465505:web:44b96d0bbdbc6285e6fda0",
              measurementId: "G-34EP6YE5T7"));
  } else {
    await Firebase.initializeApp();
 }
  runApp(MyApp());
}

//Class stateless สั่งแสดงผลหนาจอ
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 233, 136)),
        useMaterial3: true,
      ),
      home: Main(),
    );
  }
}

//Class stateful เรียกใช้การทํางานแบบโต้ตอบ
class Main extends StatefulWidget {
  @override
  State<Main> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Main> {
  //ส่วนการออกแบบหน้าจอ
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เมนูหลัก'),
        backgroundColor: Color.fromARGB(218, 252, 186, 5),
        foregroundColor: const Color.fromARGB(255, 0, 0, 0), // ใส่สีที่ต้องการ
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 254, 203), // สีพื้นหลัง
        ),
        width: double.infinity, // กำหนดให้ครอบคลุมเต็มความกว้าง
        height: double.infinity, // กำหนดให้ครอบคลุมเต็มความสูง
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.start, // Center content vertically
            crossAxisAlignment:
                CrossAxisAlignment.center, // Make buttons the same width
            children: [
              SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => addproduct()),
                    );
                  },
                  child: Text('จัดการข้อมูลสินค้า'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 212, 204, 87), // สีพื้นหลัง (พื้นหลังของปุ่ม)
                    foregroundColor:
                        const Color.fromARGB(255, 0, 0, 0), // สีข้อความ (สีข้อความภายในปุ่ม)
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => showproductgrid()),
                    );
                  },
                  child: Text('แสดงข้อมูลสินค้า'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Color.fromARGB(255, 212, 204, 87), // สีพื้นหลัง (พื้นหลังของปุ่ม)
                    foregroundColor:
                        const Color.fromARGB(255, 0, 0, 0), // สีข้อความ (สีข้อความภายในปุ่ม)
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => showproducttype()),
                    );
                  },
                  child: Text('ประเภทสินค้า'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Color.fromARGB(255, 212, 204, 87), // สีพื้นหลัง (พื้นหลังของปุ่ม)
                    foregroundColor:
                        const Color.fromARGB(255, 3, 3, 3), // สีข้อความ (สีข้อความภายในปุ่ม)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
