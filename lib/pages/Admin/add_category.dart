import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playbeat/Models/category_model.dart';
import 'package:playbeat/Services/db_services.dart';
import 'package:playbeat/Services/storage_services.dart';
import 'package:playbeat/Utilities/input_valiators.dart';
import 'package:playbeat/Utilities/overlays_widgets.dart';
import 'package:playbeat/Widgets/input_field.dart';
import 'package:playbeat/Widgets/round_button.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PlatformFile? pickedImageFile;
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/Logo.jpg'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  inputField(
                      iconPrefix: Icons.category,
                      hint: 'Category Name',
                      textInputType: TextInputType.name,
                      validator: requiredValidator,
                      controller: categoryController),
                  inputField(
                    hint: 'Background image',
                    controller: imageController,
                    validator: requiredValidator,
                    widget: IconButton(
                      onPressed: imagePicker,
                      icon: const Icon(Icons.image),
                    ),
                    iconPrefix: Icons.image,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RoundButton(
                    size: size,
                    onPress: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          loadingOverlay('Adding');
                          final imageUrl = await StorageService()
                              .uploadCategoryImage(pickedImageFile);
                          CategoryModel categoryModel = CategoryModel(
                              title: categoryController.text,
                              imageUrl: imageUrl);
                          await DBServices().addCategory(categoryModel);
                          Get.back(closeOverlays: true);
                        } catch (e) {
                          errorOverlay(e.toString());
                        }
                      }
                    },
                    text: 'Add',
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void imagePicker() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;
    setState(() {
      pickedImageFile = result.files.first;
      imageController.text = pickedImageFile!.name;
    });
  }
}
