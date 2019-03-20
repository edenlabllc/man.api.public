defmodule Man.Repo.Migrations.UpdateInvitationEmailTemplate do
  use Ecto.Migration

  alias Man.Repo
  alias Man.Templates.API
  alias Man.Templates.Template

  def change do
    template_title = "Invitation email"
    template_path = Application.app_dir(:man_api, "priv/static/invitation_email.mustache")

    patch = %{
      "body" => File.read!(template_path),
      "locales" => [
        %{
          "code" => "uk_UA",
          "params" => %{
            "hello" => "Вітаємо!",
            "thanks" => "З повагою,",
            "endpoint" => Confex.fetch_env!(:man_api, :auth_host),
            "copyright" => "Електронна система охорони здоров'я eHealth. Всі права захищено",
            "startText" => "У записі про цей заклад в Електронній системі охорони здоров’я для вас створено обліковий запис з роллю: ",
            "welcomeHint" => "Вітаємо! Вас запрошують приєднатись до системи eHealth, в рамках впровадження в Україні електронної системи охорони здоров’я.",
            "allRightsReserved" => "Всі права захищено",
            "hasRegisteredInEhealth" => "зареєстровано в електронній системі охорони здоров‘я.",
            "toAcceptInvitationFollowTheLink" => "Для підтвердження створення вашого облікового запису з відповідною роллю і функціями, будь ласка, перейдіть за посиланням: ",
            "rulesText" => "Ознайомитись із Порядком функціонування Електронної системи охорони здоров’я",
            "ignoreLetter" => "Якщо ви не подавали запиту на реєстрацію, просто проігноруйте цей лист.",
            "dpLink" => "Національна служба здоров'я України",
            "nszuLink" => "ДП “Електронне здоров’я”",
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
