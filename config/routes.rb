Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "private_registrations" }
  devise_scope :user do
    get    'users/new'      => 'private_registrations#new'
    get    'users/edit/:id' => 'private_registrations#edit', as: "edit_user"
    patch  'users/edit/:id' => 'private_registrations#update'
    delete 'users/:id'      => 'private_registrations#destroy'
  end

  root              'static_pages#home'
  get 'about'    => 'static_pages#about'
  get 'bios'     => 'static_pages#bios'
  get 'booking'  => 'static_pages#booking'
  get 'schedule' => 'static_pages#schedule'
  get 'photos'   => 'static_pages#photos'
  get 'videos'   => 'static_pages#videos'

  resources :users, only: [:index, :show ]
end
