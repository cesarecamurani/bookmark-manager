require 'bookmark'

describe Bookmark do

  it { expect(described_class).to respond_to :list_all }

  describe '.list_all' do
    it 'returns all bookmarks' do
      bookmarks = Bookmark.list_all
      expect(bookmarks).to include("https://www.google.co.uk/")
      expect(bookmarks).to include("https://it.wikipedia.org/")
      expect(bookmarks).to include("https://www.cb01.news/")
    end
  end



end
