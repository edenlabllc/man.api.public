defmodule Man.Repo.Migrations.UpdateRcrpfForm do
  use Ecto.Migration

  import Ecto.Changeset
  import Ecto.Query

  alias Man.Repo
  alias Man.Templates.Template

  def change do
    template_body = File.read!(Application.app_dir(:man_api, "priv/static/RCRPF.html.eex"))

    Template
    |> where([t], t.title == "RCRPF")
    |> Repo.one!()
    |> cast(%{body: template_body}, ~w(body)a)
    |> Repo.update!()
  end
end
