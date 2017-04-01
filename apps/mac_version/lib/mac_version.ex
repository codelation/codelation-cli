defmodule MacVersion do
  def is do
    get_version
  end

  def is_at_least(version) do
   [mac_major, mac_minor, mac_patch] = get_version |> split_version
   [test_major, test_minor, test_patch] = version |> split_version |> fetch_test_version

    if compare(test_major, mac_major) >= 0 && compare(test_minor, mac_minor) >= 0 && compare(test_patch, mac_patch) >= 0 do
      true
    else
      false
    end
  end

  defp compare(lhs, rhs) do
    {ilhs, _} = Integer.parse(lhs)
    {irhs, _} = Integer.parse(rhs)
    if (ilhs < irhs) do
      1
    else
      if (ilhs > irhs) do
        -1
      else
        0
      end
    end
  end

  defp fetch_test_version([major]), do: [major, "0", "0"]
  defp fetch_test_version([major, minor]), do: [major, minor, "0"]
  defp fetch_test_version([major, minor, patch]), do: [major, minor, patch]

  defp split_version(version) do
    String.split(version, ".")
  end

  defp get_version do
    with {mac_data, _} <- System.cmd("sw_vers", []),
         [[version]] = Regex.scan(~r/\d{1,3}\.\d{1,3}\.\d{1,4}/, mac_data),
    do: version
  end
end
