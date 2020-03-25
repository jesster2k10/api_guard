# frozen_string_literal: true

module ApiGuard
  module JwtAuth
    # A common module to handle logout functions
    module Logout
      def logout!(resource = nil)
        blacklist_token(resource)
        revoke_whitelisted_token(resource)
      end
    end
  end
end
