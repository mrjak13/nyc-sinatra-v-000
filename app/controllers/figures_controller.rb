class FiguresController < ApplicationController
  # add controller methods
  get '/figures' do
    erb :'/figures/index'
  end

  get '/figures/new' do
  
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  post '/figures' do
    
  end


end
