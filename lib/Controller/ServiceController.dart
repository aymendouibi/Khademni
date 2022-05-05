import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:memoire/models/service_model.dart';

import '../constant/firebase.dart';

class ServiceController extends GetxController {
final ValueNotifier<bool> _loading = ValueNotifier(false);
ValueNotifier<bool> get loading => _loading;

  final List<serviceModel> _ServiceList = [];
  List<serviceModel> get getServiceList => _ServiceList;
  final service = firebaseFirestore.collectionGroup("service");
  ServiceController() {
    getService();
  }
  getService() async {
    _loading.value = true;
   await service.get().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        _ServiceList.add(serviceModel.fromJson(value.docs[i].data()));
        _loading.value = false;
      }
      update();
    }
    
    );
  }
}
