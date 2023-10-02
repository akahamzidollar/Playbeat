import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Notice'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Image(
                height: 200,
                image: AssetImage('assets/images/privacy.png'),
              ),
              RichText(
                textAlign: TextAlign.justify,
                text: const TextSpan(
                  text:
                      'This Privacy Notice explains how we collect, store, protect or otherwise process your personal information when you use our service like this application. Before using our service our service or providing your information, please carefully read this',
                  style: TextStyle(
                      color: Colors.black,
                      height: 1.5,
                      fontSize: 17,
                      fontWeight: FontWeight.w300),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' Privacy Notice\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '1. Responsibilities\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'We operate and offer our service globally.\nHowever our service remains same regarding where you live\n.',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    TextSpan(
                      text:
                          '2. How we collect your personal data and what type of personal data we collect\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'The term personal data follows a very broad understanding and means any information relating to an identified or identifiable individual. This means that not only the data that, for example, identifies you directly, such as your name or email address, is personal data but also other data, which when combined with other information accessible to us, enables us to link that data to you, for example an',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    TextSpan(
                      text: ' IP address\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'We obtain your personal data directly by you not from the other third parties and remains safe in our database and we just use your personal data for your better user experience\n',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    TextSpan(
                      text: '3. How we protect your personal data\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'The Security of your personal data is very important to us. We have taken reasonabily practical technical and organizational measures in accordance with industry standards to protect the personal data collected in connection with our service and prevent it with accidental or unlawful destruction, loss, alteration, unauthorized disclosers or access. However please note that although we have taken reasonabily measures to protect your personal data, no application, internet transmissions, computer systems or wireless connections are absolutely secure.',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    // TextSpan(
                    //   text: '4. Additional information or your rights regarding personal data\n',
                    //   style: TextStyle(fontWeight: FontWeight.bold),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
