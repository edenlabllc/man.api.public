defmodule Man.Repo.Migrations.UpdateContractsForm3 do
  use Ecto.Migration

  alias Man.Templates.API
  
  def change do
    API.update_template_body!("CRPF", Application.app_dir(:man_api, "priv/static/CRPF.html.eex"))
    API.update_template_body!("CRPF appendix", Application.app_dir(:man_api, "priv/static/CRPF_appendix.html.eex"))
    API.update_template_body!("RCRPF", Application.app_dir(:man_api, "priv/static/RCRPF.html.eex"))
  end
end
