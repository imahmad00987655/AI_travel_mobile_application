import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Document {
  final String name;
  final String description;
  final bool isRequired;
  bool isUploaded;
  String? imagePath;

  Document({
    required this.name,
    required this.description,
    required this.isRequired,
    this.isUploaded = false,
    this.imagePath,
  });
}

class RequiredDocumentsScreen extends StatefulWidget {
  const RequiredDocumentsScreen({super.key});

  @override
  State<RequiredDocumentsScreen> createState() => _RequiredDocumentsScreenState();
}

class _RequiredDocumentsScreenState extends State<RequiredDocumentsScreen> {
  final List<Document> _documents = [
    Document(
      name: 'Passport',
      description: 'Valid passport with at least 6 months validity',
      isRequired: true,
    ),
    Document(
      name: 'Visa',
      description: 'Valid visa for the destination country',
      isRequired: true,
    ),
    Document(
      name: 'Travel Insurance',
      description: 'Travel insurance covering the trip duration',
      isRequired: true,
    ),
    Document(
      name: 'Vaccination Certificate',
      description: 'Required vaccination certificates',
      isRequired: true,
    ),
    Document(
      name: 'Flight Tickets',
      description: 'Confirmed flight booking details',
      isRequired: true,
    ),
    Document(
      name: 'Hotel Booking',
      description: 'Confirmed hotel reservation details',
      isRequired: true,
    ),
  ];

  final ImagePicker _picker = ImagePicker();

  Future<void> _showImageSourceDialog(Document document) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Upload Document'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera, document);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery, document);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source, Document document) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          document.isUploaded = true;
          document.imagePath = image.path;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to pick image'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  bool get _allDocumentsUploaded {
    return _documents.every((doc) => doc.isUploaded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Required Documents'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _documents.length,
        itemBuilder: (context, index) {
          final document = _documents[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              document.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              document.description,
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (document.isUploaded)
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 32,
                        )
                      else
                        ElevatedButton(
                          onPressed: () => _showImageSourceDialog(document),
                          child: const Text('Upload'),
                        ),
                    ],
                  ),
                  if (document.imagePath != null) ...[
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(document.imagePath!),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: _allDocumentsUploaded
                ? () {
                    Navigator.pushNamed(context, '/application-tracking');
                  }
                : null,
            child: const Text('Continue'),
          ),
        ),
      ),
    );
  }
} 