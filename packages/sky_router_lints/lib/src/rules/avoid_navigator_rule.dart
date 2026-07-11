import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart';

/// A lint rule that discourages using Flutter's native [Navigator] class
/// in favor of [RouteHandler] from the `sky_router` package.
class AvoidNavigatorRule extends AnalysisRule {
  /// The diagnostic code reported by this rule.
  static const LintCode code = LintCode(
    'avoid_navigator',
    "Avoid using Flutter's 'Navigator' directly.",
    correctionMessage: "Use 'RouteHandler' instead for routing in the sky_router ecosystem.",
  );

  /// Instantiates [AvoidNavigatorRule] with the registered lint code and details.
  AvoidNavigatorRule()
      : super(
          name: code.lowerCaseName,
          description: 'Warns developers to use RouteHandler instead of Navigator.',
        );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(RuleVisitorRegistry registry, RuleContext context) {
    registry.addSimpleIdentifier(this, _Visitor(this));
  }
}

/// AST Visitor that finds references to [Navigator] class elements.
class _Visitor extends SimpleAstVisitor<void> {
  /// The rule triggering this visitor.
  final AnalysisRule rule;

  /// Instantiates the visitor associated with the given [rule].
  _Visitor(this.rule);

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    if (node.name == 'Navigator') {
      final element = node.element;
      
      if (element is ClassElement && element.name == 'Navigator') {
        final LibraryElement? library = element.library;
        final uri = library?.uri;
        if (uri != null && uri.scheme == 'package' && uri.pathSegments.firstOrNull == 'flutter') {
          if (!_isInImportOrExport(node)) {
            rule.reportAtNode(node);
          }
        }
      }
    }
  }

  bool _isInImportOrExport(SimpleIdentifier node) {
    AstNode? parent = node.parent;
    while (parent != null) {
      if (parent is ImportDirective || parent is ExportDirective) {
        return true;
      }
      parent = parent.parent;
    }
    return false;
  }
}
