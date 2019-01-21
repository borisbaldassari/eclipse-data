
## Eclipse API -- forums

This directory holds information about forums, as retrieved from the [Eclipse API](https://api.eclipse.org).

The `get_api_forums.sh` scripts provides examples to retrieve information about the Eclipse forums using curl. The following features are explored:

* Get info for all categories
`curl -s https://api.eclipse.org/forums/category`
* Get info about a single category of Eclipse Projects (category #1)
`curl -s https://api.eclipse.org/forums/category/1`
* Get info about all forums in a specific category of Eclipse Projects (category #1, page #10)
`curl -s 'https://api.eclipse.org/forums/forum?category_id=1&page=10' `
* Get info for a single forum (114, webtools)
`curl -s 'https://api.eclipse.org/forums/forum/114'`
* Get all topics for a single forum (114, webtools)
`curl -s 'https://api.eclipse.org/forums/topic?forum_id=114'`
* Get a single topic (1080826 from project webtools)
`curl -s 'https://api.eclipse.org/forums/topic/1080826'`
* Get all posts for a single topic (1080826)
`curl -s 'https://api.eclipse.org/forums/post?topic_id=1080826'`
* Get all posts for a single forum (114, webtools)
`curl -s 'https://api.eclipse.org/forums/post?forum_id=114'`
* Get a single post (114, webtools)
`curl -s 'https://api.eclipse.org/forums/post/1742391'`

## Example run

```
boris@kadath:forums.eclipse.org$ sh get_api_forums.sh
Get info for all categories:
#########################################################################
Get info for category Eclipse Projects (1):
#########################################################################
Get info for forums in category Eclipse Projects (1):
#########################################################################
Get info for a single forum (114, webtools):
#########################################################################
Get topics for a single forum (114, webtools):
#########################################################################
Get single topic for a single forum (114, webtools):
#########################################################################
Get posts for a single topic (1080826):
#########################################################################
Get posts for a single forum (114, webtools):
#########################################################################
Get single post for a single forum (114, webtools):
```
