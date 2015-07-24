class Doc
  TAG_SEPARATOR = ','

  include Mongoid::Document
  field :name
  field :content  
  field :tags, type: Array

  validates :name, presence: true

  index({
    "name" => 'text',
    "content" => 'text'
    },
    {
      weights: {
        'name' => 10,
        'content' => 5
      }
    }
  )
  
  def tags=(rhs)
    super(rhs.kind_of?(Array) ? rhs : rhs.split(TAG_SEPARATOR))
  end

  def self.all_tags
    Doc.distinct(:tags)
  end

  def self.search(text)
    self.text_search(text).execute['results'].map {|r| Doc.find(r['obj']['_id'])}
  end
end
