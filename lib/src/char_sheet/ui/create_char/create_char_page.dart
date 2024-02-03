import 'package:ficha_3det_victory/src/char_sheet/entities/char_sheet.dart';
import 'package:ficha_3det_victory/src/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/char_sheet_repository.dart';
import '../../models/edit_char_sheet.dart';
import 'concept_page.dart';
import 'points_page.dart';

class CreateCharPage extends StatefulWidget {
  final CharSheet? editingChar;
  const CreateCharPage({this.editingChar, super.key});

  @override
  State<CreateCharPage> createState() => _CreateCharPageState();
}

class _CreateCharPageState extends State<CreateCharPage> with TickerProviderStateMixin {
  bool isLoading = true;
  late final TabController _tabController;

  late CreateCharViewModel viewModel;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    SharedPreferences.getInstance().then((value) {
      setState(() {
        viewModel = CreateCharViewModel(LocalCharSheetsRepository(value), widget.editingChar);
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Simular outro idioma no aparelho
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final result = viewModel.finishCharCreation();

          if (result) Navigator.pop(context);
        },
        child: const Icon(Icons.check),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ChangeNotifierProvider.value(
              value: viewModel,
              child: NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                      sliver: Selector<CreateCharViewModel, String>(
                        selector: (_, p1) => p1.state.name,
                        builder: (context, value, _) {
                          var title = context.l.newCharTitle;

                          if (value.trim().length > 2) title = value;

                          return SliverAppBar(
                            title: Text(title),
                            snap: true,
                            pinned: true,
                            floating: true,
                            forceElevated: innerBoxIsScrolled,
                            bottom: TabBar(
                              controller: _tabController,
                              tabs: [
                                Tab(text: context.l.newCharConcept_PageName),
                                Tab(text: context.l.newCharPoints_PageName),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: const [
                    ConceptPage(),
                    PointsPage(),
                  ],
                ),
              ),
            ),
    );
  }
}
