require 'bookmark'

describe Bookmark do

  it { expect(described_class).to respond_to :list_all }

  describe '.list_all' do
    it 'returns all bookmarks' do

      connection = PG.connect(dbname: 'bookmark_manager_test')

      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers")
      Bookmark.create(url: "http://www.destroyallsoftware.com", title: "Destroy")
      Bookmark.create(url: "https://www.visitfaroeislands.com", title: "Visit Faroe")
      Bookmark.create(url: "https://store.steampowered.com", title: "Steam")


      bookmarks = Bookmark.list_all

      expect(bookmarks.length).to eq 4
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq "Makers"
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
    end
  end

  describe '.create' do
    it 'Adds a bookmark' do

      bookmark = Bookmark.create(url: "https://tfl.gov.uk/", title: "TFL")
      bookmark_bis = Bookmark.create(url: "https://www.chess.com/it/learn", title: "Chess.com")

      expect(bookmark.url).to eq("https://tfl.gov.uk/")
      expect(bookmark.title).to eq("TFL")
      expect(bookmark_bis.url).to eq("https://www.chess.com/it/learn")
      expect(bookmark_bis.title).to eq ("Chess.com")
    end
  end

  describe '.delete' do
    it 'Deletes a bookmark' do
      bookmark = Bookmark.create(title: 'Makers', url: 'http://www.makersacademy.com')
      Bookmark.delete(id: bookmark.id)
      expect(Bookmark.list_all.length).to eq 0
    end
  end

  describe '.update' do
    it 'Updates a bookmark' do
      bookmark = Bookmark.create(title: 'Makers', url: 'http://www.makersacademy.com')
      Bookmark.update(id: bookmark.id, title: 'Makers Academy', url: 'http://www.makersacademy.com')
      expect(Bookmark.list_all.first.title).to eq 'Makers Academy'
    end
  end

end
