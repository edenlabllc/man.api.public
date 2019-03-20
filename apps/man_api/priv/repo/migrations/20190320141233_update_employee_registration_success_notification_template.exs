defmodule Man.Repo.Migrations.UpdateEmployeeRegistrationSuccessNotificationTemplate do
  use Ecto.Migration

  alias Man.Repo
  alias Man.Templates.API
  alias Man.Templates.Template

  def change do
    template_title = "Employee registration success notification"
    template_path = Application.app_dir(:man_api, "priv/static/employee_registration_success_notification.mustache")

    patch = %{
      "body" => File.read!(template_path),
      "locales" => [
        %{
          "code" => "uk_UA",
          "params" => %{
            "thanks" => "З повагою,",
            "eHealth" => "Електронна система охорони здоров'я eHealth",
            "copyright" => "Електронна система охорони здоров'я eHealth. Всі права захищено",
            "welcomeHint" =>"Вітаємо! Вас було успішно додано до системи eHealth. Для того, щоб дізнатись більше про умови роботи та співпраці в системі eHealth.",
            "allRightsReserved" =>"Всі права захищено",
            "congratulationText" =>"Вітаємо з успішною реєстрацією в Електронній системі охорони здоров’я eHealth!",
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
