import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lego_list/src/widget/bloc/lego_list_cubit.dart';
import 'package:lego_list/src/widget/bloc/lego_list_state.dart';
import 'package:lego_list/src/widget/localization/app_localizations.dart';

class LegoListPage extends StatelessWidget {
  const LegoListPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Semantics(
            header: true,
            child: Text(AppLocalizations.of(context)!.legoWorlds),
          ),
        ),
        body: BlocBuilder<LegoListCubit, LegoListState>(
          builder: (context, state) =>
              state.grid ? const _Grid() : const _List(),
        ),
      );
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    final legoSets = context.watch<LegoListCubit>().state.legoSets;
    return FocusTraversalGroup(
      policy: ReadingOrderTraversalPolicy(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Semantics(
              button: true,
              label: 'Select ${legoSets[index].name}',
              child: ListTile(
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6C63FF), Color(0xFF03DAC6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.category, color: Colors.white),
                ),
                title: Text(
                  legoSets[index].name,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.white54),
                onTap: () => context
                    .read<LegoListCubit>()
                    .onLegoSetSelected(legoSets[index]),
              ),
            ),
          );
        },
        itemCount: legoSets.length,
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  const _Grid();

  @override
  Widget build(BuildContext context) {
    final legoSets = context.watch<LegoListCubit>().state.legoSets;
    return FocusTraversalGroup(
      policy: ReadingOrderTraversalPolicy(),
      child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: legoSets.length,
          itemBuilder: (context, index) {
            return Semantics(
              button: true,
              label: 'Select ${legoSets[index].name}',
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => context
                    .read<LegoListCubit>()
                    .onLegoSetSelected(legoSets[index]),
                child: Card(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2A2A2A), Color(0xFF1E1E1E)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          legoSets[index].name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
