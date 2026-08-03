require 'jekyll-linkpreview'
require 'uri'

module Jekyll
  module Linkpreview
    class LinkpreviewTag < Liquid::Tag
      alias_method :original_get_properties, :get_properties

      def get_properties(url)
        begin
          original_get_properties(url)
        rescue => e
          warn "Failed to fetch linkpreview for #{url}: #{e.message}. Using fallback properties."
          fallback_hash = {
            'title' => url,
            'url' => url,
            'description' => "Link preview unavailable. Original URL: #{url}",
            'domain' => (URI.parse(url).host rescue nil) || url
          }
          Properties.new(fallback_hash, 'linkpreview_nog.html')
        end
      end
    end
  end
end
