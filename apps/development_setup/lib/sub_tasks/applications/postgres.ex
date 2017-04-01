defmodule DevelopmentSetup.Applications.Postgres do
  @postgres_legacy_app_download_url "https://github.com/PostgresApp/PostgresApp/releases/download/9.5.3/Postgres-9.5.3.zip"
  @postgres_app_download_url "https://github.com/PostgresApp/PostgresApp/releases/download/v2.0.2/Postgres-2.0.2.dmg"

  def prepare(force) do
    if MacVersion.is_at_least("10.10") do
      CommandTools.Installer.DMG.prepare("Postgres", @postgres_app_download_url, force)
    else
      CommandTools.Installer.ZIP.prepare("Postgres", @postgres_legacy_app_download_url, force)
    end
  end

  def install(force) do
    if MacVersion.is_at_least("10.10") do
      CommandTools.Installer.DMG.install("Postgres", @postgres_app_download_url, force)
    else
      CommandTools.Installer.ZIP.install("Postgres", @postgres_legacy_app_download_url, force)
    end
  end
end
