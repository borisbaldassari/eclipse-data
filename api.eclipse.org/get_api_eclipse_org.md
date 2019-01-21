
## The Eclipse API

The Eclipse API provides information about users, downloads, marketplace favourites, forums and mailing lists. It is developed and maintained by the Eclipse team. The official documentation sits at [api.eclipse.org/](https://api.eclipse.org/).

Many of its acces points are protected by OAuth2 authorisation and require an Eclipse account.

The `get_api_eclipse_org.sh` script executes curl requests on the following access points:

* Get info for a single user (bbaldassari2kd)
`curl -s https://api.eclipse.org/account/profile/bbaldassari2kd`
* Get all projects for a single user (baldassari2kd, mbarbero)
`curl -s https://api.eclipse.org/account/profile/bbaldassari2kd/projects`
* Get all gerrits for a single user (mbarbero)
`curl -s https://api.eclipse.org/account/profile/mbarbero/gerrit`
* Get all forums posts for a single user (bbaldassari2kd)
`curl -s https://api.eclipse.org/account/profile/bbaldassari2kd/forum`
* Get information for a specific mailing list (scava-dev):\n";
`curl -s https://api.eclipse.org/mailing_lists/metadata?name=scava-dev`

An example run can be found in `test.out` and is reproduced thereafter:

```
boris@kadath:api.eclipse.org$ sh get_api_eclipse_org.sh

Get info for user bbaldassari2kd:

{"uid":"60694","name":"bbaldassari2kd","mail":null,"eca":{"signed":true},"is_committer":true,"friends":{"friend_id":null},"first_name":"Boris","last_name":"Baldassari","twitter_handle":"BorisBaldassari","github_handle":"borisbaldassari","org":"Castalia Solutions","job_title":"Consultant","website":"http://castalia-solutions.com","country":{"code":null,"name":null},"bio":null,"interests":["Ethics","Software Quality","Barges","Data Visualisations"],"working_groups_interests":["Long-Term Support (LTS)","PolarSys","Science"],"forums_url":"https://api.eclipse.org/account/profile/bbaldassari2kd/forum","projects_url":"https://api.eclipse.org/account/profile/bbaldassari2kd/projects","gerrit_url":"https://api.eclipse.org/account/profile/bbaldassari2kd/gerrit","gerrit_owner_url":"https://git.eclipse.org/r/changes/?q=owner:boris%40chrysalice.org","gerrit_reviewer_url":"https://git.eclipse.org/r/changes/?q=reviewer:boris%40chrysalice.org","mailinglist_url":"https://api.eclipse.org/account/profile/bbaldassari2kd/mailing-list","mpc_favorites_url":"https://api.eclipse.org/marketplace/favorites/?name=bbaldassari2kd","bugzilla_url":"https://bugs.eclipse.org/bugs/rest/bug?email1=boris%40chrysalice.org&emailassigned_to1=1&emailcc1=1&emaillongdesc1=1&emailqa_contact1=1&emailreporter1=1&emailtype1=equals"}

Get projects for user baldassari2kd:

{"technology.scava":[{"ActiveDate":"2018-05-22","InactiveDate":null,"EditBugs":"0","ProjectName":"Eclipse SCAVA","url":"https://projects.eclipse.org/projects/technology.scava","Relation":{"Relation":"CM","Description":"Committer","IsActive":"1","Type":{"Type":"PR","Description":"Person - Project"}}}]}

Get projects for user mbarbero:

{"polarsys.polarsys.3p":[{"ActiveDate":"2018-05-28","InactiveDate":null,"EditBugs":"0","ProjectName":"3P (PolarSys Packaging)","url":"https://www.polarsys.org/projects/polarsys.3p","Relation":{"Relation":"CM","Description":"Committer","IsActive":"1","Type":{"Type":"PR","Description":"Person - Project"}}}],"technology.cbi":[{"ActiveDate":"2015-12-18","InactiveDate":null,"EditBugs":"0","ProjectName":"Common Build Infrastructure","url":"https://projects.eclipse.org/projects/technology.cbi","Relation":{"Relation":"PL","Description":"Project Lead","IsActive":"1","Type":{"Type":"PR","Description":"Person - Project"}}},{"ActiveDate":"2015-05-20","InactiveDate":null,"EditBugs":"0","ProjectName":"Common Build Infrastructure","url":"https://projects.eclipse.org/projects/technology.cbi","Relation":{"Relation":"CM","Description":"Committer","IsActive":"1","Type":{"Type":"PR","Description":"Person - Project"}}}],"technology.dash":[{"ActiveDate":"2015-02-05","InactiveDate":null,"EditBugs":"0","ProjectName":"Dash, Tools for Committers","url":"https://projects.eclipse.org/projects/technology.dash","Relation":{"Relation":"CM","Description":"Committer","IsActive":"1","Type":{"Type":"PR","Description":"Person - Project"}}}],"tools.orbit":[{"ActiveDate":"2013-02-15","InactiveDate":null,"EditBugs":"0","ProjectName":"Eclipse Orbit","url":"https://projects.eclipse.org/projects/tools.orbit","Relation":{"Relation":"CM","Description":"Committer","IsActive":"1","Type":{"Type":"PR","Description":"Person - Project"}}}],"eclipse.platform":[{"ActiveDate":"2017-04-07","InactiveDate":null,"EditBugs":"0","ProjectName":"Eclipse Platform","url":"https://projects.eclipse.org/projects/eclipse.platform","Relation":{"Relation":"CM","Description":"Committer","IsActive":"1","Type":{"Type":"PR","Description":"Person - Project"}}}],"technology.tea":[{"ActiveDate":"2017-04-18","InactiveDate":null,"EditBugs":"0","ProjectName":"Eclipse TEA","url":"https://projects.eclipse.org/projects/technology.tea","Relation":{"Relation":"ME","Description":"Mentor for Projects","IsActive":"1","Type":{"Type":"PR","Description":"Person - Project"}}}],"modeling.umlgen":[{"ActiveDate":"2014-03-04","InactiveDate":null,"EditBugs":"0","ProjectName":"Eclipse UML Generators","url":"https://projects.eclipse.org/projects/modeling.umlgen","Relation":{"Relation":"CM","Description":"Committer","IsActive":"1","Type":{"Type":"PR","Description":"Person - Project"}}}],"ee4j.yasson":[{"ActiveDate":"2016-11-02","InactiveDate":null,"EditBugs":"0","ProjectName":"Eclipse Yasson","url":"https://projects.eclipse.org/projects/ee4j.yasson","Relation":{"Relation":"ME","Description":"Mentor for Projects","IsActive":"1","Type":{"Type":"PR","Description":"Person - Project"}}}],"modeling.emfcompare":[{"ActiveDate":"2011-10-06","InactiveDate":null,"EditBugs":"1","ProjectName":"EMF Compare","url":"https://projects.eclipse.org/projects/modeling.emfcompare","Relation":{"Relation":"CM","Description":"Committer","IsActive":"1","Type":{"Type":"PR","Description":"Person - Project"}}}],"tools.lsphub":[{"ActiveDate":"2018-02-22","InactiveDate":null,"EditBugs":"0","ProjectName":"LSPHub","url":"https://projects.eclipse.org/projects/tools.lsphub","Relation":{"Relation":"PL","Description":"Project Lead","IsActive":"1","Type":{"Type":"PR","Description":"Person - Project"}}},{"ActiveDate":"2018-02-23","InactiveDate":null,"EditBugs":"0","ProjectName":"LSPHub","url":"https://projects.eclipse.org/projects/tools.lsphub","Relation":{"Relation":"CM","Description":"Committer","IsActive":"1","Type":{"Type":"PR","Description":"Person - Project"}}}],"foundation-internal.simrel":[{"ActiveDate":"2015-03-03","InactiveDate":null,"EditBugs":"0","ProjectName":"simrel","url":"","Relation":{"Relation":"PL","Description":"Project Lead","IsActive":"1","Type":{"Type":"PR","Description":"Person - Project"}}}]}

Get gerrits for user mbarbero:

{"merged_changes_count":"565","gerrit_owner_url":"https://git.eclipse.org/r/changes/?q=owner:mikael.barbero%40eclipse-foundation.org","gerrit_reviewer_url":"https://git.eclipse.org/r/changes/?q=reviewer:mikael.barbero%40eclipse-foundation.org","account_url":"https://api.eclipse.org/account/profile/mbarbero"}

Get forums posts for user bbaldassari2kd:

{"id":null,"alias":null,"posted_msg_count":"0","join_date":null,"last_visit":null,"level_name":null,"posts":[],"html_url":null,"account_url":"https://api.eclipse.org/account/profile/bbaldassari2kd","posts_url":null}

Get forums posts for user mbarbero:

{"id":"204291","alias":"Mika\u00ebl Barbero","email":null,"posted_msg_count":"2","join_date":"1423976351","last_visit":"1487069464","level_name":"Junior Member","posts":[{"msg_id":"1712648","msg_thread_id":"1071519","msg_poster_id":"204291","msg_reply_to":"1712636","msg_post_stamp":"1445932260","msg_update_stamp":"0","msg_updated_by":"0","msg_subject":"Re: [XCore] how to create an EMF object instance in an operation?","thread_id":"1071519","thread_forum_id":"108","thread_root_msg_id":"1712476","thread_last_post_date":"1445953928","thread_replies":"7","thread_views":"1513","thread_rating":"0","thread_n_rating":"0","thread_last_post_id":"1712694","thread_orderexpiry":"0","thread_thread_opt":"0","thread_tdescr":"","forum_name":"EMF","forum_cat_id":"5","forum_description":"Eclipse Modeling Framework (Core) &#160; <a class='smallLink' href='/modeling/emf/?project=emf'>[project home]</a>","forum_date_created":"1248897121","forum_thread_count":"16249","forum_post_count":"78154","forum_last_post_id":"1801440","cat_name":"Modeling","cat_description":" - Modeling tools and technologies - click +/- to expand/collapse","read_last_view":null,"last_msg_poster_id":"204291","last_msg_subject":"Re: [XCore] how to create an EMF object instance in an operation?","last_msg_post_stamp":"1445953928","last_msg_update_stamp":"0","root_msg_poster_id":"3599","root_msg_subject":"[XCore] how to create an EMF object instance in an operation?","root_msg_post_stamp":"1445798926","root_msg_update_stamp":"0","last_user_msg_poster_id":"204291","last_user_msg_subject":"Re: [XCore] how to create an EMF object instance in an operation?","last_user_msg_stamp":"1445932260","msg4_update_stamp":"0","msg_group_post_stamp":"1445953928"}],"html_url":"https://www.eclipse.org/forums/index.php?t=usrinfo&id=204291","account_url":"https://api.eclipse.org/account/profile/mbarbero","posts_url":"https://api.eclipse.org/forums/post?user_id=204291"}


```
