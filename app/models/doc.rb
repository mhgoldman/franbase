class Doc
  TAG_SEPARATOR = ','

  include Mongoid::Document
  field :name
  field :content  
  field :tags, type: Array

  validates :name, presence: true
  
  def tags=(rhs)
    super(rhs.kind_of?(Array) ? rhs : rhs.split(TAG_SEPARATOR))
  end
end
