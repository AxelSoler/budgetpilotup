class GeminiApiService
  include HTTParty

  def self.generate_content(prompt_text:, file_data_base64:, mime_type:)
    api_key = Rails.application.credentials.GEMINI_API_KEY
    endpoint = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent"

    headers = {
      "Content-Type" => "application/json",
      "X-goog-api-key" => api_key
    }

    body = {
      contents: [
        {
          parts: [
            { text: prompt_text },
            {
              inline_data: {
                mime_type: mime_type,
                data: file_data_base64
              }
            }
          ]
        }
      ]
    }

    response = post(endpoint, body: body.to_json, headers: headers)

    if response.success?
      generated_text = response.dig("candidates", 0, "content", "parts", 0, "text")
      { success: true, text: generated_text }
    else
      { success: false, error: response.parsed_response }
    end
  rescue HTTParty::Error => e
    { success: false, error: "Error de conexión: #{e.message}" }
  rescue StandardError => e
    { success: false, error: "Error inesperado: #{e.message}" }
  end
end
