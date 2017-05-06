class ApplicationMailer < ActionMailer::Base
  include ApplicationHelper

  default :from =>  "itionrails@gmail.com"
  layout 'mailer'
end
