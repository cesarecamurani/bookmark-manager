require 'bookmark'

describe Bookmark do

  it { expect(described_class).to respond_to :list_all }

  describe '.list_all' do
    it 'returns all bookmarks' do
      bookmarks = Bookmark.list_all
      # expect(bookmarks).to include("http://www.makersacademy.com")
      # expect(bookmarks).to include("http://www.destroyallsoftware.com")
      # expect(bookmarks).to include("http://www.google.com")
    end
  end



end
