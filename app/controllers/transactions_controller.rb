class TransactionsController < ApplicationController
  def index
    @pagy, @transactions = pagy(Current.user.transactions, limit: 10)
  end

  def show
    @transaction = Current.user.transactions.find(params[:id])
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user = Current.user

    if @transaction.save
      redirect_to transactions_path, notice: "Transaction created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def categorize_with_ai
    uploaded_file = params[:file]

    if uploaded_file.present?
      if uploaded_file.size > 10.megabytes
        @ai_suggestion = { error: "File is too large (limit 10MB)." }
      else
        category_names = Current.user.categories.pluck(:name).join(", ")
        prompt = <<~PROMPT
          Analyze the following image or PDF of a receipt or invoice.
          Extract the following information:
          1. A short title for the transaction (e.g., 'Supermarket A', 'Coffee Shop B').
          2. The total amount of the transaction as a number (e.g., 123.45).
          3. A short description (e.g., 'Weekly groceries', 'Coffee and cake').
          4. A category from the following list: #{category_names}.

          Respond only with a valid JSON object with the keys "title", "amount", "description", and "category".
          Example response: {"title": "Supermarket A", "amount": 45.50, "description": "Groceries purchase", "category": "Food"}
        PROMPT

        file_data_base64 = Base64.strict_encode64(uploaded_file.read)
        mime_type = uploaded_file.content_type

        response = GeminiApiService.generate_content(
          prompt_text: prompt,
          file_data_base64: file_data_base64,
          mime_type: mime_type
        )

        if response[:success]
          begin
            clean_json_string = response[:text].gsub(/`{3}(json)?/, "").strip
            parsed_data = JSON.parse(clean_json_string)
            @ai_suggestion = { success: true, data: parsed_data }
          rescue JSON::ParserError
            @ai_suggestion = {
              success: false,
              error: "There was an error parsing the JSON response from the AI. Please try again later.",
              raw_text: response[:text]
            }
          end
        else
          @ai_suggestion = response
        end
      end
    else
      @ai_suggestion = { error: "Please upload a file." }
    end

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:title, :amount, :description, :category_id, :date, :kind)
  end
end
