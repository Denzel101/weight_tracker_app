import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker_app/domain/repositories/auth/auth_repository.dart';
import 'package:weight_tracker_app/locator.dart';
import 'package:weight_tracker_app/presentation/screens/auth/login_screen.dart';

import '../../../domain/repositories/cloud/cloud_repository.dart';
import '../../components/submit_button.dart';
import '../../provider/notification_state.dart';
import '../../widgets/auth/custom_text_field.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _weightTextEditingController =
      TextEditingController();
  late FocusNode _focusNodeWeight;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _focusNodeWeight = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNodeWeight.dispose();
    _weightTextEditingController.dispose();
    super.dispose();
  }

  void _removeFocusNodes() {
    // remove focus
    _focusNodeWeight.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight Tracker'),
        backgroundColor: Colors.purpleAccent,
        elevation: 0.0,
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                locator.get<AuthRepository>().signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.id, (route) => false);
              }),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          //remove focus
          _removeFocusNodes();
        },
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45.0),
                child: CustomTextField(
                  label: 'Enter Weight',
                  obscure: false,
                  textCapitalization: TextCapitalization.none,
                  keyBoard: TextInputType.number,
                  mFocusNode: _focusNodeWeight,
                  textEditingController: _weightTextEditingController,
                  mValidation: (value) {
                    // TODO: Thorough email validation needed
                    if (value!.trim().isEmpty) {
                      return 'Weight input is required';
                    } else if (value.trim().length <= 1) {
                      return 'Weight input must contain more than \n1 character';
                    }
                    return null;
                  },
                  mOnSaved: (String? value) {
                    _weightTextEditingController.text = value!;
                  },
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              // submit
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45.0),
                child: SubmitButton(
                  label: 'Save',
                  formKey: _formKey,
                  removeFocusNodes: _removeFocusNodes,
                  callBack: () async {
                    await locator.get<CloudRepository>().registerWeightAndDate(
                          weight: _weightTextEditingController.text,
                          dateTime: DateTime.now(),
                        );
                    _weightTextEditingController.clear();
                    Provider.of<NotificationState>(context, listen: false)
                        .showErrorToast('Weight recorded', false);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
