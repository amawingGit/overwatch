module Support
  module Dig
    # Tries to fetch an element in a nested hash
    # If it doesn't exist, returns "default"
    def dig(*keys, default: nil)
      object = self
      for key in keys
        if object.has_key? key
          object = object[key]
        else
          return default
        end
      end
      object
    end
  end
end

class Hash
  include Support::Dig
end

class HashWithIndifferentAccess
  include Support::Dig
end