import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          routes: {"/": (context) => home(),
            "/signup": (context) => signup(),
            "/login": (context) => login(),
          }
      );
    }
}

class home extends StatefulWidget {
  @override
  State<home> createState() => _home();
}

class _home extends State<home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.16,
                    decoration: BoxDecoration(
                      color: const Color(0xffB4C9FF),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.21,
                    decoration: BoxDecoration(
                        color: const Color(0xff648FFF),
                        borderRadius: BorderRadius.circular(50.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.01),
                            blurRadius: 5.0,
                            spreadRadius: 0.0,
                            offset: const Offset(0, 7),
                          )
                        ]),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width / 4,
                        40,
                        MediaQuery.of(context).size.width / 4,
                        0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.28,
                    decoration: BoxDecoration(
                        color: const Color(0xff245FF7),
                        borderRadius: BorderRadius.circular(40.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.01),
                            blurRadius: 5.0,
                            spreadRadius: 0.0,
                            offset: const Offset(0, 7),
                          )
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "교내보건 시스템 진화 프로젝트",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        const Text(
                          "제일가는\n보건실",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 23,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 14,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed("/signup");
                            },
                            child: const Text(
                              '로그인',
                              style: TextStyle(color: Color(0xff245FF7)),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 14,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed("/signup");
                            },
                            child: const Text(
                              '회원가입',
                              style: TextStyle(color: Color(0xff245FF7)),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'World of Medical',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 7,
                decoration: const BoxDecoration(
                  color: Color(0xff245FF7),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0)
                  )
                ),
              ),
            const SizedBox(
              height: 2,
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 10, 40, MediaQuery.of(context).size.width / 10, 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: const Color(0xff648FFF),
                    borderRadius: BorderRadius.circular(40.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(style: TextStyle(fontSize: 35, color: Colors.white), "Profile"),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(style: TextStyle(fontSize: 18, color: Colors.white), "이름"),
                    const SizedBox(
                      width: 200,
                      height: 35,
                      child: TextField(
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            hintText: '홍길동',

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide.none,
                        ),
                          contentPadding: EdgeInsets.only(top: 10, left: 10),

                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    const Text(style: TextStyle(fontSize: 18, color: Colors.white), "학년"),
                    const SizedBox(
                      width: 50,
                      height: 35,
                      child: TextField(
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          hintText: '1',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.only(top: 10, left: 10),

                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    const Text(style: TextStyle(fontSize: 18, color: Colors.white), "반"),
                    const SizedBox(
                      width: 50,
                      height: 35,
                      child: TextField(
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          hintText: '1',

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.only(top: 10, left: 10),

                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    const Text(style: TextStyle(fontSize: 18, color: Colors.white), "번호"),
                    const SizedBox(
                      width: 50,
                      height: 35,
                      child: TextField(
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          hintText: '1',

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.only(top: 10, left: 10),

                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    SizedBox(
                      width: 500,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/login");
                        },
                        child: Text("DONE", style: TextStyle(color: const Color(0xff648FFF))),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                        ),

                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 7,
                decoration: const BoxDecoration(
                  color: Color(0xffB4C9FF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0)
              )
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 7,
              decoration: const BoxDecoration(
                  color: Color(0xff245FF7),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0)
                  )
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 10, 40, MediaQuery.of(context).size.width / 10, 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: const Color(0xff648FFF),
                  borderRadius: BorderRadius.circular(40.0),
                ),

                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(style: TextStyle(fontSize: 30, color: Colors.white), "Profile"),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 7,
              decoration: const BoxDecoration(
                  color: Color(0xffB4C9FF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0)
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
