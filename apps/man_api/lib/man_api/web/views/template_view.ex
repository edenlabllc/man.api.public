defmodule Man.Web.TemplateView do
  @moduledoc false

  use Man.Web, :view

  def render("index.json", %{templates: templates}) do
    render_many(templates, __MODULE__, "template.json")
  end

  def render("show.json", %{template: template}) do
    render_one(template, __MODULE__, "template.json")
  end

  def render("template.json", %{template: template}) do
    %{
      id: template.id,
      title: template.title,
      description: template.description,
      syntax: template.syntax,
      body: template.body,
      validation_schema: template.validation_schema,
      labels: template.labels,
      locales: render_many(template.locales, __MODULE__, "locale.json", as: :locale)
    }
  end

  def render("locale.json", %{locale: locale}) do
    Map.take(locale, ~w(code params)a)
  end
end
