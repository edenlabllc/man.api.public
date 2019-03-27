defmodule Man.Repo.Migrations.UpdateCredentialsRecoveryRequest2 do
  use Ecto.Migration

  alias Man.Repo
  alias Man.Templates.API
  alias Man.Templates.Template

  def change do
    template_title = "Credentials recovery request"
    template_path = Application.app_dir(:man_api, "priv/static/credentials_recovery_request.mustache")

    patch = %{
      "body" => File.read!(template_path),
      "locales" => [
        %{
          "code" => "uk_UA",
          "params" => %{
            "thanks" => "З повагою, ",
            "endpoint" => Confex.fetch_env!(:man_api, :auth_host),
            "copyright" => "Всі права захищено",
            "ignoreLetter" => "Якщо ви не подавали запиту на зміну паролю, просто проігноруйте цей лист.",
            "passwordRecovery" => "Для відновлення паролю будь ласка перейдіть за посиланням: ",
            "allRightsReserved" => "Всі права захищено",
            "dpLink" => "ДП “Електронне здоров’я”",
            "nszuLink" => "Національна служба здоров'я України",
            "and" => "та"
          }
        }
      ]
    }

    Template
    |> Repo.get_by!(title: template_title)
    |> API.template_changeset(patch)
    |> Repo.update!()
  end
end
