Rails.application.routes.draw do
  get 'users/new'

  get '/', to: 'static_pages#home'
  get 'about',    to: 'static_pages#about'
  get 'bios',     to: 'static_pages#bios'
  get 'booking',  to: 'static_pages#booking'
  get 'schedule', to: 'static_pages#schedule'
  get 'photos',   to: 'static_pages#photos'
  get 'videos',   to: 'static_pages#videos'
  get 'add_user',   to: 'users#new'
end
