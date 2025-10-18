import 'dart:math';

import 'package:flatten/controllers/forms/form_mask_controller.dart';
import 'package:flatten/helpers/extensions/string.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/utils/my_string_utils.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_flex.dart';
import 'package:flatten/helpers/widgets/my_flex_item.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/helpers/widgets/my_text_style.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class FormMaskPage extends StatefulWidget {
  const FormMaskPage({super.key});

  @override
  State<FormMaskPage> createState() => _FormMaskPageState();
}

class _FormMaskPageState extends State<FormMaskPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late FormMaskController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(FormMaskController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Form Masks",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'forms'.tr()),
                        MyBreadcrumbItem(name: 'masks'.tr(), active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                  padding: MySpacing.x(flexSpacing),
                  child: MyContainer.bordered(
                    padding: MySpacing.bottom(flexSpacing),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: colorScheme.primary.withValues(alpha: 0.08),
                          padding: MySpacing.xy(flexSpacing, 12),
                          child: Row(
                            children: [
                              Icon(
                                LucideIcons.file_text,
                                size: 16,
                                color: colorScheme.primary,
                              ),
                              MySpacing.width(12),
                              MyText.titleMedium(
                                "Form Mask",
                                fontWeight: 600,
                                color: colorScheme.primary,
                              ),
                            ],
                          ),
                        ),
                        MySpacing.height(flexSpacing),
                        Padding(
                            padding: MySpacing.x(flexSpacing / 2),
                            child: MyFlex(
                              children: [
                                MyFlexItem(
                                  sizes: "lg-6 md-12",
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText.labelMedium(
                                        "Date Style 1",
                                      ),
                                      MySpacing.height(8),

                                      TextFormField(
                                        inputFormatters: [
                                          DateTextFormatter(),
                                        ],
                                        decoration: InputDecoration(
                                            border: outlineInputBorder,
                                            enabledBorder: outlineInputBorder,
                                            focusedBorder: focusedInputBorder,
                                            contentPadding: MySpacing.all(16),
                                            isCollapsed: true,
                                            helperText: '"dd/mm/yyy"',
                                            helperStyle: MyTextStyle.bodySmall(
                                                muted: true)),
                                      ),
                                      // MySpacing.height(4),
                                      // MyText.bodySmall("\"dd/mm/yyy\""),
                                    ],
                                  ),
                                ),
                                MyFlexItem(
                                  sizes: "lg-6 md-12",
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText.labelMedium(
                                        "Date Style 1",
                                      ),
                                      MySpacing.height(8),

                                      TextFormField(
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(10),
                                          PhoneInputFormatter(),
                                        ],
                                        decoration: InputDecoration(
                                            border: outlineInputBorder,
                                            enabledBorder: outlineInputBorder,
                                            focusedBorder: focusedInputBorder,
                                            contentPadding: MySpacing.all(16),
                                            isCollapsed: true,
                                            helperText: '"123456789"',
                                            helperStyle: MyTextStyle.bodySmall(
                                                muted: true)),
                                      ),
                                      // MySpacing.height(4),
                                      // MyText.bodySmall("\"dd/mm/yyy\""),
                                    ],
                                  ),
                                ),
                                MyFlexItem(
                                  sizes: "lg-6 md-12",
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText.labelMedium(
                                        "Date Style 2",
                                      ),
                                      MySpacing.height(8),

                                      TextFormField(
                                        inputFormatters: [
                                          DateTextFormatter(),
                                        ],
                                        decoration: InputDecoration(
                                            border: outlineInputBorder,
                                            enabledBorder: outlineInputBorder,
                                            focusedBorder: focusedInputBorder,
                                            contentPadding: MySpacing.all(16),
                                            isCollapsed: true,
                                            helperText: '"mm/dd/yyy"',
                                            helperStyle: MyTextStyle.bodySmall(
                                                muted: true)),
                                      ),
                                      // MySpacing.height(4),
                                      // MyText.bodySmall("\"dd/mm/yyy\""),
                                    ],
                                  ),
                                ),
                                MyFlexItem(
                                  sizes: "lg-6 md-12",
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText.labelMedium(
                                        "Mask",
                                      ),
                                      MySpacing.height(8),

                                      TextFormField(
                                        inputFormatters: [
                                          MaskTextFormatter(),
                                        ],
                                        decoration: InputDecoration(
                                            border: outlineInputBorder,
                                            enabledBorder: outlineInputBorder,
                                            focusedBorder: focusedInputBorder,
                                            contentPadding: MySpacing.all(16),
                                            isCollapsed: true,
                                            helperText: '"00-0000000"',
                                            helperStyle: MyTextStyle.bodySmall(
                                                muted: true)),
                                      ),
                                      // MySpacing.height(4),
                                      // MyText.bodySmall("\"dd/mm/yyy\""),
                                    ],
                                  ),
                                ),
                                MyFlexItem(
                                  sizes: "lg-6 md-12",
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText.labelMedium(
                                        "IP address",
                                      ),
                                      MySpacing.height(8),

                                      TextFormField(
                                        inputFormatters: [
                                          IpAddressInputFormatter(),
                                        ],
                                        decoration: InputDecoration(
                                            border: outlineInputBorder,
                                            enabledBorder: outlineInputBorder,
                                            focusedBorder: focusedInputBorder,
                                            contentPadding: MySpacing.all(16),
                                            isCollapsed: true,
                                            helperText: '"99.99.99.99"',
                                            helperStyle: MyTextStyle.bodySmall(
                                                muted: true)),
                                      ),
                                      // MySpacing.height(4),
                                      // MyText.bodySmall("\"dd/mm/yyy\""),
                                    ],
                                  ),
                                ),
                                MyFlexItem(
                                  sizes: "lg-6 md-12",
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText.labelMedium(
                                        "Email address",
                                      ),
                                      MySpacing.height(8),
                                      Form(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value != null &&
                                                value.isEmpty) {
                                              return 'Email is required';
                                            }
                                            if (value != null &&
                                                !MyStringUtils.isEmail(value)) {
                                              return 'Invalid Email';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              border: outlineInputBorder,
                                              enabledBorder: outlineInputBorder,
                                              focusedBorder: focusedInputBorder,
                                              contentPadding: MySpacing.all(16),
                                              isCollapsed: true,
                                              helperText: '"_@_._"',
                                              helperStyle:
                                                  MyTextStyle.bodySmall(
                                                      muted: true)),
                                        ),
                                      ),
                                      // MySpacing.height(4),
                                      // MyText.bodySmall("\"dd/mm/yyy\""),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  )),
            ],
          );
        },
      ),
    );
  }
}

