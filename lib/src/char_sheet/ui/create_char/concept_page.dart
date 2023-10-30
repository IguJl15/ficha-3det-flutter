import 'dart:io';

import '../../entities/char_alignment.dart';
import '../../models/edit_char_sheet.dart';
import 'concept_page_widgets/alignment_selection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class ConceptPage extends StatefulWidget {
  const ConceptPage({super.key});

  @override
  State<ConceptPage> createState() => _ConceptPageState();
}

class _ConceptPageState extends State<ConceptPage> {
  final nameController = TextEditingController();
  final loreController = TextEditingController();

  Future<String?> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);

      return await _copyImageToPrivateStorage(file);
    } else {
      return null;
    }
  }

  Future<String> _copyImageToPrivateStorage(File file) async {
    final directory = await getApplicationSupportDirectory();

    final fileName = file.path.split('/').last;
    final destinationPath = '${directory.path}/$fileName';

    await file.copy(destinationPath);

    return destinationPath;
  }

  @override
  void dispose() {
    nameController.dispose();
    loreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateCharViewModel>(
      builder: (context, viewModel, _) {
        final charSheet = viewModel.state;

        nameController.text = charSheet.name;
        loreController.text = charSheet.lore;

        return CustomScrollView(
          slivers: [
            SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: SliverList.list(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        margin: const EdgeInsets.only(bottom: 4),
                        decoration: ShapeDecoration(
                          shape: const CircleBorder(),
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          shadows: kElevationToShadow[4],
                          image: charSheet.profilePhotoUrl != null
                              ? DecorationImage(image: FileImage(File(charSheet.profilePhotoUrl!)), fit: BoxFit.cover)
                              : null,
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FilledButton.tonalIcon(
                                label: const Text("Alterar foto"),
                                icon: const Icon(Icons.photo_camera),
                                onPressed: Platform.isIOS
                                    ? null
                                    : () {
                                        _pickImage().then((value) {
                                          if (value != null) viewModel.setImageUrl(value);
                                        });
                                      },
                              ),
                              if (charSheet.profilePhotoUrl != null)
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: IconButton.filledTonal(
                                    visualDensity: VisualDensity.compact,
                                    onPressed: () => viewModel.setImageUrl(null),
                                    icon: const Icon(Icons.delete),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll(Theme.of(context).colorScheme.errorContainer),
                                      iconColor:
                                          MaterialStatePropertyAll(Theme.of(context).colorScheme.onErrorContainer),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: nameController,
                    onChanged: (name) => viewModel.setName(name),
                    decoration: const InputDecoration(
                      label: Text("Nome"),
                      hintText: "João da Silva",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    maxLines: 3,
                    controller: loreController,
                    onChanged: (name) => viewModel.setLore(name),
                    decoration: const InputDecoration(
                      label: Text("História"),
                      hintText: "João nasceu em uma área remota...",
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    title: Text(charSheet.alignment.verbose),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: BorderSide(width: 1, color: Theme.of(context).colorScheme.outline),
                    ),
                    trailing: const Icon(Icons.arrow_drop_down),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    onTap: () {
                      showDialog<CharAlignment?>(
                        context: context,
                        builder: (context) => const AlignmentSelectionDialog(),
                      ).then((value) {
                        if (value != null) viewModel.setAlignment(value);
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
