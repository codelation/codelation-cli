defmodule CommandTools.Download do
  def download(url, force) do
    if continue_downloading?(url, force) do
      HTTPotion.start
      %HTTPotion.Response{body: body} = HTTPotion.get url, [timeout: 100_000_000, follow_redirects: true]
      File.write!(Path.basename(url), body)
    end
  end

  def download(url, to, force) do
    if continue_downloading?(url, to, force) do
      HTTPotion.start
      %HTTPotion.Response{body: body} = HTTPotion.get url, [timeout: 100_000_000, follow_redirects: true]
      File.write!(to, body)
    end
  end

  defp continue_downloading?(url, force) do
     continue_downloading?(url, Path.basename(url), force)
  end

  defp continue_downloading?(_url, filename, force) do
    if File.exists?(filename) do
      CommandTools.prompt?("#{filename} already exists.  Do you want to re-download it?", force)
    else
      true
    end
  end
end
