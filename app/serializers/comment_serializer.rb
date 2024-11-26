# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text
#  user_id    :bigint           not null
#  product_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CommentSerializer < ActiveModel::Serializer
  attributes :content, :created_at, :id, :user

  def user
    return nil unless object.user
        {
        id: object.user.id,
        email: object.user.email,
        first_name: object.user.first_name,
        last_name: object.user.last_name
        }
  end
end
