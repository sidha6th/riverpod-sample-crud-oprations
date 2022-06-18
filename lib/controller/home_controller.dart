import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_sample_crud_operation/model/list_model.dart';

final homeNotifier = StateNotifierProvider<HomeNotifier, List<ListModel>>(
    (ref) => HomeNotifier());

class HomeNotifier extends StateNotifier<List<ListModel>> {
  HomeNotifier() : super([]);
  getAllData() async {
    await Hive.openBox<ListModel>('List').then((box) {
      state = [...box.values];
    });
  }

  addDataIntoDb(ListModel value) {
    Hive.openBox<ListModel>('List').then((box) async {
      await box.add(value);
      state = [...state, value];
    });
  }

  delete(String key, int index) {
    Hive.openBox<ListModel>('List').then((box) async {
      await box.deleteAt(index);
      state.removeAt(index);
      state = [...state];
    });
  }

  editTheData(ListModel value, int index) {
    Hive.openBox<ListModel>('List').then((box) async {
      await box.put(value.key, value);
      state[index] = value;
      state = [...state];
    });
  }
}
