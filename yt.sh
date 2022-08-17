num_of_arguments=$#
youtube_links=$*

#checking if the user has yt-dlp or youtube-dl installed
binary_name="yt-dlp"
if ! command -v yt-dlp &> /dev/null
then
    echo "yt-dlp is not installed"
    binary_name="youtube-dl"
    if ! command -v youtube-dl &> /dev/null
    then
    	echo "neither is youtube-dl, install one and try again..."
    	exit
    fi    
fi

#checking the correct PATH
path="./storage/music/Misc"
[ ! -d "$path" ] && path="./music"


params="-f bestaudio -x -c --embed-thumbnail --add-metadata --ignore-errors --windows-filenames -o %(title)s.%(ext)s --retries infinite --quiet -P $path $youtube_links"

if [ $num_of_arguments > 0 ]
then
	echo ""
	echo "The links are:"
	for arg in "$@"; do echo "   <$arg>"; done
	echo ""
	echo "Saving songs at $path"
	"$binary_name" $params 
	rm 0
	echo "Done!"
else
	echo "You must put at least 1 youtube-url as a parameter"
fi
exit
