import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terrarium/components/popup_menu.dart';
import 'package:terrarium/screens/terrarium/cubit.dart';
import 'package:terrarium/screens/terrarium/state.dart';

class Terrarium extends StatefulWidget {
  const Terrarium({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TerrariumState();
  }
}

class _TerrariumState extends State<Terrarium> {
  ItemModel? selected;

  TerrariumCubit get cubit => context.read();

  void _showMenu(int id, Offset tapPosition) {
    showMenu<Response>(
            context: context,
            position: RelativeRect.fromRect(
              tapPosition & const Size(40, 40),
              const Offset(40.0, 60.0) & context.size!,
            ),
            items: [const HintsPopupMenuDelete(), const HintsPopupMenuStatus()])
        .then((value) {
      if (value != null) {
        switch (value) {
          case Response.delete:
            cubit.delete(id);
            break;
          case Response.status:
            cubit.openStatusDialog(id);
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TerrariumCubit, TerrariumState>(
      bloc: cubit,
      builder: (context, state) {
        return LayoutBuilder(builder: (context, constraints) {
          return MouseRegion(
            onHover: (e) {
              final safe = selected;
              if (safe != null) {
                cubit.updatePosition(
                  e.localPosition.translate(
                      -safe.width * constraints.maxWidth / 2,
                      -safe.height * constraints.maxHeight / 2),
                  Size(constraints.maxWidth, constraints.maxHeight),
                  safe.id,
                );
              }
            },
            child: Stack(
              children: [
                Positioned.fill(
                  child: Column(
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                ...state.items.map(
                  (e) => Positioned(
                    top: e.top * constraints.maxHeight,
                    left: e.left * constraints.maxWidth,
                    child: GestureDetector(
                      onSecondaryTapUp: (details) {
                        _showMenu(e.id, details.globalPosition);
                      },
                      onTap: () {
                        if (selected?.id == e.id) {
                          selected = null;
                        } else {
                          selected = e;
                        }
                      },
                      child: Opacity(
                        opacity: e.health == 0 ? 0.5 : 1,
                        child: Container(
                          color: const Color(0x00000000),
                          child: Image(
                            image: e.image,
                            height: e.height * constraints.maxHeight,
                            width: e.width * constraints.maxWidth,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 0,
                  right: 0,
                  child: Center(
                    child:
                        Text("Загрязнение террариума: ${100 - state.health}%"),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: IconButton(
                    onPressed: () {
                      cubit.pauseToggle();
                    },
                    icon: Icon(
                      state.isPaused ? Icons.play_arrow : Icons.pause,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
