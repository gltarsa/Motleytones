Rails.application.routes.draw do
  get 'users/new'

  root              'static_pages#home'
  get 'about'    => 'static_pages#about'
  get 'bios'     => 'static_pages#bios'
  get 'booking'  => 'static_pages#booking'
  get 'schedule' => 'static_pages#schedule'
  get 'photos'   => 'static_pages#photos'
  get 'videos'   => 'static_pages#videos'

  resources :users  #  add full complement of CRUD screens for new users
end
