import 'package:flutter/material.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/deputies_chooser/step_search_bar_bloc.dart';
import 'package:provider/provider.dart';

class StepSearchBar extends StatelessWidget {
  final Function(String) setSearchQuery;

  const StepSearchBar({Key? key, required this.setSearchQuery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final searchBarBloc = Provider.of<StepSearchBarBloc>(context);

    return Consumer<StepSearchBarBloc>(
      builder: (context, bloc, child) => AnimatedContainer(
        duration: Duration(milliseconds: 133),
        width: double.infinity,
        height: bloc.isVisible ? 50 : 0,
        color: theme.primaryColor,
        child: Visibility(visible: bloc.isVisible, child: child!),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: "",
                onChanged: (query) {
                  setSearchQuery(query);
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Wyszukaj posła...",
                    hintStyle: TextStyle(color: Colors.white54)),
              ),
            ),
            GestureDetector(
              onTap: () {
                setSearchQuery("");
                searchBarBloc.hide();
              },
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
