import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starting_project/src/authentication/presentation/cubit/authentication_cubit.dart';

class AddUserDialog extends StatelessWidget {
  final TextEditingController nameController;

  const AddUserDialog({super.key, required this.nameController});
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
          child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
                labelText: 'username', alignLabelWithHint: true),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              final name = nameController.text.trim();
              context.read<AuthenticationCubit>().createUser(
                  createdAt: DateTime.now().toIso8601String(),
                  name: name,
                  avatar:
                      'https://www.shutterstock.com/image-illustration/avatar-modern-young-guy-working-260nw-2015853839.jpg');
            },
            child: const Text('Create User'),
          ),
        ]),
      )),
    );
  }
}
