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
    correctionMessage: "Use 'RouteHandler' instead",
    severity: .WARNING,
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
    // NamedType fires only on type-position identifiers (e.g. `Navigator.of(…)`
    // type references), skipping every plain identifier in the file.
    registry.addNamedType(this, _Visitor(this));
  }
}

/// AST Visitor that finds [Navigator] type references from Flutter.
///
/// Uses [NamedType] (not [SimpleIdentifier]) to reduce the visit surface to
/// type-position nodes only — import/export directives never contain
/// [NamedType] nodes, so no additional parent-walk is needed.
class _Visitor extends SimpleAstVisitor<void> {
  /// The rule triggering this visitor.
  final AnalysisRule rule;

  /// Instantiates the visitor associated with the given [rule].
  _Visitor(this.rule);

  @override
  void visitNamedType(NamedType node) {
    // Fast name check before any element resolution.
    if (node.name.lexeme != 'Navigator') return;

    final element = node.element;
    if (element is! ClassElement) return;

    final uri = element.library.uri;
    if (uri.scheme == 'package' && uri.pathSegments.firstOrNull == 'flutter') {
      rule.reportAtNode(node);
    }
  }
}
