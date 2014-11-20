module BillingTasks
  class << self
    def escrow_balance
      Balanced::Marketplace.mine.in_escrow
    end

    def transfer_full_escrow_balance
      if escrow_balance > 0
        Balanced::Marketplace.mine.owner_customer.bank_accounts.first.credit(
          :amount => escrow_balance,
          :description => 'Tuition payments withdrawal'
        )
      end
    end

    def billable_today
      Student.recurring_active.select do |student|
        student.payments.last.created_at.to_date < 1.month.ago
      end
    end

    def billable_in_three_days
      Student.recurring_active.select do |student|
        (student.payments.last.created_at - 3.days).to_date == 1.month.ago.to_date
      end
    end

    def email_upcoming_payees
      self.billable_in_three_days.each do |student|
        Mailgun::Client.new(ENV['MAILGUN_API_KEY']).send_message(
          "epicodus.com",
          { :from => "michael@epicodus.com",
            :to => student.email,
            :bcc => "michael@epicodus.com",
            :subject => "Upcoming Epicodus tuition payment",
            :text => "Hi #{student.name}. This is just a reminder that your next Epicodus tuition payment will be withdrawn from your bank account in 3 days. If you need anything, reply to this email. Thanks!" }
        )
      end
    end

    def bill_bank_accounts
      self.billable_today.each do |student|
        student.payments.create(amount: student.plan.recurring_amount, payment_method: student.primary_payment_method)
      end
    end
  end
end
