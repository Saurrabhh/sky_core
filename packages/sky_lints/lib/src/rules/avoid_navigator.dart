import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';

class AvoidNavigator extends AnalysisRule {
  AvoidNavigator()
      : super(
          name: 'avoid_navigator',
          description: 'Enforces usage of RouteHandler over Navigator.',
        );

  static const _code = LintCode(
    'avoid_navigator',
    'Avoid using Navigator directly. Use RouteHandler instead.',
    correctionMessage: 'Replace with RouteHandler.',
  );

  @override
  DiagnosticCode get diagnosticCode => _code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final visitor = _Visitor(this, context);
    registry.addSimpleIdentifier(this, visitor);
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule, this.context);

  final AvoidNavigator rule;
  final RuleContext context;

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    if (node.name != 'Navigator') return;

    final element = node.element;
    if (element != null) {
      final library = element.library;
      if (library != null) {
        final libraryUri = library.firstFragment.source.uri.toString();
        if (libraryUri.contains('flutter/src/widgets/navigator.dart')) {
          rule.reportAtNode(node);
        }
      }
    }
  }
}
