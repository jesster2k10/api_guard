# frozen_string_literal: true

module ApiGuard
  module JwtAuth
    # Common module for token whitelisting
    module WhitelistToken
      def whitelisted_token_association(resource)
        resource.class.whitelisted_token_association
      end

      def token_whitelisting_enabled?(resource)
        whitelisted_token_association(resource).present?
      end

      def whitelisted_tokens_for(resource)
        whitelisted_token_association = whitelisted_token_association(resource)
        resource.send(whitelisted_token_association)
      end

      # Returns whether the JWT token is whitelisted or not
      def whitelisted?
        return true unless token_whitelisting_enabled?(current_resource)

        whitelisted_tokens_for(current_resource).exists(jti: @jti)
      end

      def whitelist_token
        return unless token_whitelisting_enabled?(current_resource)

        whitelisted_tokens_for(current_resource).create(jti: @jti, expire_at: @decoded_token[:exp].utc)
      end

      def revoke_whitelisted_token(resource = current_resource)
        return unless token_whitelisting_enabled?(resource)

        token = whitelisted_tokens_for(resource).find_by(jti: @jti)
        token.destroy! if token.present?
      end
    end
  end
end
