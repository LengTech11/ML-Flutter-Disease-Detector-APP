import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class PredictModel {
  late Interpreter interpreter;

  Future<void> loadModel() async {
    try {
      interpreter = await Interpreter.fromAsset('assets/model/DenseNet.tflite');
      if (kDebugMode) {
        print("Model loaded");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error loading model: $e");
      }
      rethrow;
    }
  }

  // Preprocess the image before running the model
  Uint8List preprocessImage(Uint8List imageBytes) {
    img.Image? image = img.decodeImage(imageBytes);

    if (image == null) {
      throw Exception("Failed to decode image");
    }

    img.Image resizedImage = img.copyResize(image, width: 224, height: 224);

    // Extract RGB channels and ignore the alpha channel
    List<int> imagePixels = [];
    for (int y = 0; y < resizedImage.height; y++) {
      for (int x = 0; x < resizedImage.width; x++) {
        int pixel = resizedImage.getPixel(x, y);
        imagePixels.add(img.getRed(pixel));
        imagePixels.add(img.getGreen(pixel));
        imagePixels.add(img.getBlue(pixel));
      }
    }

    // Convert the list to Uint8List
    return Uint8List.fromList(imagePixels);
  }

  Float32List convertToFloat32(Uint8List input) {
    // Normalize the input pixels to [0, 1] and convert to Float32List
    final buffer = Float32List(input.length);
    for (int i = 0; i < input.length; i++) {
      buffer[i] = input[i] / 255.0;
    }
    return buffer;
  }

  Future<List<double>> runModelOnImage(Uint8List imageBytes) async {
    Uint8List input = preprocessImage(imageBytes);

    // Convert input to Float32List
    Float32List floatInput = convertToFloat32(input);

    // Reshape the input to [1, 224, 224, 3] (batch size, height, width, channels)
    // var inputShape = interpreter.getInputTensor(0).shape;
    var reshapedInput =
        Float32List.fromList(floatInput).reshape([1, 224, 224, 3]);

    var output = List.generate(1, (index) => List.filled(3, 0.0));

    // Run the model with the reshaped input
    interpreter.run(reshapedInput, output);

    return output[0];
  }
}
