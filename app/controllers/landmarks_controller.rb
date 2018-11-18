class LandmarksController < ApplicationController
  # add controller methods
  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  get '/landmarks/new' do
    erb :'/landmarks/new'
  end

  post '/landmarks' do
    if params[:landmark][:name] == ""
      redirect to '/landmarks/new'
    else
      @landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
    end
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])

    erb :'/landmarks/show'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    erb :'landmarks/edit'
  end

  patch '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    if params[:landmark][:name] == "" || params[:landmark][:year_completed] == ""
      redirect to "/landmarks/#{@landmark.id}/edit"
    else
      @landmark.update(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
    end
    redirect to "landmarks/#{@landmark.id}"
  end
end
