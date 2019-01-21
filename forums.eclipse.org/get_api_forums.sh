
echo "Get info for all categories:";
curl -s https://api.eclipse.org/forums/category -o mls_cats.json
# Returns
# {
#    "result": [
#       {"id":"10","name":"ice","description":"","html_url":"https://www.eclipse.org/forums/index.php/i/10/","forums_url":"https://api.eclipse.org/forums/forum?category_id=10"},
#       {"id":"8","name":"Archived","description":" - Forums for projects that have been officially archived.","html_url":"https://www.eclipse.org/forums/index.php/i/8/","forums_url":"https://api.eclipse.org/forums/forum?category_id=8"},
#       {"id":"7","name":"Proposals","description":" - Forums for Project proposals","html_url":"https://www.eclipse.org/forums/index.php/i/7/","forums_url":"https://api.eclipse.org/forums/forum?category_id=7"},
#       {"id":"6","name":"Language IDEs","description":" - IDEs and tools for specific programming languages - click +/- to expand/collapse","html_url":"https://www.eclipse.org/forums/index.php/i/6/","forums_url":"https://api.eclipse.org/forums/forum?category_id=6"},
#       {"id":"5","name":"Modeling","description":" - Modeling tools and technologies - click +/- to expand/collapse","html_url":"https://www.eclipse.org/forums/index.php/i/5/","forums_url":"https://api.eclipse.org/forums/forum?category_id=5"},
#       {"id":"4","name":"Eclipse Working Groups","description":" - Click +/- to expand/collapse","html_url":"https://www.eclipse.org/forums/index.php/i/4/","forums_url":"https://api.eclipse.org/forums/forum?category_id=4"},
#       {"id":"3","name":"General (non-technical)","description":" - Click +/- to expand/collapse","html_url":"https://www.eclipse.org/forums/index.php/i/3/","forums_url":"https://api.eclipse.org/forums/forum?category_id=3"},
#       {"id":"2","name":"Newcomers","description":" - General Newcomer discussions","html_url":"https://www.eclipse.org/forums/index.php/i/2/","forums_url":"https://api.eclipse.org/forums/forum?category_id=2"},
#       {"id":"1","name":"Eclipse Projects","description":" - Eclipse Project Forums - click +/- to expand/collapse","html_url":"https://www.eclipse.org/forums/index.php/i/1/","forums_url":"https://api.eclipse.org/forums/forum?category_id=1"}
#    ],
#    "pagination":{"page":1,"pagesize":20,"result_start":1,"result_end":9,"result_size":9,"total_result_size":9}
# }

echo "#########################################################################"
echo "Get info for category Eclipse Projects (1):";
curl -s https://api.eclipse.org/forums/category/1 -o mls_cat_1.json
# Returns
#{"id":"1","name":"Eclipse Projects","description":" - Eclipse Project Forums - click +/- to expand/collapse","html_url":"https://www.eclipse.org/forums/index.php/i/1/","forums_url":"https://api.eclipse.org/forums/forum?category_id=1"}


echo "#########################################################################"
echo "Get info for forums in category Eclipse Projects (1):";
curl -s 'https://api.eclipse.org/forums/forum?category_id=1&page=10' -o mls_forums_10.json
# Returns
#{
# "pagination" : {
#    "result_end" : 20,
#    "result_size" : 20,
#    "result_start" : 1,
#    "pagesize" : 20,
#    "page" : 1,
#    "total_result_size" : 226
# },
# "result" : [
#    {
#       "post_count" : "0",
#       "category_url" : "https://api.eclipse.org/forums/category/1",
#       "last_post_id" : "0",
#       "id" : "415",
#       "description" : "soteria community discussions",
#       "topic_count" : "0",
#       "name" : "Soteria",
#       "html_url" : "https://www.eclipse.org/forums/index.php/f/415/",
#       "topics_url" : "https://api.eclipse.org/forums/topic?forum_id=415",
#       "category_id" : "1",
#       "created_date" : "1520885401"
#    },


echo "#########################################################################"
echo "Get info for a single forum (114, webtools):";
curl -s 'https://api.eclipse.org/forums/forum/114' -o mls_forum_114.json
# Returns
# {
#    "id":"114",
#    "category_id":"1",
#    "description":"Incubating Webtools such as VEX, XML Security, X Query &#160; <a class='smallLink' href='http://www.eclipse.org/webtools/incubator/'>[project home]</a>",
#    "name":"Webtools incubator","created_date":"1248985681",
#    "topic_count":"75",
#    "post_count":"230",
#    "last_post_id":"1742391",
#    "html_url":"https://www.eclipse.org/forums/index.php/f/114/",
#    "topics_url":"https://api.eclipse.org/forums/topic?forum_id=114",
#    "category_url":"https://api.eclipse.org/forums/category/1"
# }

echo "#########################################################################"
echo "Get topics for a single forum (114, webtools):";
curl -s 'https://api.eclipse.org/forums/topic?forum_id=114' -o mls_topics_114.json
# Returns
#{
#   "result" : [
#      {
#         "forum_id" : "114",
#         "root_post_id" : "1742391",
#         "subject" : "news.eclipse.org is shutting down.",
#         "last_post_id" : "1742391",
#         "replies" : "0",
#         "views" : "30416",
#         "html_url" : "https://www.eclipse.org/forums/index.php/t/1080826/",
#         "posts_url" : "https://api.eclipse.org/forums/post?topic_id=1080826",
#         "id" : "1080826",
#         "forum_url" : "https://api.eclipse.org/forums/forum/114",
#         "last_post_date" : "1472669058"
#      },


echo "#########################################################################"
echo "Get single topic for a single forum (114, webtools):";
curl -s 'https://api.eclipse.org/forums/topic/1080826' -o mls_topic_1080826.json


echo "#########################################################################"
echo "Get posts for a single topic (1080826):";
curl -s 'https://api.eclipse.org/forums/post?topic_id=1080826' -o mls_posts_1080826.json


echo "#########################################################################"
echo "Get posts for a single forum (114, webtools):";
curl -s 'https://api.eclipse.org/forums/post?forum_id=114' -o mls_posts_114.json


echo "#########################################################################"
echo "Get single post for a single forum (114, webtools):";
curl -s 'https://api.eclipse.org/forums/post/1742391' -o mls_post_1742391.json


