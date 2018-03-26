class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def like_email(user)
    @user = user
    mail(to: @user.email, subject: 'Someone has liked your note!')
  end

  def unlike_email(user)
    @user = user
    mail(to: @user.email, subject: 'Someone has unliked your note!')
  end

end
