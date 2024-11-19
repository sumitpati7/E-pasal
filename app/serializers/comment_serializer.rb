class CommentSerializer < ActiveModel::Serializer
  attributes :content, :created_at
end
