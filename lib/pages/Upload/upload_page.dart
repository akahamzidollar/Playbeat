import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:playbeat/Models/song_model.dart';
import 'package:playbeat/Services/db_services.dart';
import 'package:playbeat/Services/storage_services.dart';
import 'package:playbeat/Utilities/global_variables.dart';
import 'package:playbeat/Utilities/input_valiators.dart';
import 'package:playbeat/Utilities/overlays_widgets.dart';
import 'package:playbeat/pages/Auth/sign_in_user.dart';
import 'package:playbeat/Widgets/input_field.dart';
import 'package:playbeat/Widgets/round_button.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController singerController = TextEditingController();
  final TextEditingController writerController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController musicController = TextEditingController();
  PlatformFile? pickedImageFile;
  PlatformFile? pickedAudioFile;
  DateTime selectedDate = DateTime.now();

  String selectedCategory = 'Pop';
  List<String> categoryList = [
    'Pop',
    'Rock',
    'Hip Hop',
    'Electronic',
    'Classic',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload your music'),
      ),
      body: SizedBox(
        height: size.height * 0.81,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: Form(
              key: _formKey,
              child: inputFields(size),
            ),
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

  void audioPicker() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result == null) return;
    setState(() {
      pickedAudioFile = result.files.first;
      musicController.text = pickedAudioFile!.name;
    });
  }

  Column inputFields(Size size) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage('assets/images/Logo.jpg'),
        ),
        inputField(
            hint: 'Title',
            controller: titleController,
            textInputType: TextInputType.name,
            validator: requiredValidator,
            iconPrefix: Icons.title),
        inputField(
            hint: 'Singer',
            controller: singerController,
            textInputType: TextInputType.name,
            validator: requiredValidator,
            iconPrefix: Icons.person),
        inputField(
            hint: 'Writer',
            controller: writerController,
            textInputType: TextInputType.name,
            validator: requiredValidator,
            iconPrefix: Icons.person),
        inputField(
            hint: DateFormat.yMd().format(selectedDate),
            widget: Container(),
            iconPrefix: Icons.date_range),
        dropDownButton(),
        inputField(
          hint: 'Choose an image',
          controller: imageController,
          validator: requiredValidator,
          widget: IconButton(
            onPressed: imagePicker,
            icon: const Icon(Icons.image),
          ),
          iconPrefix: Icons.image,
        ),
        inputField(
            hint: 'Pick an audio file',
            controller: musicController,
            validator: requiredValidator,
            widget: IconButton(
              onPressed: audioPicker,
              icon: const Icon(Icons.audio_file),
            ),
            iconPrefix: Icons.audio_file),
        const SizedBox(
          height: 30,
        ),
        RoundButton(
          size: size,
          onPress: () async {
            if (userID.value != '') {
              if (_formKey.currentState!.validate()) {
                try {
                  loadingOverlay('Uploading');
                  final imageUrl =
                      await StorageService().uploadImageFile(pickedImageFile);
                  final songUrl =
                      await StorageService().uploadAudioFile(pickedAudioFile);
                  SongModel songModel = SongModel(
                    title: titleController.text,
                    singer: singerController.text,
                    writer: writerController.text,
                    uploadedDate:
                        DateFormat('yyyy-MM-dd – kk:mm').format(selectedDate),
                    category: selectedCategory,
                    imageUrl: imageUrl,
                    uploadedBy: userID.value,
                    songUrl: songUrl,
                    likedBy: [],
                  );
                  await DBServices().uploadSong(songModel);
                  _formKey.currentState?.reset();
                  Get.back(closeOverlays: true);
                  Get.defaultDialog(
                    title: 'Uploaded',
                    content: const Text('Check the status in your uploads'),
                  );
                } catch (e) {
                  errorOverlay(e.toString());
                  log(e.toString());
                }
              }
            } else {
              Get.defaultDialog(
                title: 'Alert',
                content: const Text('You need to logged in !'),
                actions: [
                  ElevatedButton.icon(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      Get.back();
                      _formKey.currentState?.reset();
                    },
                    icon: const Icon(Icons.close),
                    label: const Text('Close'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.to(
                        () => const AuthScreen(),
                      );
                    },
                    icon: const Icon(Icons.login),
                    label: const Text('Login'),
                  ),
                ],
              );
            }
          },
          text: 'Upload',
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  Container dropDownButton() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.purple, width: 1.5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          value: selectedCategory,
          onChanged: (value) {
            if (value is String) {
              setState(() {
                selectedCategory = value;
              });
            }
          },
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black,
          ),
          items: categoryList
              .map<DropdownMenuItem<String>>(
                  (value) => DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(
                          value.toString(),
                        ),
                      ))
              .toList(),
        ),
      ),
    );
  }
}
