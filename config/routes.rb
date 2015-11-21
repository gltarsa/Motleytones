Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    resources :users
  end

  root              'static_pages#home'
  get 'about'    => 'static_pages#about'
  get 'bios'     => 'static_pages#bios'
  get 'booking'  => 'static_pages#booking'
  get 'schedule' => 'static_pages#schedule'
  get 'photos'   => 'static_pages#photos'
  get 'videos'   => 'static_pages#videos'

  resources :gigs
  get 'manage_gigs'   => 'gigs#manage'
end
