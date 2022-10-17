import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
part 'package:flutter_kyc/src/get_image.dart';

class Kyc extends StatefulWidget {
  const Kyc({Key? key}) : super(key: key);

  @override
  State<Kyc> createState() => _KycState();
}

class _KycState extends State<Kyc> {
  File? selfie;
  File? frontID;
  File? backID;
  int currentStep = 0;

  Future pickImage(ImageSource source, type) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    File? image = File(pickedFile!.path);
    image = await cropImage(imageFile: image);
    setState(() {
      switch (type) {
        case 'selfie':
          selfie = image;
          break;
        case 'frontID':
          frontID = image;
          break;
        case 'backID':
          backID = image;
          break;
        default:
          return;
      }
      Navigator.pop(context);
    });
  }

  Future<File?> cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
    );
    if (croppedImage != null) {
      return File(croppedImage.path);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stepper(
        type: StepperType.horizontal,
        currentStep: currentStep,
        onStepCancel: () {
          if (currentStep > 0) {
            setState(() {
              currentStep--;
            });
          }
        },
        onStepContinue: () {
          if (currentStep < 2) {
            setState(() {
              currentStep++;
            });
          }
        },
        onStepTapped: (step) {
          setState(() {
            currentStep = step;
          });
        },
        steps: [
          Step(
            isActive: currentStep == 0,
            title: const Text('Selfie'),
            content: GetImage(
              type: 'selfie',
              image1: selfie,
              onCameraClick: () {
                pickImage(ImageSource.camera, "selfie");
              },
              onGalleryClick: () {
                pickImage(ImageSource.gallery, "selfie");
              },
            ),
          ),
          Step(
            isActive: currentStep == 1,
            title: const Text('Front ID'),
            content: GetImage(
              type: 'front-id',
              image1: frontID,
              onCameraClick: () {
                pickImage(ImageSource.camera, "frontID");
              },
              onGalleryClick: () {
                pickImage(ImageSource.gallery, "frontID");
              },
            ),
          ),
          Step(
            isActive: currentStep == 2,
            title: const Text('Back ID'),
            content: GetImage(
              type: 'back-id',
              image1: backID,
              onCameraClick: () {
                pickImage(ImageSource.camera, "backID");
              },
              onGalleryClick: () {
                pickImage(ImageSource.gallery, "backID");
              },
            ),
          ),
        ],
      )),
    );
  }
}
