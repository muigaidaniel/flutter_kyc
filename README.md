<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

This is a simple package which can be used to input KYC documents such as National ID, and a selfie.

## Features

This can be used to input KYC documents such as National ID, and a selfie.

## Getting started

1. Add the latest version of the package to your pubspec.yaml (and run 'dart pub get'):

```yaml
dependencies:
  kyc: ^0.0.1
```

---

2. Android

   Add UCropActivity into your AndroidManifest.xml

   ```xml
   <activity
   	android:name="com.yalantis.ucrop.UCropActivity" 
   	android:screenOrientation="portrait" 
   	android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>
   ```

---

3. Web

   Add following codes inside `<head>` tag in file `web/index.html`:

```
   <head>
     ....

     <!-- Croppie -->
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/croppie/2.6.5/croppie.css" />
     <script defer src="https://cdnjs.cloudflare.com/ajax/libs/exif-js/2.3.0/exif.js"></script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/croppie/2.6.5/croppie.min.js"></script>

     ....
   </head>
```

---

5. Import the package and use it in your Flutter App.

 import *package:kyc/kyc.dart*;

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:flutter_kyc/flutter_kyc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: Kyc(
                      onSubmit: (data) {
                        print(data);
                      },
                    ),
                  );
                });
          },
          child: const Text('Start KYC'),
        ),
      ),
    );
  }
}


```

## Additional information
