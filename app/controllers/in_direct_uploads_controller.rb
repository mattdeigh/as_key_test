class InDirectUploadsController < ActiveStorage::DirectUploadsController
  skip_forgery_protection

  def create
    blob = ActiveStorage::Blob.new(blob_args)
    blob.key = generate_key_with_prefix
    blob.save
    render json: direct_upload_json(blob)
  end

  private

  def modified_active_storage_key
    if params[:model].present? && params[:email].present?
      "#{params[:model]}/#{params[:email]}"
    end
  end

  def generate_key_with_prefix
    File.join modified_active_storage_key, ActiveStorage::Blob.generate_unique_secure_token
  end
end