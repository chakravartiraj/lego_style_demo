import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:harry_potter/src/flow/harry_potter_state.dart';
import 'package:harry_potter/src/widget/hp_list/bloc/hp_cubit.dart';
import 'package:harry_potter/src/widget/hp_list/bloc/hp_state.dart';
import 'package:harry_potter/src/widget/hp_list/localization/hp_localizations.dart';

class HpListPage extends StatelessWidget {
  const HpListPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        leading: BackButton(
            onPressed: () => context.flow<HarryPotterState>().complete()),
        title: Semantics(
          header: true,
          child: Text(HpLocalizations.of(context).chooseCharacter),
        ),
      ),
      body: BlocProvider<HPCubit>(
          create: (_) => GetIt.I.get<HPCubit>(),
          child: BlocBuilder<HPCubit, HPState>(builder: (context, state) {
            return FocusTraversalGroup(
              policy: ReadingOrderTraversalPolicy(),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Semantics(
                      button: true,
                      label: 'Select ${state.characters[index].name}',
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
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              state.characters[index].name[0],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          state.characters[index].name,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        trailing: const Icon(Icons.chevron_right, color: Colors.white54),
                        onTap: () => context.flow<HarryPotterState>().update(
                              (s) => s.copyWith(
                                  selectedCharacter: state.characters[index]),
                            ),
                      ),
                    ),
                  );
                },
                itemCount: state.characters.length,
              ),
            );
          })));
}
