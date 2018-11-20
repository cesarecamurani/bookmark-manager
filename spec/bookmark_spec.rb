require 'bookmark'

describe Bookmark do

  it { expect(described_class).to respond_to :list_all }

  describe '.list_all' do
    it 'returns all bookmarks' do

      connection = PG.connect(dbname: 'bookmark_manager_test')

      connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.makersacademy.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.destroyallsoftware.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('https://www.visitfaroeislands.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('https://www.make.fo');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('https://store.steampowered.com');")


      bookmarks = Bookmark.list_all

      expect(bookmarks).to include("http://www.makersacademy.com")
      expect(bookmarks).to include("http://www.destroyallsoftware.com")
      expect(bookmarks).to include("https://www.visitfaroeislands.com")
      expect(bookmarks).to include("https://www.make.fo")
      expect(bookmarks).to include("https://store.steampowered.com")
    end
  end

end
