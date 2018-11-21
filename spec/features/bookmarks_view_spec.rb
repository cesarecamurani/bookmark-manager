
feature '.list_all' do
  scenario "It shows a list of saved websites" do

    connection = PG.connect(dbname: 'bookmark_manager_test')

    connection.exec("INSERT INTO bookmarks VALUES(1, 'http://www.makersacademy.com');")
    connection.exec("INSERT INTO bookmarks VALUES(2, 'http://www.destroyallsoftware.com');")
    connection.exec("INSERT INTO bookmarks VALUES(3, 'https://www.visitfaroeislands.com');")
    connection.exec("INSERT INTO bookmarks VALUES(4, 'https://www.make.fo');")
    connection.exec("INSERT INTO bookmarks VALUES(5, 'https://store.steampowered.com');")

    visit '/bookmarks'

    expect(page).to have_content("Bookmarks:")
    expect(page).to have_content("http://www.makersacademy.com")
    expect(page).to have_content("http://www.destroyallsoftware.com")
    expect(page).to have_content("https://www.visitfaroeislands.com")
    expect(page).to have_content("https://www.make.fo")
    expect(page).to have_content("https://store.steampowered.com")
  end

  feature '.add_bookmark' do
    scenario "Adds websites to the bookmarks database" do

      connection = PG.connect(dbname: 'bookmark_manager_test')

      visit '/'
      click_link 'Bookmark Page'
      fill_in('url', with: 'https://tfl.gov.uk/')
      click_button 'Add Bookmark'
      expect(page).to have_content('https://tfl.gov.uk/')
    end
  end

  # feature '.delete_bookmark' do
  #   scenario "Deletes websites to the bookmarks database" do
  #
  #     connection = PG.connect(dbname: 'bookmark_manager_test')
  #
  #     visit '/'
  #     click_link 'Bookmark Page'
  #     fill_in('add', with: 'https://tfl.gov.uk/')
  #     click_button 'Add Bookmark'
  #     fill_in('delete', with: 'https://tfl.gov.uk/')
  #     click_button 'Delete Bookmark'
  #     expect(page).not_to have_content('https://tfl.gov.uk/')
  #   end
  # end
end
