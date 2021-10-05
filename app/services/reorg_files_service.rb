class ReorgFilesService < ApplicationService
  def call
    reorg_files
  end

  private

  def reorg_files
    blobs.each do |blob|
      ReorgFileService.call(blob)
    end
  end

  def blobs
    @blobs ||= ActiveStorage::Blob.where("key LIKE ?", "active_storage%")
  end
end