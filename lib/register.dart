import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Utils.dart';
import '../fireBaseHelper.dart';
import 'constants.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  String email = "";
  String name = "";
  String password = "";
  late BuildContext dialogContext;
  bool isSecurePassword = true ;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Container(
            decoration: const BoxDecoration(
           gradient: LinearGradient(colors: [
                   Colors.white,
                    Colors.blue,
                    ])),
                padding: const EdgeInsets.only(right: 35, left: 35),
                child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                   Container(
                    padding: EdgeInsets.only(
                    left: 35,
                    top: 35,
                    bottom: MediaQuery.of(context).size.height * 0.2),
                      child: Center(
                          child: Column(
                              children: [
                                const Text(
                                  "Join Us!",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 33,
                                  ),
                                ),
                                const SizedBox(height: 20), // add some space between the text and the image
                                Image.asset('assets/images/register.png',
                                 width: 350,
                                  height: 300,
                                )

                              ],
                          ),
                      )),


                  TextFormField(
                  onChanged: (text) {
                     name = text;
                  },
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.person,

                          color: kPrimaryColor,
                        ),
                        hintText: 'Name',
                        hintStyle: TextStyle(fontFamily: 'OpenSans')
                    ),
                  ),
                                    const SizedBox(
                                  height: 30,
                                 ),
                  TextFormField(
                    onChanged: (text) {
                      email = text;
                    },
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.email,

                          color: kPrimaryColor,
                        ),
                        hintText: 'Email',
                        hintStyle: TextStyle(fontFamily: 'OpenSans')
                    ),
                  ),
                                const SizedBox(
                                 height: 30,
                                 ),

                  TextFormField(
                    onChanged: (text) {
                      password = text;
                    },
                    obscureText: isSecurePassword,
                    cursorColor: kPrimaryColor,
                    decoration:  InputDecoration(

                      icon: const Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      ),
                      hintText: "Password",
                      hintStyle:  const TextStyle(fontFamily: 'OpenSans'),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isSecurePassword = !isSecurePassword;
                            });
                          },
                          icon: Icon(isSecurePassword ? Icons.visibility_off: Icons.visibility , color: Colors.white,)

                      ),
                    ),
                  ),

                              const SizedBox(
                              height: 30,
                             ),
                  TextFormField(
                    onChanged: (text) {
                      password = text;
                    },
                    obscureText: isSecurePassword,
                    cursorColor: kPrimaryColor,
                    decoration:  InputDecoration(

                      icon: const Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      ),
                      hintText: " Confirm Password",
                      hintStyle:  const TextStyle(fontFamily: 'OpenSans'),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isSecurePassword = !isSecurePassword;
                            });
                          },
                          icon: Icon(isSecurePassword ? Icons.visibility_off: Icons.visibility , color: Colors.white,)

                      ),
                    ),
                  ),
                               const SizedBox(
                               height: 40,
                              ),

                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            const Text(
                            'Sign Up',
                             style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.w700,
                              ),
                              ),
                              CircleAvatar(
                               radius: 30,
                              backgroundColor:  Colors.teal,
                                  child: IconButton(
                                    onPressed: () {

                                       if(email.isEmpty || password.isEmpty || name.isEmpty){
                                       buildShowSnackBar(context, "please check your info.");

                                      }else {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              dialogContext = context;
                                      return  const Center(
                                         child: CircularProgressIndicator(),
                                      );
                                    }
                                      );
                                  FireBaseHelper()
                                      .signUp(email: email.trim().toString(), password: password.trim().toString())
                                      .then((result) {
                                    if(result == "true"){
                                      Navigator.pushReplacementNamed(
                                          context, 'login');
                                      FirebaseAuth.instance.currentUser!.updateDisplayName(name.trim().toString());
                                      buildShowSnackBar(context, "Now you can login");
                                    } else if (result != null) {
                                      buildShowSnackBar(context, result);
                                      Navigator.pop(dialogContext);
                                    }
                                    else {
                                      Navigator.pop(dialogContext);
                                      buildShowSnackBar(context, "Try again.");
                                    }
                                  }).catchError((e) {
                                    Navigator.pop(dialogContext);
                                    buildShowSnackBar(context, e.toString());
                                  });
                                }
                              },
                                    icon: const Icon(Icons.arrow_forward),
                                                  ),
                                      ),
                                    ]),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                const Text(
                                  "If you already have an account,",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(context, 'login');
                                  },
                                  child: const Text(
                                    'Sign In',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ]),
                            ]),
                          ),
                        ),
                    ),
                    );


  }
}