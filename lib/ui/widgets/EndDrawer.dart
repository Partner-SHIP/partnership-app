import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:partnership/style/theme.dart';
import 'package:partnership/ui/widgets/LabeledIconButton.dart';
import 'package:partnership/ui/widgets/LabeledIconButtonList.dart';
import 'package:partnership/viewmodel/AViewModel.dart';

List<Widget> _buildRightDrawerButtons(
    {@required BuildContext context, 
    @required AViewModel viewModel, 
    @required bool profile, 
    @required bool disconnect, 
    @required bool searchMember,
    @required bool projectSearch,
    @required bool projectCreation}) {
  LabeledIconButton profileButton = LabeledIconButton(
    icon: Icon(Icons.account_circle, color: Colors.white),
    toolTip: 'Accéder à mon profil',
    onPressed: () =>
        viewModel.changeView(route: '/profile_page', widgetContext: context),
    text: "Accéder à mon profil",
    fullWidth: true,
  );
  LabeledIconButton  searchMemberButton = LabeledIconButton(
    icon: Icon(Icons.search, color: Colors.white),
    toolTip: 'Rechercher un profil',
    onPressed: () => viewModel.changeView(route: '/search_member_page', widgetContext: context),
    text: "Rechercher un profil",
    fullWidth: true,
  );
  LabeledIconButton  projectSearchButton = LabeledIconButton(
    icon: Icon(Icons.bluetooth_searching, color: Colors.white),
    toolTip: 'Rechercher un projet',
    onPressed: () => viewModel.changeView(route: '/project_browsing_page', widgetContext: context),
    text: "Rechercher un projet",
    fullWidth: true,
  );
    LabeledIconButton  projectCreationButton = LabeledIconButton(
    icon: Icon(Icons.create, color: Colors.white),
    toolTip: 'Créer un projet',
    onPressed: () => viewModel.changeView(route: '/creation_page', widgetContext: context),
    text: "Créer un projet",
    fullWidth: true,
  );
  LabeledIconButton disconnectButton = LabeledIconButton(
    icon: Icon(Icons.power_settings_new, color: Colors.white),
    toolTip: 'Me déconnecter',
    onPressed: () => viewModel.changeView(route: '/', widgetContext: context),
    text: "Me déconnecter",
    fullWidth: true,
  );
  List<LabeledIconButton> result = new List<LabeledIconButton>();
  if (profile)
    result.add(profileButton);
  if (searchMember)
    result.add(searchMemberButton);
  if (projectSearch)
    result.add(projectSearchButton);
  if (projectCreation)
    result.add(projectCreationButton);
  if (disconnect)
    result.add(disconnectButton);
  return (result);
}

Widget _buildRightDrawer(
    {@required BuildContext context, @required List<Widget> buttonsList}) {
  BoxDecoration drawerDecoration =
  new BoxDecoration(
    gradient: AThemes.selectedTheme.bgGradient,
  );
  LabeledIconButtonList drawerContent = LabeledIconButtonList(
    childs: buttonsList, forceFullWidth: true,);
  Widget drawerContentPositioning = Padding(
    child: drawerContent,
    padding: EdgeInsets.only(top: 24.0),
  );

  return (Drawer(
    child: Opacity(
      opacity: 0.8,
      child: Container(
        child: drawerContentPositioning,
        decoration: drawerDecoration,
      ),
    ),
  ));
}

Widget buildEndDrawer({@required BuildContext context, 
@required AViewModel viewModel,
bool profile = true,
bool disconnect = true, 
bool searchMember = true,
bool projectSearch = true,
bool projectCreation = true}) {
  List<Widget> buttonsList = _buildRightDrawerButtons(
      context: context,
      viewModel: viewModel,
      profile: profile,
      disconnect: disconnect,
      searchMember: searchMember,
      projectSearch: projectSearch,
      projectCreation: projectCreation);
  return _buildRightDrawer(context: context, buttonsList: buttonsList);
}