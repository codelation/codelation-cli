defmodule DevelopmentSetup.Config.ConfigFiles.Rubocop do
  def content do
    '
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
    ' |> to_string
  end
end
