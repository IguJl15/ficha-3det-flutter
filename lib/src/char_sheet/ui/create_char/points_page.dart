import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/edit_char_sheet.dart';
import 'points_page_widgets/attributes_session.dart';
import 'points_page_widgets/char_advantages_session.dart';
import 'points_page_widgets/char_skills_session.dart';
import 'points_page_widgets/remaining_points.dart';
import '../widgets/advantage_list/select_advantage_page.dart';

class PointsPage extends StatelessWidget {
  const PointsPage({super.key});

  void pushAdvantageListPage(BuildContext context, CreateCharViewModel viewModel, bool goToDisadvantages) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdvantageListPage(
          advantages: viewModel.getAllAdvantagesAvailable(),
          disadvantages: viewModel.getAllDisadvantagesAvailable(),
          selectedAdvantages: viewModel.state.advantages,
          selectAdvantage: viewModel.toggleAdvantage,
          increment: viewModel.incrementAdvantage,
          decrement: viewModel.decrementAdvantage,
          goToDisadvantages: goToDisadvantages,
          listenable: viewModel,
          retrieveSelectedAdvantages: () => viewModel.state.advantages,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateCharViewModel>(
      builder: (context, viewModel, _) {
        final charSheet = viewModel.state;

        return CustomScrollView(
          slivers: [
            SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
            SliverList.list(
              children: [
                RemainingPoints(remainingPoints: charSheet.points - charSheet.pointsSpent),
                CharAttributesSession(
                  attributes: charSheet.attributes,
                  resources: charSheet.resources,
                  incrementAttribute: viewModel.incrementAttribute,
                  decrementAttribute: viewModel.decrementAttribute,
                  pointsSpent: charSheet.pointsUsedOnAttributes,
                ),
                CharSkillsSession(
                  skills: viewModel.getAllSkillsAvailable(),
                  selectedSkills: charSheet.skills,
                  selectSkill: viewModel.toggleSkill,
                ),
                CharAdvantagesSession(
                  selectedAdvantages: charSheet.advantages,
                  increment: viewModel.incrementAdvantage,
                  decrement: viewModel.decrementAdvantage,
                  onButtonPressed: () => pushAdvantageListPage(context, viewModel, false),
                ),
                CharDisadvantageSession(
                  selectedDisadvantages: charSheet.advantages,
                  increment: viewModel.incrementAdvantage,
                  decrement: viewModel.decrementAdvantage,
                  onButtonPressed: () => pushAdvantageListPage(context, viewModel, true),
                ),
                const SizedBox(height: 80)
              ],
            ),
          ],
        );
      },
    );
  }
}
