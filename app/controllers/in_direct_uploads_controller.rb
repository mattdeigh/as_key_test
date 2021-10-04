class InDirectUploadsController < ActiveStorage::DirectUploadsController
  around_action :set_modify_active_storage_key
  skip_forgery_protection

  private

  def set_modify_active_storage_key
    ActiveStorage::Blob.class_variable_set(:@@modified_key, modified_active_storage_key)
    yield
    ActiveStorage::Blob.class_variable_set(:@@modified_key, nil)
  end

  def modified_active_storage_key
    if params[:model].present? && params[:email].present?
      "#{params[:model]}/#{params[:email]}"
    end
  end
end