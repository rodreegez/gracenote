class XmlTemplates

  def self.album_search
    '<QUERIES>
      <LANG>eng</LANG>
      <AUTH>
        <CLIENT>%{client_id}</CLIENT>
        <USER>%{user_id}</USER>
      </AUTH>
      <QUERY CMD="ALBUM_SEARCH">
        <TEXT TYPE="ARTIST">%{artist}</TEXT>
        <TEXT TYPE="ALBUM_TITLE">%{album_title}</TEXT>
        <TEXT TYPE="TRACK_TITLE">%{track_title}</TEXT>
      </QUERY>
    </QUERIES>'
  end

  def self.album_fetch
    '<QUERIES>
      <AUTH>
        <CLIENT>%{client_id}</CLIENT>
        <USER>%{user_id}</USER>
      </AUTH>
      <LANG>eng</LANG>
      <COUNTRY>usa</COUNTRY>
      <QUERY CMD="ALBUM_FETCH">
        <GN_ID>%{gnid}</GN_ID>
        <OPTION>
          <PARAMETER>SELECT_EXTENDED</PARAMETER>
          <VALUE>ARTIST_IMAGE</VALUE>
        </OPTION>
      </QUERY>
    </QUERIES>'
  end
end
