class HistoryTracker
  include Mongoid::History::Tracker
  before_create :set_creator

  def set_creator
    self.modifier = User.current if User.current
  end

  def unmodified
    my_trackee_class = self.association_chain.first['name'].constantize
    unmodified_values_keys = my_trackee_class.fields.keys - self.modified.keys

    unmodified_values = {}
    unmodified_values_keys.each do |key|
      my_doc_versions = self.class.where(association_chain: self.association_chain)
      prev_versions = my_doc_versions.select {|v| v.version < self.version}.sort_by {|ht| -ht.version}
      prev_versions.each do |prev_version|
        if prev_version['modified'][key]
          unmodified_values[key] =  prev_version['modified'][key]
          break
        end
      end
    end

    unmodified_values
  end  
  
  def to_param
    self.version.to_s
  end

  def method_missing(method_sym, *arguments, &block)
    self.modified[method_sym.to_s] || self.unmodified[method_sym.to_s]
  end
end