class DocumentsController < ApplicationController
  skip_forgery_protection

  def index
    @documents = Document.all
  end

  def create
    doc = Document.create!(document_params)
    doc.file.attach(params[:document][:file])
    render json: {
      url: doc.file.variant(resize: "2500x2500>").processed.service_url,
      name: doc.name
    }
  end

  private

  def document_params
    params.require(:document).permit(:name)
  end
end