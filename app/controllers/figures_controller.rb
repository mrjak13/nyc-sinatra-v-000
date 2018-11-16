class FiguresController < ApplicationController
  # add controller methods
  get '/figures' do
    erb :'figures/index'
  end


end
