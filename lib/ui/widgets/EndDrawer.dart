import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:partnership/style/theme.dart';
import 'package:partnership/ui/widgets/LabeledIconButton.dart';
import 'package:partnership/ui/widgets/LabeledIconButtonList.dart';
import 'package:partnership/ui/widgets/CustomDialogs.dart';
import 'package:partnership/viewmodel/AViewModel.dart';

List<Widget> _buildRightDrawerButtons(
    {
        @required BuildContext context,
        @required AViewModel viewModel,
        @required bool profile,
        @required bool disconnect,
        @required bool searchMember,
        @required bool projectSearch,
        @required bool projectCreation,
        @required bool notification,
        @required bool settings,
        @required bool about,
        @required bool chat,
    })
{
  LabeledIconButton profileButton = LabeledIconButton(
    icon: Icon(Icons.account_circle, color: Colors.white),
    toolTip: 'Accéder à mon profil',
    onPressed: () {
      Navigator.of(context).pop();
      viewModel.changeView(route: '/profile_page', widgetContext: context);
    },
    text: "Accéder à mon profil",
    fullWidth: true,
  );
  LabeledIconButton searchMemberButton = LabeledIconButton(
    icon: Icon(Icons.search, color: Colors.white),
    toolTip: 'Rechercher un profil',
    onPressed: () {
      Navigator.of(context).pop();
      viewModel.changeView(route: '/search_member_page', widgetContext: context);
    },
    text: "Rechercher un profil",
    fullWidth: true,
  );
  LabeledIconButton projectSearchButton = LabeledIconButton(
    icon: Icon(Icons.youtube_searched_for, color: Colors.white),
    toolTip: 'Rechercher un projet',
    onPressed: () {
      Navigator.of(context).pop();
      viewModel.changeView(route: '/project_browsing_page', widgetContext: context);
    },
    text: "Rechercher un projet",
    fullWidth: true,
  );
  LabeledIconButton projectCreationButton = LabeledIconButton(
    icon: Icon(Icons.create, color: Colors.white),
    toolTip: 'Créer un projet',
    onPressed: () {
      Navigator.of(context).pop();
      viewModel.changeView(route: '/creation_page', widgetContext: context);
    },
    text: "Créer un projet",
    fullWidth: true,
  );
  LabeledIconButton notificationButton = LabeledIconButton(
    icon: Icon(Icons.notifications, color: Colors.white),
    toolTip: 'Accéder aux notifications',
    onPressed: () {
      Navigator.of(context).pop();
      viewModel.changeView(route: '/notifications_page', widgetContext: context);
    },
    text: "Mes notifications",
    fullWidth: true,
  );
  LabeledIconButton chatButton = LabeledIconButton(
    icon: Icon(Icons.email, color: Colors.white),
    toolTip: 'Chat',
    onPressed: () {
      Navigator.of(context).pop();
      viewModel.changeView(route: '/navig_page', widgetContext: context);
    },
    text: "Chat",
    fullWidth: true,
  );
  LabeledIconButton settingsButton = LabeledIconButton(
    icon: Icon(Icons.settings, color: Colors.white),
    toolTip: 'Réglages',
    onPressed: () => openSettingsDialog(context, 'Réglages', viewModel),
    text: "Réglages",
    fullWidth: true,
  );
  LabeledIconButton aboutButton = LabeledIconButton(
    icon: Icon(Icons.description, color: Colors.white),
    toolTip: 'À propos',
    onPressed: () => viewModel.getAssetBundle()
                              .loadString('assets/texts/about.txt')
                              .then((text) => openTextDialog(context, "À propos", text)),
    text: "À propos",
    fullWidth: true,
  );
  LabeledIconButton disconnectButton = LabeledIconButton(
    icon: Icon(Icons.power_settings_new, color: Colors.white),
    toolTip: 'Me déconnecter',
    onPressed: () => viewModel.disconnect(widgetContext: context),
    text: "Me déconnecter",
    fullWidth: true,
  );

  List<LabeledIconButton> result = new List<LabeledIconButton>();
  if (profile) result.add(profileButton);
  if (searchMember) result.add(searchMemberButton);
  if (projectCreation) result.add(projectCreationButton);
  if (projectSearch) result.add(projectSearchButton);
  if (notification) result.add(notificationButton);
  if (chat) result.add(chatButton);
  if (settings) result.add(settingsButton);
  if (about) result.add(aboutButton);
  if (disconnect) result.add(disconnectButton);
  return (result);
}

Widget _buildRightDrawer(
    {@required BuildContext context, @required List<Widget> buttonsList}) {
  BoxDecoration drawerDecoration = new BoxDecoration(
    gradient: AThemes.selectedTheme.bgGradient,
  );
  LabeledIconButtonList drawerContent = LabeledIconButtonList(
    childs: buttonsList,
    forceFullWidth: true,
  );
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

Widget buildEndDrawer({
      @required BuildContext context,
      @required AViewModel viewModel,
      bool profile = true,
      bool disconnect = true,
      bool searchMember = true,
      bool projectSearch = true,
      bool projectCreation = true,
      bool notification = true,
      bool chat = true,
      bool settings = true,
      bool about = true
    })
{
  List<Widget> buttonsList = _buildRightDrawerButtons(
      context: context,
      viewModel: viewModel,
      profile: profile,
      disconnect: disconnect,
      searchMember: searchMember,
      projectSearch: projectSearch,
      projectCreation: projectCreation,
      notification: notification,
      chat: chat,
      settings: settings,
      about: about,
  );
  return _buildRightDrawer(context: context, buttonsList: buttonsList);
}
