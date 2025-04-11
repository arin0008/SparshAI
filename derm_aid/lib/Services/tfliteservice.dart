import 'dart:io';
import 'dart:typed_data';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class TFLiteService {
  late Interpreter interpreter;

  Future<void> loadModel() async {
    interpreter =
        await Interpreter.fromAsset('assets/Model/converted_model.tflite');
    print('Model loaded');
  }

  Future<List<double>> runModelOnImage(File imageFile) async {
    // Step 1: Decode and resize image
    final rawImage = img.decodeImage(imageFile.readAsBytesSync());
    final resizedImage = img.copyResize(rawImage!, width: 224, height: 224);

    // Step 2: Convert image to float32 list and normalize [0,255] -> [0,1]
    var input = List.generate(224, (y) {
      return List.generate(224, (x) {
        final pixel = resizedImage.getPixel(x, y);
        final r = img.getRed(pixel) / 255.0;
        final g = img.getGreen(pixel) / 255.0;
        final b = img.getBlue(pixel) / 255.0;
        return [r, g, b];
      });
    });

    // Step 3: Convert to tensor shape: [1, 224, 224, 3]
    var inputTensor = [input];

    // Step 4: Run inference
    var output = List.filled(7, 0.0).reshape([1, 7]); // Output shape [1, 7]
    interpreter.run(inputTensor, output);

    return List<double>.from(output[0]);
  }
}
