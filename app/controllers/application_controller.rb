class ApplicationController < Sinatra::Base
  # Set the default content type to JSON for all responses
  configure do
    set :default_content_type, 'application/json'
  end

  # Retrieve the first 10 games ordered by title
  get '/games' do
    games = Game.order(:title).limit(10)
    games.to_json
  end

  # Retrieve a single game by ID along with its reviews and associated user name
  get '/games/:id' do
    game = Game.find(params[:id])
    game.to_json(
      only: [:id, :title, :genre, :price],
      include: {
        reviews: {
          only: [:comment, :score],
          include: {
            user: {
              only: [:name]
            }
          }
        }
      }
    )
  end
end
