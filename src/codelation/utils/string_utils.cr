class Codelation::Utils::StringUtils
  BLANK_RE = /\A[[:space:]]*\z/

  # A string is blank if it's empty or contains whitespaces only.
  # @return [Boolean]
  def self.blank?(string)
    string.to_s.empty? || BLANK_RE === string
  end
end
