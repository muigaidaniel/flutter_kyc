import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked_services/stacked_services.dart';
part 'package:flutter_kyc/src/get_image.dart';

class Kyc extends StatefulWidget {
  Kyc({Key? key, required this.onSubmit, this.data}) : super(key: key);
  final Function(SheetResponse) onSubmit;
  Map<String, dynamic>? data;

  @override
  State<Kyc> createState() => _KycState();
}

class _KycState extends State<Kyc> {
  File? selfie;
  File? frontID;
  File? backID;
  int currentStep = 0;

  final BottomSheetService bottomSheetService = BottomSheetService();

  Future pickImage(ImageSource source, type) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    File? image = File(pickedFile!.path);
    image = await cropImage(imageFile: image, type: type);
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

  Future<File?> cropImage(
      {required File imageFile, required String type}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: type != 'selfie'
          ? const CropAspectRatio(ratioX: 3, ratioY: 2)
          : const CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    if (croppedImage != null) {
      return File(croppedImage.path);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stepper(
          elevation: 0,
          type: StepperType.horizontal,
          currentStep: currentStep,
          onStepCancel: () {
            if (currentStep > 0) {
              setState(() {
                currentStep -= 1;
              });
            }
          },
          onStepContinue: () {
            if (currentStep < mySteps().length - 1) {
              setState(() {
                currentStep += 1;
              });
            } else {
              widget.onSubmit(SheetResponse(
                confirmed: true,
                data: {
                  'selfie': selfie,
                  'frontID': frontID,
                  'backID': backID,
                },
              ));
            }
          },
          onStepTapped: (step) {
            setState(() {
              currentStep = step;
            });
          },
          steps: mySteps()),
    );
  }

  List<Step> mySteps() {
    List<Step> mySteps = [
      Step(
        isActive: currentStep >= 0,
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
        isActive: currentStep >= 1,
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
        isActive: currentStep >= 2,
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
      // Step(
      //   isActive: currentStep == 3,
      //   title: const Text('Verify'),
      //   content: VerifyImages(
      //     selfie: selfie,
      //     frontID: frontID,
      //     backID: backID,
      //   ),
      // )
    ];
    return mySteps;
  }
}
