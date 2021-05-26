# frozen_string_literal: true

Rails.application.routes.draw do
  get 'home/zipcode'
  root 'home#index'

  post 'zipcode' => 'home#zipcode'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
