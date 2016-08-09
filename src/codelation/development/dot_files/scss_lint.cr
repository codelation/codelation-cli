class Codelation::Development::DotFiles
  SCSS_LINT = <<-CONTENT
# Default application configuration that all configurations inherit from.

scss_files: "**/*.scss"

linters:
  BangFormat:
    enabled: true
    space_before_bang: true
    space_after_bang: false

  BorderZero:
    enabled: true
    convention: zero # or `none`

  ColorKeyword:
    enabled: true

  ColorVariable:
    enabled: true

  Comment:
    enabled: true

  DebugStatement:
    enabled: true

  DeclarationOrder:
    enabled: true

  DuplicateProperty:
    enabled: true
    severity: error

  ElsePlacement:
    enabled: true
    style: same_line # or 'new_line'

  EmptyLineBetweenBlocks:
    enabled: true
    ignore_single_line_blocks: true
    severity: error

  EmptyRule:
    enabled: true

  FinalNewline:
    enabled: true
    present: true

  HexLength:
    enabled: true
    style: short # or 'long'
    severity: error

  HexNotation:
    enabled: true
    style: lowercase # or 'uppercase'
    severity: error

  HexValidation:
    enabled: true
    severity: error

  IdSelector:
    enabled: true
    severity: error

  ImportantRule:
    enabled: true
    severity: error

  ImportPath:
    enabled: true
    leading_underscore: false
    filename_extension: false

  Indentation:
    enabled: true
    allow_non_nested_indentation: false
    character: space # or 'tab'
    width: 2
    severity: error

  LeadingZero:
    enabled: true
    style: include_zero # or 'exclude_zero'

  MergeableSelector:
    enabled: true
    force_nesting: false

  NameFormat:
    enabled: true
    allow_leading_underscore: true
    convention: hyphenated_lowercase # or 'BEM', or a regex pattern
    severity: error

  NestingDepth:
    enabled: true
    max_depth: 3

  PlaceholderInExtend:
    enabled: true

  PropertyCount:
    enabled: false
    include_nested: false
    max_properties: 10

  PropertySortOrder:
    enabled: true
    ignore_unspecified: false
    separate_groups: false
    severity: error

  PropertySpelling:
    enabled: true
    extra_properties: []
    severity: error

  QualifyingElement:
    enabled: true
    allow_element_with_attribute: true
    allow_element_with_class: true
    allow_element_with_id: false

  SelectorDepth:
    enabled: true
    max_depth: 3

  SelectorFormat:
    enabled: true
    convention: hyphenated_lowercase # or 'BEM', or 'hyphenated_BEM', or 'snake_case', or 'camel_case', or a regex pattern

  Shorthand:
    enabled: true

  SingleLinePerProperty:
    enabled: true
    allow_single_line_rule_sets: true
    severity: error

  SingleLinePerSelector:
    enabled: true
    severity: error

  SpaceAfterComma:
    enabled: true
    severity: error

  SpaceAfterPropertyColon:
    enabled: true
    style: one_space # or 'no_space', or 'at_least_one_space', or 'aligned'
    severity: error

  SpaceAfterPropertyName:
    enabled: true
    severity: error

  SpaceBeforeBrace:
    enabled: true
    style: space # or 'new_line'
    allow_single_line_padding: false
    severity: error

  SpaceBetweenParens:
    enabled: true
    spaces: 0
    severity: error

  StringQuotes:
    enabled: true
    style: double_quotes # or 'single_quotes'

  TrailingSemicolon:
    enabled: true
    severity: error

  TrailingZero:
    enabled: false

  UnnecessaryMantissa:
    enabled: true

  UnnecessaryParentReference:
    enabled: true

  UrlFormat:
    enabled: true

  UrlQuotes:
    enabled: true

  VariableForProperty:
    enabled: true
    properties:
      - color
      - font

  VendorPrefixes:
    enabled: true
    identifier_list: base
    include: []
    exclude: [-webkit-font-smoothing]
    severity: error

  ZeroUnit:
    enabled: true

  Compass::*:
    enabled: false
CONTENT
end
