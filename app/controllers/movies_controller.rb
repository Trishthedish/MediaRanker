class MoviesController < ApplicationController
  def index
    @movies = Movie.order(vote_count: :desc).all
  end

  def new
    @mymovie = Movie.new
    @movie_method = :post
    @movie_path = movies_path
  end

  def show
    @mymovie = Movie.find(params[:id])
    if @mymovie == nil
        render :file => 'public/404.html', :status => :not_found
    end
  end

  def create
    @mymovie = Movie.new
    @mymovie.name = params[:movie][:name]
    @mymovie.director = params[:movie][:director]
    @mymovie.description = params[:movie][:description]
    @mymovie.save
    redirect_to users_path(@mymovie.id)
  end

  def update
    @mymovie = Movie.find(params[:id])
    if @mymovie == nil
      render :file => 'public/404.html', :status => :not_found
    end
    @mymovie.name = params[:movie][:name]
    @mymovie.director = params[:movie][:director]
    @mymovie.description = params[:movie][:description]
    @mymovie.save
    redirect_to movie_path(@mymovie.id)
  end

  def edit
    @mymovie = Movie.find(params[:id])
    @movie_method = :put
    @movie_path = movie_path
    if @mymovie == nil
      render :file => 'public/404.html',
      :status => :not_found
    end
  end

  def destroy
    @mymovie = Movie.find(params[:id])
    @mymovie.destroy
    redirect_to users_path(@mymovie.id)
  end

  def upvote
    @mymovie = Movie.find(params[:id])
    @mymovie.vote_count += 1
    @mymovie.save
    redirect_to :back
  end


end
