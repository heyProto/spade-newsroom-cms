Rails.application.routes.draw do

  resources :descriptions, except: [:show, :new, :create, :destroy], param: :seat_id do
    get "details", on: :member
  end

  resources :filters, except: [:show, :index, :edit]
  resources :permissions, except: [:update, :edit, :destroy], param: :url_hex
  resources :reference_lists, except: [:index, :show, :edit, :update]

  delete '/permissions/:url_hex/:seat_id', to: "permissions#destroy_seat_level", as: "delete_seat_permission"
  delete '/permissions/:url_hex', to: "permissions#destroy", as: "delete_permission_set"

  get '/descriptions/:seat_id', to: "descriptions#show", as: "description_details"
  get '/reference_list', to: "reference_lists#show", as: "reference_data_list"

  post '/filters/query', to: "filters#show"
  get '/manage-data/:url_hex/list', to: "filters#index", as: "list_data"
  get '/manage-data/:url_hex/:seat_id/edit', to: "filters#edit", as: "edit_data"

  root  "descriptions#index"
end
