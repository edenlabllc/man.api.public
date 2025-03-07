defmodule Man.Repo.Migrations.AddInvitationEmailTemplate do
  use Ecto.Migration
  alias Man.Repo
  alias Man.Templates.Template
  import Ecto.Changeset

  def locale_changeset(%Man.Templates.Template.Locale{} = locale, attrs) do
    cast(locale, attrs, ~w(code params)a)
  end

  def change do
    result =
      case Repo.get_by(Template, %{:title => "Invitation email"}) do
        nil -> %Template{}
        template -> template
      end

    result
    |> cast(
      %{
        "title" => "Invitation email",
        "description" => nil,
        "syntax" => "mustache",
        "locales" => [
          %{
            "code" => "uk_UA",
            "params" => %{
              "Hello" => "Вітаємо!",
              "thanks" => "Дякуємо за те, що ви з нами!",
              "eHealth" => "Електронна система охорони здоров'я eHealth",
              "endpoint" => Confex.fetch_env!(:man_api, :auth_host),
              "Copyright" => "Електронна система охорони здоров'я eHealth. Всі права захищено",
              "StartText" => "У записі про цей заклад в системі eHealth для вас створено обліковий запис з роллю: ",
              "GoToProject" => "Хочу дізнатись більше про умови роботи та співпраці в системі eHealth.",
              "LegalEntity" => "Заклад",
              "WelcomeHint" =>
                "Вітаємо! Вас запрошують приєднатись до системи eHealth, в рамках впровадження в Україні електронної системи охорони здоров’я.",
              "eHealthSystem" => "електронної системи охорони здоров’я.",
              "YourPositionIs" => "Ваша посада",
              "whatIsLocatedIn" => "що знаходиться за адресою",
              "allRightsReserved" => "Всі права захищено",
              "hasRegisteredInEhealth" => "зареєстровано в електронній системі охорони здоров‘я eHealth.",
              "requestYouForCollaboration" => "Запрошує вас до співпраці на посаду",
              "toAcceptInvitationFollowTheLink" =>
                "Для підтвердження створення вашого облікового запису з відповідною роллю і функціями, будь ласка, перейдіть за посиланням: "
            }
          }
        ],
        "body" => """
        <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml" style="margin: 0; padding: 0; height: 100%;">\n<head>\n    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">\n    <meta name="viewport" content="width=device-width, initial-scale=1.0">\n    <meta name="description" content="{{l10n.WelcomeHint}}">\n\n    \n    \n\n    \n</head>\n<body style="margin: 0; padding: 0; height: 100%; color: #515151; font: 400 16px Roboto, Arial, sans-serif; line-height: 22px; -webkit-text-size-adjust: none; background-color: #f8f7f6;">\n<div style="font-size:0">{{l10n.WelcomeHint}}</div>\n<table class="main" cellpadding="0" cellspacing="0" border="0" width="100%" style="border-collapse: collapse; border-spacing: 0; height: 100%; width: 100%;">\n    <tr>\n        <td class="content" valign="top" align="center" style="padding: 32px;">\n            <table cellpadding="0" cellspacing="0" border="0" width="100%" style="border-collapse: collapse; border-spacing: 0; width: 100%; max-width: 957px; min-width: 200px;">\n                <tr>\n                    <td align="center" class="header" style="padding-bottom: 25px;">\n                        <table width="100%" cellpadding="0" cellspacing="0" border="0" style="border-collapse: collapse; border-spacing: 0;">\n                            <tr>\n                                <td class="head-space" style="width: 33%"></td>\n                                <td style="width: 33%" align="center">\n                                <a class="logo" href="#" style="color: #2892f0; text-decoration: none; font-weight: 700; outline: none; display: block; margin: 0 20px;">\n                                    <img height="50px" src="https://auth.ehealth-ukraine.org/images/logo.png" alt="eHealth logo">\n                                </a>\n                            </td>\n                                <td style="max-width: 33%; white-space: nowrap;" align="right">\n                                    <b>{{date}}</b>\n                                </td>\n                            </tr>\n                        </table>\n                    </td>\n                </tr>\n                <tr>\n                    <td valign="middle" align="left" class="body" style="padding: 70px; background-color: #fff;">\n                        <div>\n                            <p style="margin: 0 0 20px 0; padding: 0;">{{l10n.Hello}}</p>\n                            <p style="margin: 0 0 20px 0; padding: 0;">{{l10n.LegalEntity}} <b>"{{clinic_name}}"</b>, {{l10n.hasRegisteredInEhealth}}</p>\n                            <p style="margin: 0 0 20px 0; padding: 0;">\n                                {{l10n.StartText}}: <b>"{{doctor_role}}"</b>\n                            </p>\n                            <p style="margin: 0 0 20px 0; padding: 0;"><b>{{l10n.toAcceptInvitationFollowTheLink}}</b>: <a href="{{l10n.endpoint}}/invite?invite={{request_id}}" style="color: #2892f0; text-decoration: none; font-weight: 700; outline: none;">{{l10n.endpoint}}/invite?invite={{request_id}}</a></p>\n                            <br><br>\n                            <p style="margin: 0 0 20px 0; padding: 0;"><a href="https://ti-ukraine.org/news/rehlament-funktsionuvannia-pilotnoho-proektu-elektronnoi-systemy-okhorony-zdorov-ia/" style="color: #2892f0; text-decoration: none; font-weight: 700; outline: none;">{{l10n.GoToProject}}</a></p>\n                        </div>\n                    </td>\n                </tr>\n                <tr>\n                    <td valign="middle" align="left" class="body" style="padding: 70px; background-color: #fff;">\n                        <div>\n                            {{l10n.thanks}}<br>\n                            {{l10n.eHealth}}<br>\n                            <small>{{l10n.allRightsReserved}}</small>\n                        </div>\n                    </td>\n                </tr>\n                <tr><td align="center" class="footer" style="opacity: 0.5; font-size: 12px; line-height: 14px; padding-top: 60px;"><p style="margin: 0 0 20px 0; padding: 0;">© 2017 {{l10n.Copyright}}</p></td></tr>\n            </table>\n        </td>\n    </tr>\n</table>\n</body>\n</html>
        """
      },
      ~w(id title description syntax body)a
    )
    |> cast_embed(:locales, with: &locale_changeset/2)
    |> Repo.insert_or_update!()
  end
end
