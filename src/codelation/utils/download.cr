require "http/client"
require "progress"
require "../utils/*"

# Functions for downloading files
class Codelation::Utils::Download
  # Download a file with a progress bar.
  # @return [String] The path of the downloaded file
  def self.download_file(url : String, file_name : String)
    file_path = File.join(DirUtils.temp_directory, file_name)
    response = HTTP::Client.head(url)
    url = response.headers["Location"] if response.status_code.to_s.starts_with?("3")

    HTTP::Client.get(url) do |response|
      content_length = response.headers["Content-Length"].to_i
      index = 0

      progress_bar = ProgressBar.new
      progress_bar.total = 100
      progress_bar.width = 60
      progress_step = content_length / 100

      File.open(file_path, "wb") do |file|
        response.body_io.each_byte do |byte|
          file.write_byte(byte)

          # Update progress bar every 1%, but never past 99% because the progress bar
          # will be displayed twice if it hits 100% and ProgressBar#done is called.
          index += 1
          if index == progress_step && progress_bar.current < 99
            progress_bar.inc
            index = 0
          end
        end
      end

      progress_bar.done
    end

    file_path
  end
end
