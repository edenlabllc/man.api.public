defmodule Man.Repo.Migrations.UpdateCrpfForm5 do
  @moduledoc false

  use Ecto.Migration

  import Ecto.Changeset
  import Ecto.Query

  alias Man.Repo
  alias Man.Templates.Template

  def change do
    crf_body = File.read!(Application.app_dir(:man_api, "priv/static/CRPF.html.eex"))

    Template
    |> where([t], t.title == "CRPF")
    |> Repo.one!()
    |> cast(%{"body" => crf_body}, ~w(body)a)
    |> Repo.update!()
  end
end
