import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
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
    final visitor = _Visitor(this, context);

    registry.addAwaitExpression(this, visitor);
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  _Visitor(this.rule, this.context);

  final AvoidNavigatorRule rule;
  final RuleContext context;

  @override
  void visitAwaitExpression(AwaitExpression node) {
    if (context.isInLibDir) {
      rule.reportAtNode(node);
    }
  }
}
