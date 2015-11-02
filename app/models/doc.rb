class Doc
  TAG_SEPARATOR = ','

  include Mongoid::Document
  include Mongoid::Timestamps  
  include Mongoid::History::Trackable

  before_create :set_creator
  before_save :set_updater

  belongs_to :creator, class_name: 'User', inverse_of: nil

  paginates_per 25

  field :name
  field :content  
  field :tags, type: Array
  # field :updater
  # field :creator

  # telling Mongoid::History how you want to track changes
  # dynamic fields will be tracked automatically (for MongoId 4.0+ you should include Mongoid::Attributes::Dynamic to your model)
  track_history   :modifier_field => :updater, # adds "belongs_to :modifier" to track who made the change, default is :modifier
                  :modifier_field_inverse_of => :nil, # adds an ":inverse_of" option to the "belongs_to :modifier" relation, default is not set
                  :version_field => :version,   # adds "field :version, :type => Integer" to track current version, default is :version
                  :track_create   =>  true,    # track document creation, default is false
                  :track_update   =>  true,     # track document updates, default is true
                  :track_destroy  =>  true     # track document destruction, default is false


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

  private
  
  def set_creator
    self.creator = User.current if User.current
  end

  def set_updater
    self.updater = User.current if User.current
  end
end
