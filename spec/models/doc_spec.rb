require 'rails_helper'

RSpec.describe Doc, type: :model do
  it "converts tags to an array" do
    doc = create(:doc)
    doc.update(tags: 'foo,bar,baz,lala')
    expect(doc.tags).to eq(['foo','bar','baz','lala'])
  end
end
