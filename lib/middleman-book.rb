module Middleman
  class Book < Extension
    def initialize(app, options_hash={}, &block)
      @sitemap = app.sitemap
      super
    end

    def manipulate_resource_list(resources)
      resources.each do |resource|
        resource.add_metadata(book_metadata(resource))
        resource.destination_path.gsub!(/\d+\./, '')
      end
    end

    helpers do
      def table_of_contents
        result = '<ol>'
        chapters = sitemap.resources.map(&:metadata).map do |meta|
          meta[:chapter]
        end.reject(&:nil?).uniq.sort_by do |chapter|
          chapter[:number]
        end
        result += chapters.map do |chapter|
          pages = sitemap.resources.select do |resource|
            resource.metadata[:chapter] == chapter
          end.sort_by { |page| page.metadata[:page][:number] }
          chapter_string = "<li>#{chapter[:name]}"
          chapter_string += "<ul>"
          pages.each do |page|
            chapter_string += "<li><a href=\"/#{page.destination_path}.html\">#{page.metadata[:page][:name]}</a></li>"
          end
          chapter_string + "</ul>"
        end.join + '</li>'
        result += '<ol>'
      end
    end

    private
    def book_metadata(resource)
      if book_page?(resource)
        {
          chapter: { name: extract_chapter_name(resource), number: extract_chapter_number(resource) },
          page: { name: extract_page_name(resource), number: extract_page_number(resource) }
        }
      else
        {}
      end
    end

    def book_page?(resource)
      resource.destination_path.include?('/')
    end

    def extract_chapter_name(resource)
      resource.destination_path.split('/').first.split('.').last.titleize
    end

    def extract_chapter_number(resource)
      resource.destination_path.split('/').first.split('.').first.to_i
    end

    def extract_page_name(resource)
      resource.destination_path.split('/').last.split('.').last.titleize
    end

    def extract_page_number(resource)
      resource.destination_path.split('/').last.split('.').first.to_i
    end
  end
end

::Middleman::Extensions.register(:book, Middleman::Book)
