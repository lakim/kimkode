Kimkode::Application.routes.draw do
  root :to => "home#index"
  get "tags/:id" => "tags#show", :as => "tag"
  get "sitemap" => "sitemap#show", :format => "xml"
  get "*slug" => "content#show", :as => "content"
end