//-----------------------Date Formatter-----------------------//
class DateTextFormatter extends TextInputFormatter {
  static const _maxChars = 8;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = _format(newValue.text, '/');
    return newValue.copyWith(text: text, selection: updateCursorPosition(text));
  }

  String _format(String value, String seperator) {
    value = value.replaceAll(seperator, '');
    var newString = '';
    for (int i = 0; i < min(value.length, _maxChars); i++) {
      newString += value[i];
      if ((i == 1 || i == 3) && i != value.length - 1) {
        newString += seperator;
      }
    }
    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}

//-----------------------Phone Number-----------------------//
class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');

    return newValue.copyWith(
      text: text.isNotEmpty ? '$text' : '',
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

//-----------------------IP address-----------------------//
class IpAddressInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    int dotCounter = 0;
    var buffer = StringBuffer();
    String ipField = "";

    for (int i = 0; i < text.length; i++) {
      if (dotCounter < 4) {
        if (text[i] != ".") {
          ipField += text[i];
          if (ipField.length < 3) {
            buffer.write(text[i]);
          } else if (ipField.length == 3) {
            if (int.parse(ipField) <= 255) {
              buffer.write(text[i]);
            } else {
              if (dotCounter < 3) {
                buffer.write(".");
                dotCounter++;
                buffer.write(text[i]);
                ipField = text[i];
              }
            }
          } else if (ipField.length == 4) {
            if (dotCounter < 3) {
              buffer.write(".");
              dotCounter++;
              buffer.write(text[i]);
              ipField = text[i];
            }
          }
        } else {
          if (dotCounter < 3) {
            buffer.write(".");
            dotCounter++;
            ipField = "";
          }
        }
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

//-----------------------Mask Formatter-----------------------//
class MaskTextFormatter extends TextInputFormatter {
  static const _maxChars = 10;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = _format(newValue.text, '-');
    return newValue.copyWith(text: text, selection: updateCursorPosition(text));
  }

  String _format(String value, String seperator) {
    value = value.replaceAll(seperator, '');
    var newString = '';
    for (int i = 0; i < min(value.length, _maxChars); i++) {
      newString += value[i];
      if ((i == 1) && i != value.length - 1) {
        newString += seperator;
      }
    }
    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}
