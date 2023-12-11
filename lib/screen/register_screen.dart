import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:scanify/constant.dart';
import 'package:scanify/controller/navigation_controller.dart';
import 'package:scanify/screen/component/custom_red_button.dart';
import 'package:scanify/screen/component/custom_textfield.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController passConfController = TextEditingController();
  final NavigationController navigationController =
      Get.put(NavigationController());

  Future<void> register() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      navigationController.isLoading.value = true;
      await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      Fluttertoast.showToast(
        msg: 'Berhasil Membuat akun',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        textColor: darkColor,
      );
      navigationController.isLoading.value = false;
    } on FirebaseAuthException {
      navigationController.isLoading.value = false;
      Fluttertoast.showToast(
        msg: 'Gagal Membuat Akun',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        textColor: darkColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Daftar Scanify",
                  style: textNormal700.copyWith(
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
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
              CustomTextfield(
                controller: passConfController,
                label: "Confirm Password",
                type: TextInputType.text,
                obscureText: true,
              ),
              const SizedBox(
                height: 16,
              ),
              Obx(() {
                if (navigationController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                } else {
                  return CustomRedButton(
                    onTap: () async {
                      if (emailController.text.isNotEmpty &&
                          passController.text.isNotEmpty) {
                        if (passController.text == passConfController.text) {
                          await register();
                          Get.back();
                        } else {
                          Fluttertoast.showToast(
                            msg: 'Konfirmasi Password Anda',
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.white,
                            textColor: darkColor,
                          );
                        }
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Masukkan Data Dengan Benar',
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.white,
                          textColor: darkColor,
                        );
                      }
                    },
                    text: "Daftar",
                  );
                }
              }),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sudah punya akun ? ",
                    style: textNormal400.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      "Masuk",
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
