
feature '.list_all' do
  scenario "It shows a list of saved websites" do

    Bookmark.create(url: "http://www.makersacademy.com", title: "Makers")
    Bookmark.create(url: "http://www.destroyallsoftware.com", title: "Destroy")
    Bookmark.create(url: "https://www.visitfaroeislands.com", title: "Visit Faroe")
    Bookmark.create(url: "https://store.steampowered.com", title: "Steam")

    visit '/bookmarks'

    expect(page).to have_content("Bookmarks:")
    expect(page).to have_link("Makers", href: "http://www.makersacademy.com")
    expect(page).to have_link("Destroy", href: "http://www.destroyallsoftware.com")
    expect(page).to have_link("Visit Faroe", href: "https://www.visitfaroeislands.com")
    expect(page).to have_link("Steam", href: "https://store.steampowered.com")

  end
end

  feature '.create' do
    scenario "Adds websites to the bookmarks database" do

      connection = PG.connect(dbname: 'bookmark_manager_test')

      visit '/'
      click_link 'Bookmark Page'
      fill_in('url', with: 'https://tfl.gov.uk/')
      fill_in('title', with: 'TFL')
      click_button 'Add Bookmark'
      expect(page).to have_link('TFL', href: 'https://tfl.gov.uk/')

    end
  end

  feature '.delete' do
    scenario 'Deletes a bookmark from the bookmarks database' do
      Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
      visit('/bookmarks')
      expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')
      click_button 'Delete'
      expect(current_path).to eq '/bookmarks'
      expect(page).not_to have_link('Makers Academy', href: 'http://www.makersacademy.com')
    end
  end

  feature '.update' do
    scenario 'Updates a bookmark from the bookmarks database' do

      bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')




      visit('/bookmarks')
      # expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')
      click_button 'Update'
      expect(bookmark.title).to eq('Makers Academy')
      expect(bookmark.url).to eq('http://www.makersacademy.com')
      expect(page).to have_content("Add Title:")
      fill_in("title", with: 'Makers')
      click_button 'Update Bookmark'
      expect(page).to have_content("Makers")
    end
  end
