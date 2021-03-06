feature 'Creating a bank account' do
  scenario 'as a guest' do
    visit new_bank_account_path
    expect(page).to have_content 'need to sign in'
  end

  context 'as a student' do
    before do
      student = FactoryGirl.create(:student)
      login_as(student, scope: :student)
      visit new_bank_account_path
      fill_in 'Name on account', with: student.name
    end

    scenario 'with valid information', :vcr, js: true do
      fill_in 'Bank account number', with: '123456789'
      fill_in 'Routing number', with: '321174851'
      click_on 'Verify bank account'
      expect(page).to have_content '2-3 business days'
    end

    scenario 'with missing account number', js: true do
      fill_in 'Routing number', with: '321174851'
      click_on 'Verify bank account'
      within '.alert-error' do
        expect(page).to have_content 'Missing field "account_number"'
      end
    end

    scenario 'with invalid routing number', js: true do
      fill_in 'Bank account number', with: '123456789'
      fill_in 'Routing number', with: '1234568'
      click_on 'Verify bank account'
      within '.alert-error' do
        expect(page).to have_content 'not a valid routing number'
      end
    end
  end
end
