class Api::ArticlesController < ApplicationController
  def preview
    @html = view_context.markdown(params[:body])
    puts @html
    puts "星星星"
  end
end