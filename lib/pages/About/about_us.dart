import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About application'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Image(
                height: 200,
                image: AssetImage('assets/images/about.png'),
              ),
              RichText(
                textAlign: TextAlign.justify,
                text: const TextSpan(
                  text:
                      'This application is giving online music with playback option to its users so they can listen music by doing other works on same device with no need to manually download the music in device. This about us page will help to explain the use of our application',
                  style: TextStyle(
                      color: Colors.black,
                      height: 1.5,
                      fontSize: 17,
                      fontWeight: FontWeight.w300),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' Play Beat, ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'how our application will operate and what are the functions this application giving to its users. Lets talk about those main functions which will be given by our application to its users.\n',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    TextSpan(
                      text: 'Music defined in categories\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'Music in this application is defined in their relevant categories, users of this application can listen music in their desired category.\n',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    TextSpan(
                      text: 'Random music\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'We have an option named all in which random music with different categories available and user can experience taste of different categories in one go.\n',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    TextSpan(
                      text: 'Favorite music\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'Users have an option to make list of their favorite songs in this application and have an option to listen or enjoy them seperatily in one go.\n',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    TextSpan(
                      text: 'User can upload song as well\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'We provide the facility of our users to upload their or their favorite songs as well in their relevant category, after got approval by admin their songs will be uploaded in their category after than other global users will able to listen or enjoy that song.\n',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    TextSpan(
                      text: 'User\'s uploads\n',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'Users can monitor his/her uploads in this application and can check the status of his/her song\'s approval, also they can delete his/her upload.',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
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
