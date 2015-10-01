class VersionsController < ApplicationController
  def show
    doc = Doc.find(params[:doc_id])
    version = doc.history_tracks.find_by(version: params[:id])

    render text: version.inspect.html_safe
  end
end
