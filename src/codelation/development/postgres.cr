require "../utils/*"

# Functions for installing Postgres.app and PSequel.app
class Codelation::Development::Postgres
  include Codelation::Utils

  POSTGRES_APP_DOWNLOAD_URL = "https://github.com/PostgresApp/PostgresApp/releases/download/9.5.3/Postgres-9.5.3.zip"
  PSEQUEL_APP_DOWNLOAD_URL = "http://www.psequel.com/download?version=latest"

  def self.install_postgres_app
    if Dir.exists?("/Applications/Postgres.app")
      Print.print_command("Already installed")
      return
    end

    Print.print_command("Downloading from #{POSTGRES_APP_DOWNLOAD_URL}")
    file_path = Download.download_file(POSTGRES_APP_DOWNLOAD_URL, "postgres.zip")
    Zip.unzip(file_path, "/Applications")
    File.delete(file_path)
  end

  def self.install_psequel_app
    if Dir.exists?("/Applications/PSequel.app")
      Print.print_command("Already installed")
      return
    end

    Print.print_command("Downloading from #{PSEQUEL_APP_DOWNLOAD_URL}")
    file_path = Download.download_file(PSEQUEL_APP_DOWNLOAD_URL, "psequel.zip")
    Zip.unzip(file_path, "/Applications")
    File.delete(file_path)
  end
end
