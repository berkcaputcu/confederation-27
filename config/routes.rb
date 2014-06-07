Confederation27::Application.routes.draw do
  resources :songs, only: :destroy do
    get 'play', on: :collection
  end

  get 'play' => 'songs#play'

  root 'videos#index'

  get 'videos/index'
  get 'videos/add_to_queue'
end
