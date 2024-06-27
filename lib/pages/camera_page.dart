import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
// import 'package:path/path.dart' show join;
// import 'package:path_provider/path_provider.dart';
import '../edit_status_page.dart';
import 'package:logger/logger.dart';  // Importer le package logger

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraPage({Key? key, required this.cameras}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  final Logger _logger = Logger();  // Initialiser Logger

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.cameras[0],
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller?.initialize();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller!);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.camera_alt),
            onPressed: () async {
              try {
                await _initializeControllerFuture;
                await _controller?.takePicture().then((XFile file) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditStatusPage(imagePath: file.path),
                    ),
                  );
                });
              } catch (e) {
                _logger.e('Error taking picture: $e');
              }
            },
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            child: const Icon(Icons.videocam),
            onPressed: () async {
              try {
                await _initializeControllerFuture;
                await _controller?.startVideoRecording();
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enregistrement vidéo démarré')),
                );
              } catch (e) {
                _logger.e('Error starting video recording: $e');
              }
            },
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            child: const Icon(Icons.stop),
            onPressed: () async {
              try {
                await _controller?.stopVideoRecording().then((XFile file) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Enregistrement vidéo arrêté')),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditStatusPage(imagePath: file.path),
                    ),
                  );
                });
              } catch (e) {
                _logger.e('Error stopping video recording: $e');
              }
            },
          ),
        ],
      ),
    );
  }
}