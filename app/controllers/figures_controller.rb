class FiguresController < ApplicationController
  # add controller methods
  get '/figures' do
    erb :'/figures/index'
  end

  get '/figure/new' do
    erb :'/figure/new'
  end


end
