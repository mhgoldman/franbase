class HistoryTracksController < ApplicationController
  def show
    doc = Doc.find(params[:doc_id])
    @history_track = doc.history_tracks.find_by(version: params[:version])
  end
end
