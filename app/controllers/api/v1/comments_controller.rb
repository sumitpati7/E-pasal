class Api::V1::CommentsController < Api::V1::ApplicationController
    def create
      if Product.exists?(params[:product_id])
        comment = Comment.new(comment_params.merge(product_id: params[:product_id]))
        if comment.save
          render json: {
            comment: CommentSerializer.new(comment), message: "Comment saved successfully!", status: :created
          }
        else
          render json: {
            message: comment.errors.full_message
          }
        end
      else
        render json: {
          message: "Product not found"
        }, status: :not_found
      end
    end

    def destroy
      comment=Comment.find_by(id: params[:id])
      if comment
        comment.destroy
        render json: { message: "Delete success" }, status: :ok

      else
          # render json: { message: comment.errors.full_message }
          render json: { message: "Comment not found" }, status: :not_found
      end
    end
    private
    def comment_params
      params.permit(:content, :user_id)
    end
end
