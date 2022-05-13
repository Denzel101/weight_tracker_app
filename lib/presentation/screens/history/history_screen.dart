import 'package:flutter/material.dart';
import 'package:weight_tracker_app/data/models/user/weight_model.dart';
import 'package:weight_tracker_app/presentation/widgets/auth/custom_text_field.dart';

import '../../../domain/repositories/cloud/cloud_repository.dart';
import '../../../locator.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late TextEditingController newWeightTextEditingcontroller;
  late FocusNode _focusNodeWeight;

  @override
  void initState() {
    newWeightTextEditingcontroller = TextEditingController();
    _focusNodeWeight = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    newWeightTextEditingcontroller.dispose();
    _focusNodeWeight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: Colors.purpleAccent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: StreamBuilder<List<WeightModel>>(
            stream: locator.get<CloudRepository>().getWeightList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final _historyList = snapshot.data ?? [];
              if (_historyList.isEmpty) {
                return const Center(
                    child: Text(
                  'Weights not added yet',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ));
              }
              return ListView.builder(
                  itemCount: _historyList.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final userWeight = _historyList[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      height: 150.0,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              newWeightTextEditingcontroller.text =
                                  userWeight.userWeight;
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: CustomTextField(
                                        label: 'Enter New Weight',
                                        obscure: false,
                                        keyBoard: TextInputType.number,
                                        mFocusNode: _focusNodeWeight,
                                        textCapitalization:
                                            TextCapitalization.none,
                                        mValidation: (value) {
                                          if (value!.trim().isEmpty) {
                                            return 'Weight input is required';
                                          } else if (value.trim().length <= 1) {
                                            return 'Weight input must contain more than \n1 character';
                                          }
                                          return null;
                                        },
                                        textEditingController:
                                            newWeightTextEditingcontroller,
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            await locator
                                                .get<CloudRepository>()
                                                .updateWeightEntry(
                                                  userWeight.id,
                                                  newWeightTextEditingcontroller
                                                      .text,
                                                );
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Submit'),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: const CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.edit),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                userWeight.userWeight,
                                style: const TextStyle(
                                  fontSize: 50.0,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Text(
                                  'kg',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              locator
                                  .get<CloudRepository>()
                                  .deleteWeightEntry(userWeight.id);
                            },
                            child: const CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.delete),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
