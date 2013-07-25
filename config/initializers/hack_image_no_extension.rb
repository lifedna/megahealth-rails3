# encoding: utf-8

require 'open-uri'

module CarrierWave
  module Uploader
    module Download

      class RemoteFile
      	def original_filename
      	  if file.meta.include? 'content-disposition'
            match = file.meta['content-disposition'].match(/filename=(\"?)(.+)\1/)
            return match[2] unless match.nil?
          end
          	
          filename = File.basename(file.base_uri.path)

          if File.extname(filename).blank?
            ext = case file.meta["content-type"]
              when "image/jpeg", "image/jpg", "image/pjpeg" then ".jpg"
              when "image/png", "image/x-png" then ".png"
              when "image/gif" then ".gif"
            end

            [filename, ext].join
          else
            filename
          end
        end
      end	
      
    end # Download
  end # Uploader
end # CarrierWave      