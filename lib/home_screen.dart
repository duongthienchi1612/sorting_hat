import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Nền
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [Color(0xFF0E1621), Color(0xFF000000)], // Tông màu tối
                radius: 1.0,
              ),
            ),
          ),

          // Chi tiết nền phụ: họa tiết trang trí
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            // child: Image.asset(
            //   'assets/decorative_top.png', // Đặt file trang trí phía trên
            //   fit: BoxFit.cover,
            // ),
            child: Container(),
          ),

          // Mũ
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Tiêu đề
              const Text(
                "SORTING",
                style: TextStyle(
                  fontFamily: 'Cinzel',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFBE4C5),
                  shadows: [
                    Shadow(
                      blurRadius: 6,
                      color: Colors.black,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Icon Mũ
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.blue.withOpacity(0.6),
                      Colors.black.withOpacity(0.9),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      color: Colors.blueAccent.withOpacity(0.8),
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  // child: Image.asset(
                  //   'assets/sorting_hat.png', // Hình mũ
                  //   width: 120,
                  //   height: 120,
                  // ),
                  child: Container(
                    width: 120,
                    height: 120,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Text Quiz
              const Text(
                "QUIZ",
                style: TextStyle(
                  fontFamily: 'Cinzel',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFBE4C5),
                  shadows: [
                    Shadow(
                      blurRadius: 6,
                      color: Colors.black,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/question'),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBE4C5),
                    border: Border.all(color: const Color(0xFF6E4B3A), width: 2),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.4),
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    "START QUIZ",
                    style: TextStyle(
                      fontFamily: 'Cinzel',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3B2C25),
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black45,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/images/gry_trans.png', width: 80),
                  Image.asset('assets/images/huf_trans.png', width: 80),
                ],
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                 
                  Image.asset('assets/images/raven_trans.png', width: 80),
                  Image.asset('assets/images/sly_trans.png', width: 80),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
