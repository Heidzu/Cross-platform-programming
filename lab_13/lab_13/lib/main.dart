import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class NativeCameraApp extends StatefulWidget {
  @override
  _NativeCameraAppState createState() => _NativeCameraAppState();
}

class _NativeCameraAppState extends State<NativeCameraApp> {
  File? _capturedImage;
  final ImagePicker _imagePicker = ImagePicker();
  String? _imageTimestamp;
  String? _platformTime;

  static const platformChannel = MethodChannel('com.example/native_app_time');

  Future<void> _fetchPlatformTime() async {
    try {
      final String currentTime = await platformChannel.invokeMethod('getCurrentTime');
      setState(() {
        _platformTime = currentTime;
      });
    } on PlatformException catch (e) {
      setState(() {
        _platformTime = "Error: ${e.message}";
      });
    }
  }

  Future<void> _captureImage() async {
    final pickedImage = await _imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedImage != null) {
        _capturedImage = File(pickedImage.path);
        _imageTimestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(
          File(pickedImage.path).lastModifiedSync(),
        );
      }
    });
  }

  void _showPlatformTimeDialog() {
    _fetchPlatformTime();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Text(
          _platformTime ?? 'Fetching time...',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Native Camera App'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _capturedImage == null
              ? Text(
            'No image captured',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          )
              : Column(
            children: [
              Image.file(
                _capturedImage!,
                height: 300,
                width: 300,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Text(
                _imageTimestamp ?? '',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _showPlatformTimeDialog,
            child: Text('Show Current Time'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _captureImage,
        tooltip: 'Capture Image',
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: NativeCameraApp(),
    theme: ThemeData(primarySwatch: Colors.teal),
  ));
}
