import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rich_co_inventory/providers/app_state_provider.dart';
import 'package:rich_co_inventory/providers/auth_provider.dart';
import 'package:rich_co_inventory/widgets/button.dart';
import 'package:rich_co_inventory/widgets/text_fields.dart';

import '../dashboard.dart';

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

  @override
  Widget build(
    BuildContext context,
  ) {
    ref.watch(authProvider);
    if (ref.read(authProvider.notifier).isAuthenticated) {
      Future.microtask(() => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const DashBoard())));
    }
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(24),
      child: Stack(
        children: [
          Center(
              child: Column(
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
                          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 24),
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
                MyTextField(
                    controller: _emailController,
                    name: "Email",
                    label: "Type your email"),
                const Spacer(),
                MyTextField(
                  controller: _pwdController,
                  name: "Email",
                  label: "Type your password",
                  trailing: const Icon(
                    Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Forgot password?",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      width: double.infinity,
                      label: "Sign in Now",
                      ontap: () {
                        ref.read(authProvider.notifier).logIn(
                            email: _emailController.text,
                            pwd: _pwdController.text,
                            onError: (err) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(err)));
                            });
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
              ])),
          ref.watch(loadingStateProvider).show(context)
        ],
      ),
    )));
  }
}
