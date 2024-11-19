class Api::V1::CommentsController < Api::V1::ApplicationController
    def create
      begin user=User.find(params[:user_id])
        # comment=Comment.new(comment_params.merge())
        comment=user.comments.build(comment_params.merge(product_id: params[:product_id]))
        if comment.save
          render json: {}, status: :ok
        end
      rescue ActiveRecord::RecordNotFound
         render json: { message: "User not found" }, status: :not_found
      end
    end

    def destroy
      comment=Comment.find_by(id: params[:id])
      if comment.destroy
        render json: { message: "Delete success" }, status: :no_head
      else
          # render json: { message: comment.errors.full_message }
          render json: { message: "Comment not found" }
      end
    end
    private
    def comment_params
      params.require(:comment).permit(:content)
    end

  # def create
  #   Comment.new(comment_params)
  # end
  # private
  # def comment_params
  #   params.require(:comment).permit(:content, :user_id, :product_id)
  # end
end
