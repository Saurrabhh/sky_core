import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/error.dart';

class AvoidNavigatorRule extends AnalysisRule {
  AvoidNavigatorRule()
    : super(
        name: code.lowerCaseName,
        description:
            'Warns developers to use RouteHandler instead of Navigator.',
      );

  static const LintCode code = LintCode(
    'avoid_navigator',
    "Avoid using Flutter's 'Navigator' directly.",
    correctionMessage: "Use 'RouteHandler' instead",
    severity: .WARNING,
  );

  @override
  LintCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _Visitor(this);
    // Vastly more efficient than checking every SimpleIdentifier
    registry.addMethodInvocation(this, visitor);
    registry.addInstanceCreationExpression(this, visitor);
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  final AvoidNavigatorRule rule;

  _Visitor(this.rule);

  @override
  void visitMethodInvocation(MethodInvocation node) {
    final target = node.target;

    // Handles static method calls like `Navigator.of(context)`
    if (target is SimpleIdentifier && target.name == 'Navigator') {
      _checkAndReport(target, target.element);
    }
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    // Handles direct instantiations like `Navigator(...)`
    // We look directly at the resolved element of the created type
    // to bypass the broken ConstructorName/NamedType syntax trees.
    final element = node.staticType?.element;

    if (element != null && element.name == 'Navigator') {
      _checkAndReport(node, element);
    }
  }

  /// Safely checks the library URI using the modern Fragment API
  void _checkAndReport(AstNode node, Element? element) {
    if (element == null) return;

    // Grab the library
    final library = element.library;
    if (library == null) return;

    // Use the modern Fragment API to get the source (exactly as you had it originally!)
    final source = library.firstFragment.source;
    final libraryUri = source.uri.toString();

    // Verify it is the Flutter Navigator class.
    if (libraryUri == 'package:flutter/src/widgets/navigator.dart' ||
        libraryUri == 'package:flutter/widgets.dart') {
      rule.reportAtNode(node);
    }
  }
}
