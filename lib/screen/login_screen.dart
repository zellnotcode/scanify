import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:scanify/constant.dart';
import 'package:scanify/controller/navigation_controller.dart';
import 'package:scanify/screen/component/custom_red_button.dart';
import 'package:scanify/screen/component/custom_textfield.dart';
import 'package:scanify/screen/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final NavigationController navigationController =
      Get.put(NavigationController());

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> login() async {
    User? user;

    print(auth.currentUser?.uid);

    try {
      navigationController.isLoading.value = true;
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      user = userCredential.user;
      navigationController.isLoading.value = false;
    } on FirebaseAuthException {
      navigationController.isLoading.value = false;
      Fluttertoast.showToast(
        msg: 'Tidak Bisa Menemukan Akun Anda',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        textColor: darkColor,
      );
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/art_login.png",
                  height: 280,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                "Masuk ke Scanify",
                style: textNormal700.copyWith(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              CustomTextfield(
                controller: emailController,
                label: "Email",
                type: TextInputType.emailAddress,
              ),
              CustomTextfield(
                controller: passController,
                label: "Password",
                type: TextInputType.text,
                obscureText: true,
              ),
              const SizedBox(
                height: 16,
              ),
              Obx(
                () => navigationController.isLoading.value
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : CustomRedButton(
                        onTap: () async {
                          if (emailController.text.isNotEmpty &&
                              passController.text.isNotEmpty) {
                            User? user = await login();
                            if (user != null) {
                              print(auth.currentUser!.uid);
                              await navigationController
                                  .checkUserSaved(auth.currentUser!.uid);

                              if (navigationController.dataUser.value != null) {
                                navigationController.selectedIndex.value = 0;
                              } else {
                                navigationController.selectedIndex.value = 4;
                              }
                            }
                          }
                        },
                        text: "Masuk",
                      ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Belum punya akun ? ",
                    style: textNormal400.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => RegisterScreen());
                    },
                    child: Text(
                      "Daftar disini",
                      style: textBold.copyWith(
                        fontSize: 14,
                        color: Colors.white,
                      ),
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
