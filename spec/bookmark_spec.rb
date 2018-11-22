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

      bookmark = Bookmark.create(url: "https://tfl.gov.uk/", title: "Transport for London")
      bookmark_bis = Bookmark.create(url: "https://www.chess.com/it/learn", title: "Chess.com")

      expect(bookmark.url).to eq("https://tfl.gov.uk/")
      expect(bookmark.title).to eq("Transport for London")
      expect(bookmark_bis.url).to eq("https://www.chess.com/it/learn")
      expect(bookmark_bis.title).to eq ("Chess.com")
    end
  end

  # describe '.delete' do
  #   it 'Deletes a bookmark' do
  #
  #     Bookmark.delete(url: "https://tfl.gov.uk/")
  #     Bookmark.delete(url: "https://www.chess.com/it/learn")
  #
  #     expect(Bookmark.list_all).not_to include("https://tfl.gov.uk/")
  #     expect(Bookmark.list_all).not_to include("https://www.chess.com/it/learn")
  #
  #   end
  # end


end
