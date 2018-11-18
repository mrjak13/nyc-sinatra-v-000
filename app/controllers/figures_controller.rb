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
    if params[:figure][:name] == ""
      redirect '/figures/new'
    else
      @figure = Figure.create(name: params[:figure][:name])

      params[:figure][:title_ids] ? params[:figure][:title_ids].each{|title| @figure.titles << Title.find(title.gsub("title_", ""))} : nil

      params[:figure][:landmark_ids] ? params[:figure][:landmark_ids].each{|landmark| @figure.landmarks << Landmark.find(landmark.gsub("landmark_", ""))} : nil

      params[:title][:name] != "" ? @figure.titles << Title.create(name: params[:title][:name]) : nil

      params[:landmark] != "" ? @figure.landmarks << Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year]) : nil
    end

    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all

    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])

    if params[:figure][:name] == ""
      redirect "/figures/#{@figure.id}/edit"
    else
      @figure.update(name: params[:figure][:name])

      params[:figure][:title_ids] ? params[:figure][:title_ids].each{|title| @figure.update(titles: Title.find(title.gsub("title_", "")))} : nil

      params[:figure][:landmark_ids] ? params[:figure][:landmark_ids].each{|landmark| @figure.update(landmarks: Landmark.find(landmark.gsub("landmark_", "")))} : nil

      params[:title][:name] != "" ? @figure.titles << Title.create(name: params[:title][:name]) : nil

      params[:landmark] != "" ? @figure.update(landmarks: Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year])) : nil
    end
    redirect to "/figures/#{@figure.id}"
  end
end
