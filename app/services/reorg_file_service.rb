class ReorgFileService < ApplicationService
  attr_accessor :blob, :key

  PREFIX = "documents/vaccine-card"

  def initialize(blob)
    @blob = blob
    @key = blob.key
  end

  def call
    return unless exists?

    move_file
    move_variants
    update_blob
  end

  private

  def object
    bucket.object(key)
  end

  def exists?
    object.exists?
  end

  def bucket
    ActiveStorage::Blob.service.bucket
  end

  def move_file
    object.move_to("as-test-md/#{new_key}")
  end

  def move_variants
    bucket.objects(prefix: "variants/#{key}").each do |variant|
      variant.move_to("as-test-md/variants/#{new_key}")
    end
  end

  def new_key
    "#{PREFIX}/#{key}"
  end

  def update_blob
    blob.update(key: new_key)
  end
end
