class Codelation::Development::DotFiles
  RUBOCOP = <<-CONTENT
Metrics/LineLength:
  Max: 100

Style/AccessModifierIndentation:
  EnforcedStyle: outdent

Style/AlignHash:
  EnforcedHashRocketStyle: table
  EnforcedColonStyle: table

Style/Blocks:
  Enabled: false

Style/RedundantSelf:
  Enabled: false

Style/SpaceBeforeFirstArg:
  Enabled: false

Style/SpaceInsideBlockBraces:
  SpaceBeforeBlockParameters: false

Style/StringLiterals:
  EnforcedStyle: double_quotes
CONTENT
end
