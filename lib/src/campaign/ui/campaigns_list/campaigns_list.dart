import 'package:flutter/material.dart';

import '../../../shared/extensions/context_extensions.dart';

class CampaignsList extends StatelessWidget {
  const CampaignsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 4),
          child: Text(
            context.l.home_campaignsTitle,
            style: context.theme.textTheme.headlineSmall,
          ),
        ),
      ],
    );
  }
}
