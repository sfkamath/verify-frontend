require 'feature_helper'
require 'api_test_helper'

RSpec.describe 'When the user visits the unlikely-to-verify page' do
  before(:each) do
    set_session_and_session_cookies!
    page.set_rack_session(transaction_simple_id: 'test-rp')
  end

  it 'displays the page in Welsh' do
    visit '/anhebygol-i-ddilysu'
    expect(page).to have_content('Rydych angen pasport, trwydded yrru llun neu gerdyn adnabod cenedlaethol (cerdyn ID) dilys i gael eich hunaniaeth wedi’i ddilysu.')
    expect(page).to have_css 'html[lang=cy]'
  end

  it 'displays the page in English' do
    visit '/unlikely-to-verify'
    expect(page).to have_content('You need a valid passport, photocard driving licence or national identity card (ID card) to get your identity verified.')
    expect(page).to have_css 'html[lang=en]'
  end

  it 'includes other ways text' do
    visit '/unlikely-to-verify'

    expect(page).to have_content('If you can’t verify your identity using GOV.UK Verify, you can register for an identity profile here')
    expect(page).to have_content('register for an identity profile')
    expect(page).to have_link 'here', href: 'http://www.example.com'
  end

  it 'includes the appropriate feedback source' do
    visit '/unlikely-to-verify'

    expect_feedback_source_to_be(page, 'UNLIKELY_TO_VERIFY_PAGE')
  end
end
