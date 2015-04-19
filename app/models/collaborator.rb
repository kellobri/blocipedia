class Collaborator < ActiveRecord::Base
  belongs_to :wiki, :class_name => Wiki, :foreign_key => "user_id"
  belongs_to :user
end