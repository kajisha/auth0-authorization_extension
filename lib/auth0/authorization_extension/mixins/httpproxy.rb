require 'addressable/uri'

module Auth0
  module AuthorizationExtension
    module Mixins
      module HTTPProxy
        attr_accessor :headers, :base_uri, :timeout

        %i[get post put patch delete delete_with_body].each do |method|
          define_method(method) do |path, body = {}, extra_headers = {}|
            safe_path = Addressable::URI.escape(path)
            body = body.is_a?(Hash) && body.delete_if { |_, v| v.nil? } || body
            result = if method == :get
                       add_headers(params: body)

                       call(:get, url(safe_path), timeout, headers.merge(extra_headers))
                     elsif method == :delete
                       call(:delete, url(safe_path), timeout, add_headers({ params: body }))
                     elsif method == :delete_with_body
                       call(:delete, url(safe_path), timeout, headers, body.to_json)
                     else
                       call(method, url(safe_path), timeout, headers, body.to_json)
                     end
            case result.code
            when 200...226 then safe_parse_json(result.body)
            when 400       then raise Auth0::BadRequest.new(result.body, code: result.code, headers: result.headers)
            when 401       then raise Auth0::Unauthorized.new(result.body, code: result.code, headers: result.headers)
            when 403       then raise Auth0::AccessDenied.new(result.body, code: result.code, headers: result.headers)
            when 404       then raise Auth0::NotFound.new(result.body, code: result.code, headers: result.headers)
            when 429       then raise Auth0::RateLimitEncountered.new(result.body, code: result.code, headers: result.headers)
            when 500       then raise Auth0::ServerError.new(result.body, code: result.code, headers: result.headers)
            else                raise Auth0::Unsupported.new(result.body, code: result.code, headers: result.headers)
            end
          end
        end

        def url(path)
          "#{base_uri}#{path}"
        end

        def add_headers(h = {})
          raise ArgumentError, 'Headers must be an object which responds to #to_hash' unless h.respond_to?(:to_hash)

          @headers ||= {}
          @headers.merge!(h.to_hash)
        end

        def safe_parse_json(body)
          JSON.parse(body.to_s)
        rescue JSON::ParserError
          body
        end

        def call(method, url, timeout, headers, body = nil)
          RestClient::Request.execute(
            method: method,
            url: url,
            timeout: timeout,
            headers: headers,
            payload: body
          )
        rescue RestClient::Exception => e
          case e
          when RestClient::RequestTimeout
            raise Auth0::RequestTimeout.new(e.message)
          else
            return e.response
          end
        end
      end
    end
  end
end
