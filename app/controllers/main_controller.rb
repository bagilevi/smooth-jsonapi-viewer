class MainController < ApplicationController
  def index
  end

  def view
    @document = Document.new(JSON.parse(params[:payload]))
    render :document
  end

  def example
    @document = Document.new(JSON.parse(File.read('tmp/example.json')))
    render :document
  end
end
