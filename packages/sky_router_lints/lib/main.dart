import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';
import 'package:sky_router_lints/src/rules/avoid_navigator_rule.dart';

/// The entry point instance of the [SkyRouterLintsPlugin].
final plugin = SkyRouterLintsPlugin();

/// Custom analyzer plugin class for `sky_router_lints` that registers rules.
class SkyRouterLintsPlugin extends Plugin {
  @override
  String get name => 'sky_router_lints';

  @override
  void register(PluginRegistry registry) {
    registry.registerLintRule(AvoidNavigatorRule());
  }
}
