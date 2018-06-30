class DiscogsClient
    def initialize
        authentication_string = "key=" + ENV['MY_KEY'] + ", secret=" + ENV['MY_SECRET']
        
        @json_client = JSONClient.new 'https://api.discogs.com'
        @json_client.authenticate(:Discogs, authentication_string)
    end

    def search(phrase)
        json = @json_client.get 'database/search', {q: phrase}

        results = json["results"]
        release = results.find { |e| e["type"] == "release" && e["format"].include?("CD") && e["format"].include?("Album")}
        release
    end

    def find_album(album_url)
        @json_client.get(album_url)
    end
end