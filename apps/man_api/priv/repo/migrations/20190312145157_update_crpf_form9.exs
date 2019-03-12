defmodule Man.Repo.Migrations.UpdateCrpfForm9 do
  use Ecto.Migration

  alias Man.Templates.API
  
  def change do
    API.update_template_body!("CRPF", Application.app_dir(:man_api, "priv/static/CRPF.html.eex"))
  end
end
