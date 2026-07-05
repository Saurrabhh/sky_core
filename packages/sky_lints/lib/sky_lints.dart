import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';
import 'package:sky_lints/src/rules/avoid_navigator.dart';

class SkyLintsPlugin extends Plugin {
  @override
  String get name => 'sky_lints';

  @override
  void register(PluginRegistry registry) {
    registry.registerWarningRule(AvoidNavigator());
  }
}

final plugin = SkyLintsPlugin();
