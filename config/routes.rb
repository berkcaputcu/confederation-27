Confederation27::Application.routes.draw do
  get '*path' => 'songs#redirect_to_jukapp'

  resources :songs, only: [:index, :create, :destroy] do
    collection do
      get 'play'
      get 'search'
      get 'next'
    end
  end

  # root 'songs#search'
  root 'songs#redirect_to_jukapp'
  get 'play' => 'songs#play'
end
