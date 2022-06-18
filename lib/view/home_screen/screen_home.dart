import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample_crud_operation/controller/home_controller.dart';
import 'package:riverpod_sample_crud_operation/extentions/extentions.dart';
import 'package:riverpod_sample_crud_operation/view/widgets/input_section.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  ScrollController? _scrollController;
  ValueNotifier<double> heightNotifier = ValueNotifier(230);
  int? length;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController?.addListener(
      () {
        if (_scrollController != null) {
          _scrollController!.offset > 10
              ? heightNotifier.value = 0
              : {
                  (length == null || length! < 6)
                      ? heightNotifier.value = 230
                      : heightNotifier,
                  heightNotifier.value = 230
                };
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final listOfData = ref.watch(homeNotifier);
    length = listOfData.length;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: ValueListenableBuilder(
            valueListenable: heightNotifier,
            builder: (_, height, __) {
              return Text(
                height == 0 ? 'ALL DATA' : 'ENTER THE EMAIL AND PHONE',
                style: const TextStyle(color: Colors.grey),
              );
            }),
      ),
      body: Column(
        children: <Widget>[
          ValueListenableBuilder(
            valueListenable: heightNotifier,
            builder: (_, double height, __) {
              return AnimatedContainer(
                curve: Curves.linear,
                width: context.getsize().width,
                height: height,
                duration: const Duration(milliseconds: 550),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    TextFormSWidget(
                      ref: ref,
                    ),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: listOfData.length,
              itemBuilder: (_, index) => ListTile(
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          ref
                              .read(homeNotifier.notifier)
                              .delete(listOfData[index].key, index);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                title: Text(listOfData[index].email),
                subtitle: Text(listOfData[index].phone),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
