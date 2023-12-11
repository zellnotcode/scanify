import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scanify/constant.dart';
import 'package:scanify/controller/navigation_controller.dart';
import 'package:scanify/screen/component/custom_red_button.dart';
import 'package:scanify/screen/component/custom_textfield.dart';

class InputDataScreen extends StatefulWidget {
  InputDataScreen({super.key});

  @override
  State<InputDataScreen> createState() => _InputDataScreenState();
}

class _InputDataScreenState extends State<InputDataScreen> {
  final TextEditingController namaController = TextEditingController();

  final TextEditingController kWhController = TextEditingController();

  final NavigationController navigationController =
      Get.put(NavigationController());

  List<Map<String, dynamic>> options = [
    {"id": 1, "value": "450"},
    {"id": 2, "value": "900"},
    {"id": 3, "value": "1300"},
    {"id": 4, "value": "2200"},
    {"id": 5, "value": "3500"},
  ];

  int selectedOptionId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 42,
            ),
            Center(
              child: Text(
                'Isi Data',
                style: textNormal700.copyWith(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
            ),
            CustomTextfield(
              controller: namaController,
              label: "Nama",
              type: TextInputType.name,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "kVA",
              style: textNormal700.copyWith(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 2,
              ),
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black,
                  ),
                  BoxShadow(
                    color: lightBlackColor,
                    spreadRadius: 0,
                    blurRadius: 4,
                    blurStyle: BlurStyle.inner,
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  icon: const Icon(
                    Icons.expand_more,
                    color: Colors.white,
                  ),
                  value: selectedOptionId,
                  dropdownColor: lightBlackColor,
                  items: options.map((option) {
                    return DropdownMenuItem<int>(
                      value: option['id'] as int,
                      child: Text(
                        option['value'],
                        style: textNormal400.copyWith(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedOptionId = newValue;
                      });
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            CustomRedButton(
              onTap: () async {
                if (namaController.text.isNotEmpty) {
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  final String fId = auth.currentUser!.uid;

                  bool uploadData = await navigationController.saveDataUser(
                    fId,
                    selectedOptionId,
                    namaController.text,
                  );
                  if (uploadData) {
                    navigationController.selectedIndex.value = 0;
                  }
                }
              },
              text: "Submit",
            ),
          ],
        ),
      ),
    );
  }
}
