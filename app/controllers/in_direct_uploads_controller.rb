class InDirectUploadsController < ActiveStorage::DirectUploadsController
  skip_forgery_protection

  def create
    blob = ActiveStorage::Blob.create!(blob_args_with_key)
    render json: direct_upload_json(blob)
  end

  private

  def blob_args_with_key
    blob_args.merge({ key: generate_key_with_prefix })
  end

  def modified_active_storage_key
    if params[:model].present? && params[:email].present?
      "#{params[:model]}/#{params[:email]}"
    end
  end

  def generate_key_with_prefix
    File.join modified_active_storage_key, ActiveStorage::Blob.generate_unique_secure_token
  end
end