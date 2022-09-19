# spec/mailers/previews/user_mailer_preview.rb
# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def reset_password_instructions
    UserMailer.reset_password_instructions(User.first)
  end
end
