import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'camera_view.dart';
import 'face_detector_painter.dart';

class FaceDetectorView extends StatefulWidget {
  const FaceDetectorView({Key? key}) : super(key: key);

  @override
  _FaceDetectorViewState createState() => _FaceDetectorViewState();
}

class _FaceDetectorViewState extends State<FaceDetectorView> {
  FaceDetector faceDetector =
      GoogleMlKit.vision.faceDetector(const FaceDetectorOptions(
    enableContours: true,
    enableClassification: false,

    mode: FaceDetectorMode.fast,

  ));
  bool isBusy = false;
  CustomPaint? customPaint;

  @override
  void dispose() {
    faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      title: 'Face Detector',
      customPaint: customPaint,
      onImage: (inputImage) {
        processImage(inputImage);
      },
      initialDirection: CameraLensDirection.front,
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    final startTime = DateTime.now();
    if (isBusy) return;
    isBusy = true;
    final faces = await faceDetector.processImage(inputImage);

    debugPrint('Found ${faces.length} faces');
    
    final time = DateTime.now().microsecond - startTime.microsecond;
    debugPrint("\x1B[33m TIMEFACEDETACTOR: ${time.abs()}\x1B[0m");

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = FaceDetectorPainter(
          faces,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);
      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }
    isBusy = false;
    if (mounted) {
      setState(() {
        
      });
    }
    
  }
}
