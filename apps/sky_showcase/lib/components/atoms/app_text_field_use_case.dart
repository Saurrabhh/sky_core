import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive', type: AppTextField)
Widget appTextFieldInteractiveUseCase(BuildContext context) {
  final labelText = context.knobs.string(
    label: 'Label Text',
    initialValue: 'Input Label',
  );

  final hintText = context.knobs.string(
    label: 'Hint Text',
    initialValue: 'Placeholder hint...',
  );

  final errorText = context.knobs.string(
    label: 'Error Text',
  );

  final obscureText = context.knobs.boolean(
    label: 'Obscure Text',
  );

  final enabled = context.knobs.boolean(
    label: 'Enabled',
    initialValue: true,
  );

  final readOnly = context.knobs.boolean(
    label: 'Read Only',
  );

  final hasPrefix = context.knobs.boolean(
    label: 'Has Prefix Icon',
  );

  final hasSuffix = context.knobs.boolean(
    label: 'Has Suffix Icon',
  );

  final initialValue = context.knobs.string(
    label: 'Initial Value',
  );

  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Center(
      child: KeyedSubtree(
        key: UniqueKey(),
        child: AppTextField(
          initialValue: initialValue.isEmpty ? null : initialValue,
          labelText: labelText.isEmpty ? null : labelText,
          hintText: hintText.isEmpty ? null : hintText,
          errorText: errorText.isEmpty ? null : errorText,
          obscureText: obscureText,
          enabled: enabled,
          readOnly: readOnly,
          prefixIcon: hasPrefix ? const Icon(Icons.person) : null,
          suffixIcon: hasSuffix ? const Icon(Icons.info) : null,
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Variants', type: AppTextField)
Widget appTextFieldVariantsUseCase(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(AppSpacing.md),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.lg,
        children: [
          AppText.titleMedium('Input Configurations'),
          AppTextField(
            labelText: 'Username',
            hintText: 'Enter your username',
          ),
          AppTextField(
            labelText: 'Password',
            hintText: 'Enter your password',
            obscureText: true,
            suffixIcon: Icon(Icons.visibility_off),
          ),
          AppTextField(
            labelText: 'Search',
            hintText: 'Search matching keywords...',
            prefixIcon: Icon(Icons.search),
          ),
          Divider(),
          AppText.titleMedium('Validation & Disabled States'),
          AppTextField(
            labelText: 'Email Address',
            initialValue: 'invalid-email',
            errorText: 'Please enter a valid email address',
          ),
          AppTextField(
            labelText: 'Read-only Input',
            initialValue: 'This text cannot be modified',
            readOnly: true,
          ),
          AppTextField(
            labelText: 'Disabled Input',
            hintText: 'This field is fully disabled',
            enabled: false,
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Form Integration', type: AppTextField)
Widget appTextFieldFormUseCase(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(AppSpacing.md),
    child: _StatefulFormShowcase(),
  );
}

class _StatefulFormShowcase extends StatefulWidget {
  const _StatefulFormShowcase();

  @override
  State<_StatefulFormShowcase> createState() => _StatefulFormShowcaseState();
}

class _StatefulFormShowcaseState extends State<_StatefulFormShowcase> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final msg = 'Form Validated! Email: $_email, Pwd: ${_password.length}';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.md,
        children: [
          const AppText.titleMedium('Stateful Form Integration'),
          AppTextField(
            labelText: 'Email Address',
            hintText: 'you@example.com',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty || !value.contains('@')) {
                return 'Enter a valid email containing @';
              }
              return null;
            },
            onSaved: (value) => _email = value ?? '',
          ),
          AppTextField(
            labelText: 'Password',
            hintText: 'Enter secure password',
            obscureText: true,
            validator: (value) {
              if (value == null || value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
            onSaved: (value) => _password = value ?? '',
          ),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            width: double.infinity,
            child: AppButton.primary(
              text: 'Submit Form',
              onPressed: _submitForm,
            ),
          ),
        ],
      ),
    );
  }
}
