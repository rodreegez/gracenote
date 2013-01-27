require "gracenote/version"

class Gracenote
  attr_accessor :user_id, :client_id

  def initialize(client_id)
    @client_id = client_id
    xml = %Q|<QUERIES>
         <QUERY CMD="REGISTER">
           <CLIENT>#{ENV['GRACENOTE_CLIENT_WEB']}</CLIENT>
         </QUERY>
       </QUERIES>|

   response = HTTParty.post base_url(client_id), :body => xml, :headers => {'Content-type' => 'text/xml'}
   body = MultiXml.parse response.body

   @user_id = body["RESPONSES"]["RESPONSE"]["USER"]
  end

  def basic_track_search(artist="flying lotus", album_title="until the quiet comes", track_title="all in")
    xml = %Q|<QUERIES>
      <LANG>eng</LANG>
      <AUTH>
        <CLIENT>#{self.client_id}</CLIENT>
        <USER>#{self.user_id}</USER>
      </AUTH>
      <QUERY CMD="ALBUM_SEARCH">
        <TEXT TYPE="ARTIST">#{artist}</TEXT>
        <TEXT TYPE="ALBUM_TITLE">#{album_title}</TEXT>
        <TEXT TYPE="TRACK_TITLE">#{track_title}</TEXT>
      </QUERY>
    </QUERIES>|
    response = HTTParty.post base_url(client_id), :body => xml, :headers => {'Content-type' => 'text/xml'}
    response.parsed_response
  end

  private

  def base_url(client_id)
    "https://c#{client_id.split('-').first}.web.cddbp.net/webapi/xml/1.0/"
  end
end
