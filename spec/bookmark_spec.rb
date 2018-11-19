require 'bookmark'

describe Bookmark do

  describe '.list_list' do
    it "Shows a list of bookmarks" do
      expect(described_class.list_all).to eq Bookmark::BOOKMARKS
    end
  end

end
