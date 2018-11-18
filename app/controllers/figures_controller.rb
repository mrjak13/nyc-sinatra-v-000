class FiguresController < ApplicationController
  # add controller methods
  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do

    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  post '/figures' do
    # binding.pry

    # FIX REPEATING TITLES AND LAND MARKS IE IF CREATED DONT CREATE AGAIN
    # fIX IF NO CHECK BOXES SELECTED ERROR / BREAK
    if params[:figure][:name] == ""
      redirect '/figures/new'
    else
      name = params[:figure][:name]
      @figure = Figure.create(name: name)

      params[:figure][:title_ids] ? params[:figure][:title_ids].each{|title| @figure.titles << Title.find(title)} : nil

      params[:figure][:landmark_ids] ? params[:figure][:landmark_ids].each{|landmark| @figure.landmarks << Landmark.find(landmark)} : nil

      params[:title][:name] != "" ? @figure.titles << Title.create(name: params[:title][:name]) : nil

      params[:landmark] != "" ? @figure.landmarks << Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year]) : nil

    end

    binding.pry

    # params[:figure][:name] => new figure name, [:title_ids] => new figures selected titles already created, [:landmark_ids] => new figures selected landmarks already created
    # FOR CREATING NEW TITLE params[:title]
    # FOR CREATING NEW LANDMARK params[:landmark][:name] & params[:landmark][:year]
    redirect to "/figures/#{@figure.id}"

  end

  get '/figures/:id' do
    # raise params.inspect
    @figure = Figure.find(params[:id])

    erb :'/figures/show'
  end


end
