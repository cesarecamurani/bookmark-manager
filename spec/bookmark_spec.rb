require 'tag'
require 'bookmark'
require 'bookmark_tag'

describe Bookmark do
  let(:comment_class) { double(:comment_class) }
  let(:tag_class) { double(:tag_class) }

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

    it 'Does not add a new bookmark if the URL is not valid' do
      bookmark = Bookmark.create(url: 'not a real bookmark', title: 'not a real bookmark')
      expect(bookmark).not_to be_a Bookmark
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

  describe '#comments' do
    it 'calls .where on the Comment class' do
      bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
      expect(comment_class).to receive(:where).with(bookmark_id: bookmark.id)
      bookmark.comments(comment_class)
    end
  end

  describe '#tags' do
    it 'calls .where on the Tag class' do
      bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
      expect(tag_class).to receive(:where).with(bookmark_id: bookmark.id)
      bookmark.tags(tag_class)
    end
  end

  describe '.where' do
    it 'returns bookmarks with the given tag id' do
      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy")
      tag1 = Tag.create(content: 'test tag 1')
      tag2 = Tag.create(content: 'test tag 2')
      BookmarkTag.create(bookmark_id: bookmark.id, tag_id: tag1.id)
      BookmarkTag.create(bookmark_id: bookmark.id, tag_id: tag2.id)
      bookmarks = Bookmark.where(tag_id: tag1.id)
      result = bookmarks.first
      expect(bookmarks.length).to eq 1
      expect(result).to be_a Bookmark
      expect(result.id).to eq bookmark.id
      expect(result.title).to eq bookmark.title
      expect(result.url).to eq bookmark.url
    end
  end

end
