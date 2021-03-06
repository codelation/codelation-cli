defmodule DevelopmentSetup.Config.ConfigFiles.Jshintrc do
  def content do
    '
{
  "boss":      true,
  "browser":   true,
  "camelcase": true,
  "curly":     true,
  "eqeqeq":    true,
  "eqnull":    true,
  "esversion": 6,
  "immed":     true,
  "indent":    2,
  "latedef":   true,
  "newcap":    true,
  "noarg":     true,
  "node":      true,
  "sub":       true,
  "undef":     true,
  "predef": {
    "alert":      true,
    "confirm":    true,
    "console":    true,
    "Turbolinks": true,
    "Vue":        true,
    "Vuex":       true
  }
}
    ' |> to_string
  end
end
