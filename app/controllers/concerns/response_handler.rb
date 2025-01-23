# app/controllers/concerns/response_handler.rb
module ResponseHandler
    extend ActiveSupport::Concern
   
    def json_response(object, status = :ok)
      render json: object, status: status
    end
   
    def error_response(message, status = :unprocessable_entity)
      render json: { error: message }, status: status
    end
   
    def pagination_meta(collection)
      {
        current_page: collection.current_page,
        total_pages: collection.total_pages,
        total_count: collection.total_count,
        per_page: collection.limit_value
      }
    end
   end