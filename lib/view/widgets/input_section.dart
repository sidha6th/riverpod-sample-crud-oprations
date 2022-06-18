import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample_crud_operation/constants/const_varibles.dart';
import 'package:riverpod_sample_crud_operation/controller/home_controller.dart';
import 'package:riverpod_sample_crud_operation/model/list_model.dart';

class TextFormSWidget extends StatelessWidget {
  const TextFormSWidget({
    required this.ref,
    Key? key,
  }) : super(key: key);
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Form(
            key: formKey,
            child: Column(
              children: List.generate(
                2,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: index == 0 ? email : phone,
                    decoration: InputDecoration(
                      hintText: index == 0 ? 'Email' : 'Phone Number',
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                      fillColor: const Color.fromARGB(137, 164, 150, 150),
                      focusColor: const Color.fromARGB(137, 164, 150, 150),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Should be filled';
                      }
                      return null;
                    },
                    onChanged: (String? value) {
                      bool isNewAttempt = value != null &&
                          value.isEmpty &&
                          isUpdate.value == true;
                      if (isNewAttempt) {
                        isUpdate.value = false;
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              formKey.currentState!.validate()
                  ? {
                      isUpdate.value
                          ? ref.read(homeNotifier.notifier).editTheData(
                              ListModel(
                                email: email.text,
                                phone: phone.text,
                                key: selectedKey!,
                              ),
                              selectedIndex!)
                          : ref.read(homeNotifier.notifier).addDataIntoDb(
                                ListModel(
                                  email: email.text,
                                  phone: phone.text,
                                  key: DateTime.now()
                                      .microsecondsSinceEpoch
                                      .toString(),
                                ),
                              ),
                      email.clear(),
                      phone.clear()
                    }
                  : '';
            },
            child: ValueListenableBuilder(
                valueListenable: isUpdate,
                builder: (_, bool value, __) {
                  return Text(
                    value ? 'UPDATE' : 'SUBMIT',
                  );
                }),
          ),
        ],
      ),
    );
  }
}
