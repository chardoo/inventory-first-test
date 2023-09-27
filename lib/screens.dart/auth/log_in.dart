import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rich_co_inventory/helpers/navigator.dart';
import 'package:rich_co_inventory/helpers/validators.dart';
import 'package:rich_co_inventory/providers/app_state_provider.dart';
import 'package:rich_co_inventory/providers/auth_provider.dart';
import 'package:rich_co_inventory/widgets/button.dart';
import 'package:rich_co_inventory/widgets/loading_layout.dart';
import 'package:rich_co_inventory/widgets/snac_bar.dart';
import 'package:rich_co_inventory/widgets/text_fields.dart';
import 'package:rich_co_inventory/widgets/texts.dart';

import '../dashboard_feauture/dashboard.dart';

class LogInScreen extends ConsumerStatefulWidget {
  const LogInScreen({super.key});

  @override
  ConsumerState<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<LogInScreen> {
  final _emailController = TextEditingController();

  final _pwdController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  (bool, String) validEmail = (true, "");
  (bool, String) validPassword = (true, "");
  @override
  Widget build(BuildContext context) {
    ref.watch(authProvider);
    if (ref.read(authProvider.notifier).isAuthenticated) {
      Future.microtask(() => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const DashBoard())));
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: LoadingLayout(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(24),
            child: Stack(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Spacer(),
                      Column(
                        children: [
                          Text(
                            "Welcome back 👋",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          Text(
                            "please enter your email & password",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                      const Spacer(flex: 3),
                      Visibility(
                          visible: !validEmail.$1,
                          child: MyText(text: validEmail.$2)),
                      MyTextFieldWithTitle(
                          keyboadType: TextInputType.emailAddress,
                          controller: _emailController,
                          onChanged: (val) {
                            setState(() {
                              validEmail = MyValidators.isEmail(val);
                            });
                          },
                          name: "Email",
                          label: "Type your email"),
                      const Spacer(),
                      Visibility(
                          visible: validPassword.$1,
                          child: MyText(
                            text: validPassword.$2,
                          )),
                      PasswordField(
                        pwdController: _pwdController,
                        onChanged: (val) {
                          validPassword = MyValidators.isPasswordValid(val);
                        },
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Forgot password?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
                          CustomButton(
                            width: double.infinity,
                            label: "Sign in Now",
                            ontap: () async {
                              validEmail =
                                  MyValidators.isEmail(_emailController.text);
                              validPassword = MyValidators.isPasswordValid(
                                  _pwdController.text);
                              if (!validEmail.$1) {
                                return MySnackBar.showSnack(
                                    validEmail.$2, context);
                              }
                              if (!validPassword.$1) {
                                return MySnackBar.showSnack(
                                    validPassword.$2, context);
                              }
                              var res =
                                  await ref.read(authProvider.notifier).logIn(
                                        email: _emailController.text,
                                        pwd: _pwdController.text,
                                      );
                              print("response $res");
                              if (mounted) {
                                if (res.$1) {
                                  MyNavigator.goto(context, const DashBoard());
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(res.$2)));
                                }
                              }
                            },
                          ),
                        ],
                      ),
                      const Spacer(flex: 2),
                      Wrap(children: [
                        const Text("New user? "),
                        Text(
                          "Sign up here ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.blue),
                        ),
                      ]),
                      const Spacer(flex: 2),
                      Wrap(
                        children: [
                          const Text(
                              "By using our services you are agreeing to our "),
                          Text(
                            "Terms",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.blue),
                          ),
                          const Text("and"),
                          Text(
                            "Privacy Policy",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.blue),
                          ),
                        ],
                      ),
                      const Spacer()
                    ]),
              ],
            ),
          )),
        ));
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required TextEditingController pwdController,
    this.onChanged,
  }) : _pwdController = pwdController;

  final TextEditingController _pwdController;
  final Function(String val)? onChanged;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return MyTextFieldWithTitle(
      keyboadType: TextInputType.visiblePassword,
      controller: widget._pwdController,
      onChanged: widget.onChanged,
      name: "password",
      label: "Type your password",
      // obsureText: isObscure,
      trailing: GestureDetector(
        onTap: () {
          setState(() {
            isObscure = !isObscure;
          });
        },
        child: Icon(
          isObscure ? Icons.visibility : Icons.visibility_off,
          color: Colors.grey,
        ),
      ),
    );
  }
}
