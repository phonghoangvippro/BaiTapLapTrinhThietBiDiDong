import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Thanh điều hướng
                  _buildIconButton(Icons.arrow_back, () {
                    Navigator.pop(context);
                  }),
                  _buildIconButton(Icons.edit, () {
                    //   Chỉnh sửa thông tin
                  }),
                ],
              ),
            ),
            Spacer(),
            // Ảnh đại diện
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/image/avatar.jpg'),
            ),
            SizedBox(height: 16),
            // Tên và địa chỉ
            Text(
              "Lê Hoàng Phong",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            Text(
              "Bình Thuận, Việt Nam",
              style: TextStyle(fontSize: 25, color: Colors.grey),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black),
        onPressed: onPressed,
      ),
    );
  }
}
