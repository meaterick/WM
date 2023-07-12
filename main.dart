import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          "/signup": (context) => signuphome(),
          "/login": (context) => loginhome(),
          "/profile": (context) => profilehome(),
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
                              Navigator.of(context).pushNamed("/login");
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

class signuphome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: signup());
  }
}
class signup extends StatefulWidget {
  @override
  State<signup> createState() => _signup();
}
class _signup extends State<signup> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // User? _user;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _auth.authStateChanges().listen((User? user) {
  //     setState(() {
  //       _user = user;
  //     });
  //   });
  // }

  var _name = '-'; // Replace this with your code to retrieve the name input
  var _grade = '-'; // Replace this with your code to retrieve the grade input
  var _classNum = '-'; // Replace this with your code to retrieve the class input
  var _studentNum = '-';

  Future<UserCredential> signInWithGoogle() async {

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    final name = _name;
    final grade = _grade;
    final classNum = _classNum;
    final studentNum = _studentNum;

    final userId = userCredential.user!.uid;
    final userData = {
      'name': name,
      'grade': grade,
      'class': classNum,
      'studentNumber': studentNum,
    };
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(userData);

    return userCredential;
  }

  final signuptext_name = TextEditingController();
  final signuptext_grade = TextEditingController();
  final signuptext_classNum = TextEditingController();
  final signuptext_studentNum = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    SizedBox(
                      width: 200,
                      height: 35,
                      child: TextField(
                        controller: signuptext_name,
                        style: const TextStyle(fontSize: 20),
                        decoration: const InputDecoration(
                          hintText: '홍길동',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.only(top: 10, left: 10),

                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onChanged: (text) {
                          _name = signuptext_name.text;
                        },
                      ),
                    ),
                    const Text(style: TextStyle(fontSize: 18, color: Colors.white), "학년"),
                    SizedBox(
                      width: 50,
                      height: 35,
                      child: TextField(
                        controller: signuptext_grade,
                        style: const TextStyle(fontSize: 20),
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.only(top: 10, left: 10),

                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onChanged: (text) {
                          _grade = signuptext_grade.text;
                        },
                      ),
                    ),
                    const Text(style: TextStyle(fontSize: 18, color: Colors.white), "반"),
                    SizedBox(
                      width: 50,
                      height: 35,
                      child: TextField(
                        controller: signuptext_classNum,
                        style: const TextStyle(fontSize: 20),
                        decoration: const InputDecoration(

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.only(top: 10, left: 10),

                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onChanged: (text) {
                          _classNum = signuptext_classNum.text;
                        },
                      ),
                    ),
                    const Text(style: TextStyle(fontSize: 18, color: Colors.white), "번호"),
                    SizedBox(
                      width: 50,
                      height: 35,
                      child: TextField(
                        controller: signuptext_studentNum,
                        style: const TextStyle(fontSize: 20),
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.only(top: 10, left: 10),

                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onChanged: (text) {
                          _studentNum = signuptext_studentNum.text;
                        },
                      ),
                    ),
                    const SizedBox(height: 20,),
                    if (FirebaseAuth.instance.currentUser == null)
                      SizedBox(
                        width: 500,
                        child: ElevatedButton(
                          onPressed: signInWithGoogle,
                          child: const Text(
                            "DONE----",
                            style: TextStyle(color: Color(0xff648FFF)),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                          ),
                        ),
                      ),
                    if (FirebaseAuth.instance.currentUser != null)
                      SizedBox(
                        width: 500,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/profile");
                          },
                          child: const Text(
                            "DONE",
                            style: TextStyle(color: Color(0xff648FFF)),
                          ),
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

class loginhome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: login());
  }
}
class login extends StatefulWidget {
  @override
  State<login> createState() => _login();
}
class _login extends State<login> {
  FirebaseAuth auth = FirebaseAuth.instance;

  checkGoogleLogin() {
    User? user = auth.currentUser;
    bool islogined;
    islogined = (user != null);

    return islogined;
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 7,
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
                    padding: EdgeInsets.fromLTRB(MediaQuery
                        .of(context)
                        .size
                        .width / 10, 40, MediaQuery
                        .of(context)
                        .size
                        .width / 10, 0),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: const Color(0xff648FFF),
                      borderRadius: BorderRadius.circular(40.0),
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                            style: TextStyle(fontSize: 16, color: Colors.white),
                            "World of Medical"
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 30,
                        ),
                        const Text(
                            style: TextStyle(fontSize: 50, color: Colors.white),
                            "Login"
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 10,
                        ),
                        if (checkGoogleLogin() == true)
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pushNamed("/profile");
                            },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                            child: const Text("SignIn with Google", style: TextStyle(color: Color(0xff648FFF))),
                        )
                        else
                          ElevatedButton(
                            onPressed: signInWithGoogle,
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                            child: const Text("SignIn with Google-", style: TextStyle(color: Color(0xff648FFF))),
                          )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 7,
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
        )
    );
  }
}

class profilehome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: profile());
  }
}
class profile extends StatefulWidget {
  @override
  State<profile> createState() => _profile();
}
class _profile extends State<profile> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
          verticalDirection: VerticalDirection.up,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Positioned(
                    bottom: MediaQuery.of(context).size.height / 11,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width / 4,
                        40,
                        MediaQuery.of(context).size.width / 4,
                        0,
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.2,
                      decoration: BoxDecoration(
                        color: const Color(0xff245FF7),
                        borderRadius: BorderRadius.circular(40.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.01),
                            blurRadius: 5.0,
                            spreadRadius: 0.0,
                            offset: const Offset(0, 7),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height / 16,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.2,
                      decoration: BoxDecoration(
                        color: const Color(0xff648FFF),
                        borderRadius: BorderRadius.circular(50.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.01),
                            blurRadius: 5.0,
                            spreadRadius: 0.0,
                            offset: const Offset(0, 7),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height / 30,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height:  MediaQuery.of(context).size.height / 1.2,
                      decoration: BoxDecoration(
                        color: const Color(0xffB4C9FF),
                        borderRadius: BorderRadius.circular(50.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.01),
                            blurRadius: 5.0,
                            spreadRadius: 0.0,
                            offset: const Offset(0, 7),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.01),
                            blurRadius: 5.0,
                            spreadRadius: 0.0,
                            offset: const Offset(0, 7),
                          ),
                        ],
                      ),
                      child: const Column(
                        children: [
                          SizedBox(
                            child: Text("현석이", style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                              color: Colors.red,
                            ),),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

      ),
      ),
    );
  }
}