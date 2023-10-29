import '../../../entities/advantage.dart';
import 'advantages_list.dart';
import 'package:flutter/material.dart';

class AdvantageListPage extends StatefulWidget {
  final List<Advantage> advantages;
  final List<Advantage> disadvantages;
  final List<Advantage> selectedAdvantages;
  final Function(Advantage advantage) selectAdvantage;
  final Function(AmplifyingAdvantage advantage) increment;
  final Function(AmplifyingAdvantage advantage) decrement;
  final bool goToDisadvantages;

  final Listenable? listenable;
  final List<Advantage> Function()? retrieveSelectedAdvantages;

  const AdvantageListPage({
    required this.advantages,
    required this.disadvantages,
    required this.selectedAdvantages,
    required this.selectAdvantage,
    required this.increment,
    required this.decrement,
    this.goToDisadvantages = false,
    this.listenable,
    this.retrieveSelectedAdvantages,
    super.key,
  }) : assert(listenable != null && retrieveSelectedAdvantages != null ||
            listenable == null && retrieveSelectedAdvantages == null);

  @override
  State<AdvantageListPage> createState() => _AdvantageListPageState();
}

class _AdvantageListPageState extends State<AdvantageListPage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.goToDisadvantages) {
        Future.delayed(const Duration(milliseconds: 200)).then((value) {
          if (mounted) _tabController.animateTo(1);
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text("Vantagens"),
      bottom: TabBar(
        controller: _tabController,
        tabs: const [Tab(child: Text("Vantagens")), Tab(child: Text("Desvantagens"))],
      ),
    );

    if (widget.listenable != null) {
      return Scaffold(
        appBar: appBar,
        body: ListenableBuilder(
          listenable: widget.listenable!,
          builder: (context, child) {
            return TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: AdvantagesList(
                    advantages: widget.advantages,
                    selectedAdvantages: widget.retrieveSelectedAdvantages?.call() ?? widget.selectedAdvantages,
                    selectAdvantage: widget.selectAdvantage,
                    increment: widget.increment,
                    decrement: widget.decrement,
                  ),
                ),
                SingleChildScrollView(
                  child: AdvantagesList(
                    advantages: widget.disadvantages,
                    selectedAdvantages: widget.retrieveSelectedAdvantages?.call() ?? widget.selectedAdvantages,
                    selectAdvantage: widget.selectAdvantage,
                    increment: widget.increment,
                    decrement: widget.decrement,
                  ),
                ),
              ],
            );
          },
        ),
      );
    } else {
      return Scaffold(
        appBar: appBar,
        body: TabBarView(
          controller: _tabController,
          children: [
            SingleChildScrollView(
              child: AdvantagesList(
                advantages: widget.advantages,
                selectedAdvantages: widget.selectedAdvantages,
                selectAdvantage: widget.selectAdvantage,
                increment: widget.increment,
                decrement: widget.decrement,
              ),
            ),
            SingleChildScrollView(
              child: AdvantagesList(
                advantages: widget.disadvantages,
                selectedAdvantages: widget.selectedAdvantages,
                selectAdvantage: widget.selectAdvantage,
                increment: widget.increment,
                decrement: widget.decrement,
              ),
            ),
          ],
        ),
      );
    }
  }
}
