import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  File? _image;
  List<dynamic>? _output;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _output = output;
      _loading = false;
      print(output);
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model_unquant.tflite',
      labels: 'assets/labels.txt',
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  pickImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    setState(() {
      _image = File(image.path);
      _loading = true;
    });

    classifyImage(_image!);
  }

  pickImageCamera() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return;

    setState(() {
      _image = File(image.path);
      _loading = true;
    });

    classifyImage(_image!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  _image == null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 51.0,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 24),
                              width: 400,
                              child: const Text(
                                'APLIKASI KLASIFIKASI MASKER \nMENGGUNAKAN FLUTTER',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(height: 80),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      'assets/ika.jpg',
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 140,
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    const Text(
                                      'IKA',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const Text(
                                      '059',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      'assets/laila.jpg',
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 140,
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    const Text(
                                      'LAILA FADILLA ASYURO',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const Text(
                                      '067',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      'assets/femas.jpg',
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 140,
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    const Text(
                                      'FEMAS ANUGRA',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const Text(
                                      '090',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      : Column(
                          children: [
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _image = null;
                                      _output = null;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    size: 30,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            const Text(
                              'KLASIFIKASI',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                              ),
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            Image.file(
                              _image!,
                              fit: BoxFit.fitHeight,
                              width: 300,
                              height: 200,
                            ),
                          ],
                        ),
                  const SizedBox(height: 16),
                  _output != null
                      // ignore: unrelated_type_equality_checks
                      ? Text(
                          _output!.isNotEmpty &&
                                  _output![0]!['confidence'] > 0.7
                              ? 'Label : ${_output![0]!['label']}'
                              : 'Tidak Diketahui',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        )
                      : Container(),
                  const SizedBox(height: 80),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: pickImageCamera,
                    child: Text(
                      'Gunakan Kamera',
                      style: TextStyle(
                        color: Colors.green.shade400,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: pickImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade400,
                    ),
                    child: const Text(
                      'Ambil Dari Galeri',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
