require "thor"

module Codelation
  class Cli < Thor
    POSTGRES_APP_DOWNLOAD_URL = "https://github.com/PostgresApp/PostgresApp/releases/download/9.5.3/Postgres-9.5.3.zip".freeze

  private

    # Install Postgres.app
    def install_postgres
      zip_file_path = download_file(POSTGRES_APP_DOWNLOAD_URL)
      extract_app_from_zip("Postgres.app", zip_file_path)
    end
  end
end
