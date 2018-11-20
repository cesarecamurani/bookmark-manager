
feature '.list_all' do
  scenario "It shows a list of saved websites" do
    visit '/bookmarks'
    expect(page).to have_content("Bookmarks:")
    expect(page).to have_content("http://www.makersacademy.com")
    expect(page).to have_content("http://www.destroyallsoftware.com")
    expect(page).to have_content("https://www.visitfaroeislands.com")
    expect(page).to have_content("https://www.make.fo")
    expect(page).to have_content("https://store.steampowered.com")
  end
end
