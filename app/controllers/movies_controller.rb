class MoviesController < ApplicationController

  def zomg
    render json: {message: "it works!"}, status: :ok
  end

  def index
    @movies = Movie.request_query(params, Movie)

    if @movies.empty?
      render json: {
        errors: { movie: ["No Movies were found"]}
        }, status: :not_found

      else
        render 'index.json'
      end
    end


    def show
      @movie = Movie.find_by(id: params[:id])

      if @movie
        render 'show.json'
      else
        render json: {errors: {movie: ["Cound not find movie with ID: #{params[:id]}"]}}, status: :not_found
      end
    end

    def create
      movie = Movie.new(movie_params)

      if movie.save
        render json: { id: movie.id }, status: :ok
      else
        render json: {
          errors: movie.errors.messages
        }, status: :bad_request
      end

    end

    private
    def movie_params
      return params.permit(:title, :overview, :release_date, :inventory)
    end
  end
