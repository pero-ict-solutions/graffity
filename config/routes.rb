Rails.application.routes.draw do

  match "/_graffity" => "inspector#index"
  match '/_graffity/coderay/:id' => 'inspector#coderay', :as => :coderay
  match '/_graffity/current_items' => 'inspector#current_items', :as => :inspect_current_items
end
