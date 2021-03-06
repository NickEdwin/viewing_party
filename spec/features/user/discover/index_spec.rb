require "rails_helper"

RSpec.describe 'As an authenticated user' do
  before(:each) do
    stub_omniauth
    visit root_path
    expect(page).to have_link("Sign in with Google")
    click_link "Sign in with Google"
  end

  describe "On my dashboard" do
    it "when I click the 'Discover Movies' button I am taken to a discover page" do

      expect(current_path).to eq("/dashboard")

      click_button("Discover Movies")

      expect(current_path).to eq("/discover")
    end
  end

  describe "On the discover page" do
    it "should have a button to discover top movies and a search bar" do
      visit "/discover"
      expect(page).to have_button("Find Top Rated Movies")
      expect(page).to have_field('Search by movie title')
      expect(page).to have_button("Find Movies")
    end

    it "When I click on Find Top Rated Movies I am taken to a page with top rated movies" do
      visit "/discover"
      click_button "Find Top Rated Movies"

      expect(current_path).to eq('/movies/top_rated')
      expect(page).to have_content("Title: Gabriel's Inferno Part II")
      expect(page).to have_content("Average Rating: 9.1")
    end

    it "can search for movie based on keywords" do
      visit "/discover"

      fill_in :find_movies, with: "kung fu"
      click_on "Find Movies"

      expect(current_path).to eq("/movies/search")

      expect(page).to have_content("Title: Kung Fu Panda")
    end

    it "can click on a movie title and go to its show page" do
      visit "/discover"
      click_button "Find Top Rated Movies"

      expect(page).to have_link("Gabriel's Inferno Part II")
      click_on("Gabriel's Inferno Part II")

      expect(current_path).to eq("/movies/724089")
    end

    it "shows a movies information" do
      visit "/discover"
      click_button "Find Top Rated Movies"

      expect(page).to have_link("Gabriel's Inferno Part II")
      click_on("Gabriel's Inferno Part II")

      expect(page).to have_content("Gabriel's Inferno Part II")
      expect(page).to have_content("Average Rating: 9.1")
      expect(page).to have_content("Romance")
      expect(page).to have_content("Melanie Zanetti as Julia Mitchell")
    end

    it "shows a movies reviews" do
      visit "/discover"
      click_button "Find Top Rated Movies"

      click_on("The Shawshank Redemption")

      expect(page).to have_content("very good movie 9.5/1")
    end
  end
end
