defmodule Man.Repo.Migrations.UpdateCrpfAppendixForm7 do
  @doc false

  use Ecto.Migration

  import Ecto.Changeset
  import Ecto.Query

  alias Man.Repo
  alias Man.Templates.Template

  def change do
    body = File.read!(Application.app_dir(:man_api, "priv/static/CRPF_appendix.html.eex"))

    Template
    |> where([t], t.title == "CRPF appendix")
    |> Repo.one!()
    |> cast(%{"body" => body}, ~w(body)a)
    |> Repo.update!()
  end
end
