import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

//Method หลักทีRun
void main() {
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
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 221, 159, 66)),
        useMaterial3: true,
      ),
      home: showproductgrid(),
    );
  }
}

//Class stateful เรียกใช้การทํางานแบบโต้ตอบ
class showproductgrid extends StatefulWidget {
  @override
  State<showproductgrid> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<showproductgrid> {
//ส่วนเขียน Code ภาษา dart เพื่อรับค่าจากหน้าจอมาคํานวณหรือมาทําบางอย่างและส่งค่ากลับไป
// สร้าง reference ไปยัง Firebase Realtime Database
  DatabaseReference dbRef = FirebaseDatabase.instance.ref('products');
  List<Map<String, dynamic>> products = [];

  Future<void> fetchProducts() async {
    try {
      //ใส่โค้ดที่ต้องการกรองข้อมูลตรงนี้
// ดึงข้อมูลจาก Realtime Database
      final snapshot = await dbRef.get();
      if (snapshot.exists) {
        List<Map<String, dynamic>> loadedProducts = [];
// วนลูปเพื่อแปลงข้อมูลเป็ น Map
        snapshot.children.forEach((child) {
          Map<String, dynamic> product =
              Map<String, dynamic>.from(child.value as Map);
          product['key'] =
              child.key; // เก็บ key สําหรับการอ้างอิง (เช่นการแก้ไข/ลบ)
          loadedProducts.add(product);
        });
        // **เรียงลําดับข้อมูลตามราคา จากมากไปน้อย**
        loadedProducts.sort((a, b) => a['price'].compareTo(b['price']));
// อัปเดต state เพื่อแสดงข้อมูล
        setState(() {
          products = loadedProducts;
        });
        print(
            "จํานวนรายการสินค้าทั้งหมด: ${products.length} รายการ"); // Debugging
      } else {
        print("ไม่พบรายการสินค้าในฐานข้อมูล"); // กรณีไม่มีข้อมูล
      }
    } catch (e) {
      print("Error loading products: $e"); // แสดงข้อผิดพลาดทาง Console
// แสดง Snackbar เพื่อแจ้งเตือนผู้ใช้
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาดในการโหลดข้อมูล: $e')),
      );
    }
  }

//ฟังก์ชันสำหรับการเปิดแอปพลิเคชั่นมาแล้วรันเลย
  @override
  void initState() {
    super.initState();
    fetchProducts(); // เรียกใช้เมื่อ Widget ถูกสร้าง
  }

//ส่วนการออกแบบหน้าจอ
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'แสดงข้อมูลสินค้า',
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0)), // กำหนดสีของข้อความ
        ),
        backgroundColor:Color.fromARGB(218, 252, 186, 5), // ใส่สีที่ต้องการ
      ),
      body: products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding:
                  EdgeInsets.all(10), // ระยะห่างระหว่าง AppBar และเนื้อหาภายใน
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // จํานวนคอลัมน์
                  crossAxisSpacing: 10, // ระยะห่างระหว่างคอลัมน์
                  mainAxisSpacing: 10, // ระยะห่างระหว่างแถว
                ),
                itemCount: products.length, // จํานวนรายการ
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
//รอใส่codeว่ากดแล้วเกิดอะไรขึ้น
                    },
                    child: Card(
                      elevation: 5, // ความสูงของเงา (ช่วยเพิ่มมิติ)
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // ขอบมน
                      ),
                      child: Center(
                        child: Padding(
                          padding:
                              const EdgeInsets.all(16.0), // เพิ่มระยะขอบภายใน
                          child: Column(
                            children: [
                              Text(
                                product['name'],
                                style: TextStyle(
                                  fontSize: 16, // ขนาดฟอนต์
                                  fontWeight:
                                      FontWeight.bold, // ความหนาของฟอนต์
                                  color: const Color.fromARGB(
                                      255, 0, 0, 0), // สีของฟอนต์
                                ),
                              ),
                              SizedBox(height: 8), // เพิ่มระยะห่าง
                              Text(
                                'รายละเอียดสินค้า: ${product['description']}',
                                style: TextStyle(
                                  fontSize: 13, // ขนาดฟอนต์
                                  color: const Color.fromARGB(
                                      255, 3, 3, 3), // สีฟอนต์เป็นเทา
                                  height: 1.25, // เพิ่มระยะห่างบรรทัด
                                ),
                              ),

                              SizedBox(height: 8), // เพิ่มระยะห่าง
                              Spacer(), // เพิ่มระยะห่างและผลักราคาลงด้านล่างสุด
                              Text(
                                'ราคา : ${product['price']} บาท',
                                style: TextStyle(
                                  fontSize: 14, // ขนาดฟอนต์
                                  color: const Color.fromARGB(
                                      255, 0, 0, 0), // สีของฟอนต์
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
