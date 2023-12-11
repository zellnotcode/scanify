import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:scanify/constant.dart';
import 'package:scanify/controller/form_controller.dart';
import 'package:scanify/controller/navigation_controller.dart';
import 'package:scanify/screen/component/custom_top_screen.dart';

class FormScreen extends StatefulWidget {
  FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final List<String> listLokasi = [
    "Dapur",
    "Kamar Tidur",
    "Kamar Mandi",
    "Ruang Tamu"
  ];

  String selectedString = 'Dapur';

  final NavigationController navigationController =
      Get.put(NavigationController());

  final FormController formController = Get.put(FormController());

  void _showObjectSelectionBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: lightBlackColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Pilih Objek',
                  style: textBold.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: formController.listObject.length,
                  itemBuilder: (context, index) {
                    final item = formController.listObject[index];

                    return ListTile(
                      title: Text(
                        item.objectName.toString(),
                        style: textNormal700.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          formController.listSelectedObject.add(item);
                          formController.updateTotalKwh();
                        });
                        Navigator.pop(context); // Close the bottom sheet
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 22,
            ),
            child: Column(
              children: [
                CustomTop(
                  onTap: () {
                    Get.back();
                  },
                  text: "KalkuWatt",
                ),
                Center(
                  child: Image.asset(
                    "assets/images/art_form.png",
                    width: 200,
                    height: 185,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Lokasi',
                      style: textNormal700.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
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
                      value: selectedString,
                      dropdownColor: lightBlackColor,
                      items: listLokasi
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: textNormal400.copyWith(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedString = newValue;
                          });
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Nama Barang",
                      style: textNormal700.copyWith(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onDoubleTap: () {
                    _showObjectSelectionBottomSheet();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    width: double.maxFinite,
                    height: 112,
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
                    child: SingleChildScrollView(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 16,
                            bottom: 16,
                          ),
                          child: Wrap(
                            spacing: 8.0, // Spasi antara item
                            runSpacing: 8.0, // Spasi antara baris
                            children: List.generate(
                              formController.listSelectedObject.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    formController.listSelectedObject
                                        .removeAt(index);
                                    print(formController.totalKwh);
                                    formController.updateTotalKwh();
                                  });
                                },
                                child: Container(
                                  width: 140,
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: darkColor),
                                  child: Row(
                                    children: [
                                      Text(
                                        formController.listSelectedObject[index]
                                            .objectName,
                                        style: textNormal400.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Spacer(),
                                      Icon(
                                        Icons.close,
                                        color: redColor,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                LinearPercentIndicator(
                  lineHeight: 11,
                  progressColor: greenColor,
                  backgroundColor: lightBlackColor,
                  barRadius: const Radius.circular(100),
                  percent: formController.totalKwh /
                      (navigationController.dataUser.value!.data.kwh.kVa * 0.8),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      formController.totalKwh.toString(),
                      style: textBold.copyWith(
                        fontSize: 32,
                        color: yellowColor,
                      ),
                    ),
                    Icon(
                      Icons.bolt,
                      size: 25,
                      color: yellowColor,
                    ),
                    Text(
                      "kWh",
                      style: textNormal500.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
