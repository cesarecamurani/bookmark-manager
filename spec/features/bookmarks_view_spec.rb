
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

  feature '.add_bookmark' do
    scenario "Adds websites to the bookmarks database" do

      connection = PG.connect(dbname: 'bookmark_manager_test')

      visit '/'
      click_link 'Bookmark Page'
      fill_in('url', with: 'https://tfl.gov.uk/')
      fill_in('title', with: 'Transport for London')
      click_button 'Add Bookmark'
      expect(page).to have_link('Transport for London', href: 'https://tfl.gov.uk/')

    end
  end

  # feature '.delete_bookmark' do
  #   scenario "Deletes websites to the bookmarks database" do
  #
  #     connection = PG.connect(dbname: 'bookmark_manager_test')
  #
  #     visit '/'
  #     click_link 'Bookmark Page'
  #     fill_in('url', with: 'https://tfl.gov.uk/')
  #     click_button 'Add Bookmark'
  #     fill_in('del_url', with: 'https://tfl.gov.uk/')
  #     click_button 'Delete Bookmark'
  #     expect(page).not_to have_content('https://tfl.gov.uk/')
  #   end
  # end
end
