class Doc
  TAG_SEPARATOR = ','

  include Mongoid::Document
  include Mongoid::Timestamps  
  include Trackable

  paginates_per 25

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

  def tag_list
    tags ? tags.join(TAG_SEPARATOR) : ''
  end

  def self.all_tags
    Doc.distinct(:tags).sort
  end

  def self.search(text)
    Doc.where(
      :id.in => self.text_search(text).execute['results'].map {|r| r['obj']['_id']}
    )
  end
end
