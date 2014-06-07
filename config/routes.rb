Confederation27::Application.routes.draw do
  resources :songs, only: [:index, :create, :destroy] do
    collection do
      get 'play'
      get 'search'
    end
  end

  root 'songs#search'
  get 'play' => 'songs#play'
end
