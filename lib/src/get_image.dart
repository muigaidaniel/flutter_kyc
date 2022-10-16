import 'dart:io';
import 'package:flutter/material.dart';

class GetImage extends StatelessWidget {
  const GetImage(
      {Key? key,
      required this.type,
      required this.image1,
      required this.onCameraClick,
      required this.onGalleryClick})
      : super(key: key);

  final String type;
  final File? image1;
  final Function onCameraClick;
  final Function onGalleryClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.6,
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Take a picture of ${type == 'front-id' ? 'the front of your ID' : type == 'back-id' ? 'the back of your ID' : 'yourself'}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.025,
              fontWeight: FontWeight.bold,
            ),
          ),
          type == 'selfie'
              ? CircleAvatar(
                  backgroundColor: image1 == null ? Colors.blue : null,
                  backgroundImage: image1 != null ? FileImage(image1!) : null,
                  radius: MediaQuery.of(context).size.width * 0.3,
                  child: image1 == null
                      ? const Text('No image selected',
                          style: TextStyle(color: Colors.white))
                      : null)
              : Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.blue,
                  ),
                  child: image1 != null
                      ? ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: Image.file(image1!, fit: BoxFit.cover))
                      : const Center(
                          child: Text('No image selected',
                              style: TextStyle(color: Colors.white))),
                ),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.06,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return Container(
                          margin: const EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    onPressed: () {
                                      onCameraClick();
                                    },
                                    child: const Text('Camera')),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              const Text('OR'),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              SizedBox(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    onPressed: () {
                                      onGalleryClick();
                                    },
                                    child: const Text('Gallery')),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: const Text('Select Image')),
          )
        ],
      ),
    );
  }
}
