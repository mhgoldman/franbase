#TODO: Make this actually be the HistoryTracker class?
#Also, Revision might be better than Version
class Version
  attr_accessor :modified_values_before, :modified_values_after, :unmodified_values

  def initialize(doc_id, id)
    doc = Doc.find(doc_id)
    history_track = doc.history_tracks.find_by(version: id)

    @modified_values_before = history_track.original
    @modified_values_after = history_track.modified
    
    unmodified_values_keys = Doc.fields.keys - @modified_values_after.keys

    @unmodified_values = {}
    unmodified_values_keys.each do |key|
      prev_versions = doc.history_tracks.select {|v| v.version < id}.sort_by {|ht| -ht.version}
      prev_versions.each do |prev_version|
        if prev_version['modified'][key]
          @unmodified_values[key] =  prev_version['modified'][key]
          break
        end
      end
    end
  end

  def self.find(doc_id, id)
    self.new(doc_id, id)
  end

end