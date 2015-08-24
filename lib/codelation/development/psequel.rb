require "thor"

module Codelation
  class Cli < Thor
    PSEQUEL_APP_DOWNLOAD_URL = "http://www.psequel.com/download?version=latest"

  private

    # Install PSequel.app
    def install_psequel
      zip_file_path = download_file(PSEQUEL_APP_DOWNLOAD_URL)
      extract_app_from_zip("PSequel.app", zip_file_path)
    end
  end
end
