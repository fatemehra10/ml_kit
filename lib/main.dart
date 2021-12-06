import 'dart:io';

import 'package:camera/camera.dart';
import 'package:ml_kit_flutter/NlpDetectorViews/entity_extraction_view.dart';
import 'package:ml_kit_flutter/NlpDetectorViews/language_translator_view.dart';
import 'package:ml_kit_flutter/NlpDetectorViews/smart_reply_view.dart';
import 'package:ml_kit_flutter/VisionDetectorViews/object_detector_view.dart';
import 'NlpDetectorViews/language_identifier_view.dart';
import 'VisionDetectorViews/detector_views.dart';
import 'package:flutter/material.dart';

import 'VisionDetectorViews/text_detectorv2_view.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google ML Kit Demo App'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ExpansionTile(
                    title: const Text("Vision"),
                    children: [
                      const CustomCard(
                        'Image Label Detector',
                        ImageLabelView(),
                        featureCompleted: true,
                      ),
                      const CustomCard(
                        'Face Detector',
                        FaceDetectorView(),
                        featureCompleted: true,
                      ),
                      const CustomCard(
                        'Barcode Scanner',
                        BarcodeScannerView(),
                        featureCompleted: true,
                      ),
                      const CustomCard(
                        'Pose Detector',
                        PoseDetectorView(),
                        featureCompleted: true,
                      ),
                      CustomCard(
                        'Digital Ink Recogniser',
                        DigitalInkView(),
                        featureCompleted: true,
                      ),
                      const CustomCard(
                        'Text Detector',
                        TextDetectorView(),
                        featureCompleted: true,
                      ),
                      const CustomCard(
                        'Text Detector V2',
                        TextDetectorV2View(),
                      ),
                      const CustomCard(
                        'Object Detector',
                        ObjectDetectorView(),
                      ),
                      CustomCard(
                        'Remote Model Manager',
                        RemoteModelView(),
                        featureCompleted: true,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ExpansionTile(
                    title: const Text("Natural Language"),
                    children: [
                      CustomCard(
                        'Language Identifier',
                        LanguageIdentifierView(),
                        featureCompleted: true,
                      ),
                      CustomCard(
                          'Language Translator', LanguageTranslatorView()),
                      CustomCard('Entity Extractor', EntityExtractionView()),
                      CustomCard('Smart Reply', SmartReplyView())
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String _label;
  final Widget _viewPage;
  final bool featureCompleted;

   const CustomCard(this._label, this._viewPage,
      {Key? key, this.featureCompleted = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        tileColor: Theme.of(context).primaryColor,
        title: Text(
          _label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          if (Platform.isIOS && !featureCompleted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                    'This feature has not been implemented for iOS yet')));
          } else{
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => _viewPage));}
        },
      ),
    );
  }
}
