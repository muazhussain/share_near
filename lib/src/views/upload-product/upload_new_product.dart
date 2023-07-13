import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_near/src/models/product_model.dart';
import 'package:share_near/src/services/data.dart';
import 'package:share_near/src/utils/constants.dart';
import 'package:share_near/src/utils/size_config.dart';
import 'package:share_near/src/views/global-components/app_text_form_field.dart';
import 'package:share_near/src/views/global-components/default_button.dart';
import 'package:share_near/src/views/upload-product/components/image_picker_button.dart';

class UploadNewProduct extends StatefulWidget {
  const UploadNewProduct({super.key});

  @override
  State<UploadNewProduct> createState() => _UploadNewProductState();
}

class _UploadNewProductState extends State<UploadNewProduct> {
  late final TextEditingController _productNameController;
  late final TextEditingController _productDetailsController;
  late final TextEditingController _rentCostController;
  late final TextEditingController _productPriceController;
  late final TextEditingController _rentDurationController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _productNameController = TextEditingController();
    _productDetailsController = TextEditingController();
    _rentCostController = TextEditingController();
    _productPriceController = TextEditingController();
    _rentDurationController = TextEditingController();
    _formKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productDetailsController.dispose();
    _rentCostController.dispose();
    _productPriceController.dispose();
    _rentDurationController.dispose();
    super.dispose();
  }

  bool _isProcessing = false;
  XFile? file1;
  XFile? file2;
  XFile? file3;
  XFile? file4;
  List<String> imageURL = [];

  setImage(int num) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    if (image == null) {
      return;
    }
    if (num == 1) {
      file1 = image;
    } else if (num == 2) {
      file2 = image;
    } else if (num == 3) {
      file3 = image;
    } else if (num == 4) {
      file4 = image;
    }
  }

  Future<void> newProductUpload() async {
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('productImage');
    String productName = _productNameController.text.trim();
    XFile? file;
    for (int i = 1; i <= 4; i++) {
      if (i == 1) {
        file = file1;
      } else if (i == 2) {
        file = file2;
      } else if (i == 3) {
        file = file3;
      } else if (i == 4) {
        file = file4;
      }
      if (file == null) {
        continue;
      }
      Reference referenceImageToUpload =
          referenceDirImages.child('${productName}_$i');
      String? url;
      final task = await referenceImageToUpload
          .putFile(File(file.path))
          .whenComplete(() => {});
      url = await task.ref.getDownloadURL();
      // ignore: unnecessary_null_comparison
      if (url == null) {
        continue;
      }
      imageURL.add(url);
      url = null;
    }
    Product product = Product(
      title: _productNameController.text.trim(),
      description: _productDetailsController.text.trim(),
      rentCost: int.parse(_rentCostController.text.trim()),
      productPrice: int.parse(_productPriceController.text.trim()),
      rating: 0,
      owner: appUserEmail ?? 'demo@email.com',
      latitude: appLatitude ?? 0,
      longitude: appLongitude ?? 0,
      rentDuration: int.parse(_rentDurationController.text.trim()),
      images: imageURL,
    );

    await Data().uploadNewProduct(product).whenComplete(() {
      log('done');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product Uploaded'),
          duration: Duration(seconds: 1),
        ),
      );
      log(product.latitude.toString());
      log(product.longitude.toString());
      _productNameController.clear();
      _productDetailsController.clear();
      _rentCostController.clear();
      _productPriceController.clear();
      _rentDurationController.clear();
      file1 = null;
      file2 = null;
      file3 = null;
      file4 = null;
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          duration: const Duration(seconds: 1),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add new product',
          style: TextStyle(color: Colors.black),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getScreenWidth(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                smallerGap,
                Text(
                  'Add New Product',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Complete your product\'s details',
                  textAlign: TextAlign.center,
                ),
                smallerGap,
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      AppTextFormField(
                        label: 'Product name',
                        hintText: 'Name of the product',
                        svgIcon: 'assets/icons/product.svg',
                        controller: _productNameController,
                        validator: (value) {
                          // ignore: unnecessary_null_comparison
                          bool res = _productNameController.text.trim() == null;
                          if (res) {
                            return 'Enter valid product name';
                          }
                          return null;
                        },
                      ),
                      smallerGap,
                      AppTextFormField(
                        label: 'Product details',
                        hintText: 'Write product details',
                        svgIcon: 'assets/icons/product-details.svg',
                        maxLines: 4,
                        maxLength: 100,
                        controller: _productDetailsController,
                        validator: (value) {
                          bool res =
                              // ignore: unnecessary_null_comparison
                              _productDetailsController.text.trim() == null;
                          if (res) {
                            return 'Enter valid product details';
                          }
                          return null;
                        },
                      ),
                      smallerGap,
                      AppTextFormField(
                        label: 'Rent cost',
                        hintText: 'Product rent cost',
                        svgIcon: 'assets/icons/nid.svg',
                        controller: _rentCostController,
                        textInputType: TextInputType.number,
                        validator: (value) {
                          final bool rentCostValid =
                              RegExp(r"^\d{3,}$").hasMatch(value ?? '');
                          if (rentCostValid) {
                            return null;
                          }
                          return 'Enter valid rent cost';
                        },
                      ),
                      smallerGap,
                      AppTextFormField(
                        label: 'Product price',
                        hintText: 'Product price',
                        svgIcon: 'assets/icons/nid.svg',
                        controller: _productPriceController,
                        textInputType: TextInputType.number,
                        validator: (value) {
                          final bool productPriceValid =
                              RegExp(r"^\d{3,}$").hasMatch(value ?? '');
                          if (productPriceValid) {
                            return null;
                          }
                          return 'Enter valid product price';
                        },
                      ),
                      smallerGap,
                      AppTextFormField(
                        label: 'Rent Duration',
                        hintText: 'Number of days',
                        svgIcon: 'assets/icons/calender.svg',
                        controller: _rentDurationController,
                        textInputType: TextInputType.number,
                        maxLength: 2,
                        validator: (value) {
                          final bool productPriceValid =
                              RegExp(r"^\d{1,2}$").hasMatch(value ?? '');
                          if (productPriceValid) {
                            return null;
                          }
                          return 'Enter valid days';
                        },
                      ),
                      smallerGap,
                      ImagePickereButton(
                        text: 'Pick image 1',
                        press: () async {
                          await setImage(1);
                        },
                      ),
                      littleGap,
                      ImagePickereButton(
                        text: 'Pick image 2',
                        press: () async {
                          await setImage(2);
                        },
                      ),
                      littleGap,
                      ImagePickereButton(
                        text: 'Pick image 3',
                        press: () async {
                          await setImage(3);
                        },
                      ),
                      littleGap,
                      ImagePickereButton(
                        text: 'Pick image 4',
                        press: () async {
                          await setImage(4);
                        },
                      ),
                      smallerGap,
                      DefaultButton(
                        widget: _isProcessing
                            ? CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: getScreenWidth(3),
                              )
                            : Text(
                                'Upload',
                                style: TextStyle(
                                  fontSize: getScreenWidth(18),
                                  color: Colors.white,
                                ),
                              ),
                        press: () async {
                          if ((_formKey.currentState!.validate())) {
                            setState(() {
                              _isProcessing = true;
                            });
                            await newProductUpload();
                            setState(() {
                              _isProcessing = false;
                            });
                          }
                        },
                      ),
                      smallerGap,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
