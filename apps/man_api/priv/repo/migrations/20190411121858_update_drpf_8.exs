defmodule Man.Repo.Migrations.UpdateDrpf8 do
  use Ecto.Migration
  
  alias Man.Templates.API

  def change do
    API.update_template_body!("DRPF", Application.app_dir(:man_api, "priv/static/DRPF.html.eex"))
  end
end
