import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentmanagement_provider/controllers/controller.dart';

class AddImageButton extends StatelessWidget {
  const AddImageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ActionController>(
      builder: (context, value, _) => SizedBox(
        height: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton.icon(
                onPressed: () {
                  value.pickImage();
                },
                icon: const Icon(Icons.upload_outlined),
                label: const Text("Add Photo")),
            Center(
              child: value.selectedImage != null
                  ? Image.file(
                      value.selectedImage!,
                      height: 150,
                    )
                  : const Text('No image selected'),
            ),
            IconButton(
                onPressed: () {
                  value.clearSelectedImage();
                },
                icon: Icon(Icons.close))
          ],
        ),
      ),
    );
  }
}
