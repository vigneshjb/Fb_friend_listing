require 'rubygems'
require 'json'
require "open-uri"

output = File.open( "myfriends.html","w" )

access_token = "" #Enter Access Token Here

data=URI.parse("https://graph.facebook.com/me?fields=friends.fields(picture,name,username,link)&access_token="+access_token).read
data=JSON.parse(data)
i=1
output << "<html><head><script src=\'http://code.jquery.com/jquery-1.9.0.js\'></script></head>\n"
output<<"<style>body {background: #696969;} .cent-allign{margin: 0 0 0 550px;} .fbuser img {margin: 1px 1px 1px 1px; border-radius: 16px}</style>"
output<<"<body>\n<div id='container' align='center'>"
# output<< "<form action=\'#\' method=\'get\'>"
# output<< "<input type= \'text\' class=\'cent-allign\' name=\'search\'><button onclick=\'trig()\'></button></form>"
data["friends"]["data"].each do |friend|
	# output << "<tr><td>#{i}</td><td>#{friend['name']}</td><td><img src=\'#{friend['picture']['data']['url']}\'></td><td><a href= \'#{friend['link']}\' target='_blank'>Profile</a></td></tr>"
	output << "<a href= \'#{friend['link']}\' class=\'fbuser\' target='_blank'><img src=\'#{friend['picture']['data']['url']}\' data-name=\'#{friend['name']}\' ></a>\n"
	# i= i+1
end
output<<"</div>"

output << "<script type=\'text/javascript\'>
function getUrlVars()
{
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf(\'?'\) + 1).split(\'&\');
    for(var i = 0; i < hashes.length; i++)
    {
        hash = hashes[i].split(\'=\');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
    return vars;
}
</script>\n"

output << "<script type=\'text/javascript\'>\n"
output << "var a=getUrlVars(); $(document).ready{ function(){$(\'img\').each(function() {if (a[/'search/']==$(this).attr(\'data-name\')) alert(/'wow/')})}}\n"
output << "</script>\n"

# output << "</table>"
#output << "<a href = \'#{data['friends']['paging']['next']}\'> NEXT </a>"
output << "</body></html>"
output.close