Kimkode::Application.routes.draw do
  root :to => "home#index"
  get "tags/:id" => "tags#show", :as => "tag"
  get "*slug" => "content#show", :as => "content"
end
