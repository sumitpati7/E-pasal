class Api::V1::CommentsController < Api::V1::ApplicationController
    def create
      begin product=Product.find(params[:product_id])
        # comment=Comment.new(comment_params.merge())
        comment=product.comments.build(comment_params.merge(user_id: params[:user_id]))
        if comment.save
          render json: {
            message: "Comment Created sucessfully",
            data: comment
          }, status: :created
        end
      rescue ActiveRecord::RecordNotFound
         render json: { message: "Product not found" }, status: :not_found
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
