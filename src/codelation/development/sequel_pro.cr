require "../utils/*"

# Functions for installing Sequel Pro.app
class Codelation::Development::SequelPro
  include Codelation::Utils

  DOWNLOAD_URL = "http://codelation-cli.s3.amazonaws.com/sequel-pro-1.1.2.zip"

  def self.install_sequel_pro
    if Dir.exists?("/Applications/Sequel Pro.app")
      Print.print_command("Already installed")
      return
    end

    Print.print_command("Downloading from #{DOWNLOAD_URL}")
    file_path = Download.download_file(DOWNLOAD_URL, "sequel_pro.zip")
    Zip.unzip(file_path, "/Applications")
    File.delete(file_path)
  end
end
