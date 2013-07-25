class GridfsController < ApplicationController
  before_filter :authenticate_user!

  def avatar
  	@user = User.find(params[:id])
    content = @user.avatar.read
    if stale?(etag: content, last_modified: @user.updated_at.utc, public: true)
      send_data content, type: @user.avatar.file.content_type, disposition: "inline"
      expires_in 0, public: true
    end
  end

  def thumb_avatar
    @user = User.find(params[:id])
    content = @user.avatar.thumb.read
    if stale?(etag: content, last_modified: @user.updated_at.utc, public: true)
      send_data content, type: @user.avatar.file.content_type, disposition: "inline"
      expires_in 0, public: true
    end
  end

  def redactor_pitcure
    @pic = RedactorRails::Picture.find(params[:id])
    content = @pic.data.read
    if stale?(etag: content, last_modified: @pic.updated_at.utc, public: true)
      send_data content, type: @pic.data.file.content_type, disposition: "inline"
      expires_in 0, public: true
    end
  end

  def thumb_redactor_picture
    @pic = RedactorRails::Picture.find(params[:id])
    content = @pic.data.thumb.read
    if stale?(etag: content, last_modified: @pic.updated_at.utc, public: true)
      send_data content, type: @pic.data.file.content_type, disposition: "inline"
      expires_in 0, public: true
    end
  end

  def thumb_video
    @video = Video.find params[:id]
    content = @video.thumb.read
    if stale?(etag: content, last_modified: @video.updated_at.utc, public: true)
      send_data content, type: @video.thumb.file.content_type, disposition: "inline"
      expires_in 0, public: true
    end
  end
end
