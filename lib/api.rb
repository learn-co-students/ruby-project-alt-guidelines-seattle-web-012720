class Api 
    URL = "http://artii.herokuapp.com/make?text=Sliceline&font=banner"

    ### copied from Learnco lab
    def get_programs
        uri = URI.parse(URL)
        response = Net::HTTP.get_response(uri)
        response.body
      end
end