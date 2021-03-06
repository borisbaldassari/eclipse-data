
######################################################################
# Copyright (c) 2017 Castalia Solutions
#
# This program and the accompanying materials are made
# available under the terms of the Eclipse Public License 2.0
# which is available at https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0
######################################################################


echo "\nGet info for user bbaldassari2kd:\n";
curl -s https://api.eclipse.org/account/profile/bbaldassari2kd
# Returns
# {"uid":"60694","name":"bbaldassari2kd","mail":"boris@chrysalice.org","eca":{"signed":true},"is_committer":false,"friends":{"friend_id":null},"first_name":"Boris","last_name":"Baldassari","twitter_handle":"BorisBaldassari","github_handle":"borisbaldassari","org":"Castalia Solutions","job_title":"Consultant","website":"http://castalia.solutions","country":{"code":"FR","name":"France"},"bio":"","interests":[]}

echo "\n\nGet projects for user baldassari2kd:\n";
curl -s https://api.eclipse.org/account/profile/bbaldassari2kd/projects
# Returns
# []

echo "\n\nGet projects for user mbarbero:\n";
curl -s https://api.eclipse.org/account/profile/mbarbero/projects
# Returns
# {"technology.cbi":[{"ActiveDate":"2015-12-18","InactiveDate":null,"EditBugs":"0","ProjectName":"Common Build Infrastructure","url":"https://projects.eclipse.org/projects/technology.cbi","Relation":{"Relation":"PL","Description":"Project Lead","IsActive":"1","Type":{"Type":"PR","Description":"Person - Project"}}},{"ActiveDate":"2015-05-20","InactiveDate":null,"EditBugs":"0","ProjectName":"Common Build Infrastructure","url":"https://projects.eclipse.org/projects/technology.cbi","Relation":{"Relation":"CM","Description":"Committer","IsActive":"1","Type":{"Type":"PR","Description":"Person - Project"}}}],"technology.dash":[{"ActiveDate":"2015-02-05","InactiveDate":null,"EditBugs":"0","ProjectName":"Dash, Tools for Committers","url":"https://projects.eclipse.org/projects/technology.dash","Relation":{"Relation":"CM","Description":"Committer","IsActive":"1","Type":{"Type":"PR","Description":"Person - Project"}}}],"tools.orbit":[{"ActiveDate":"2013-02-15","InactiveDate":null,"EditBugs":"0","ProjectName":"Eclipse Orbit","url":"https://projects.eclipse.org/projects/tools.orbit","Relation":{"Relation":"CM","Description":"Committer","IsActive":"1","Type":{"Type":"PR","Description":"Person - Project"}}}],"eclipse.platform":[{"ActiveDate":"2017-04-07","InactiveDate":null,"EditBugs":"0","ProjectName":"Eclipse Platform","url":"https://projects.eclipse.org/projects/eclipse.platform","Relation":{"Relation":"CM","Description":"Committer","IsActive":"1","Type":{"Type":"PR","Description":"Person - Project"}}}],"technology.tea":[{"ActiveDate":"2017-04-18","InactiveDate":null,"EditBugs":"0","ProjectName":"Eclipse TEA","url":"https://projects.eclipse.org/projects/technology.tea","Relation":{"Relation":"ME","Description":"Mentor for Projects","IsActive":"1","Type":{"Type":"PR","Description":"Person - Project"}}}],"modeling.umlgen":[{"ActiveDate":"2014-03-04","InactiveDate":null,"EditBugs":"0","ProjectName":"Eclipse UML Generators","url":"https://projects.eclipse.org/projects/modeling.umlgen","Relation":{"Relation":"CM","Description":"Committer","IsActive":"1","Type":{"Type":"PR","Description":"Person - Project"}}}],"rt.yasson":[{"ActiveDate":"2016-11-02","InactiveDate":null,"EditBugs":"0","ProjectName":"Eclipse Yasson","url":"https://projects.eclipse.org/projects/rt.yasson","Relation":{"Relation":"ME","Description":"Mentor for Projects","IsActive":"1","Type":{"Type":"PR","Description":"Person - Project"}}}],"modeling.emfcompare":[{"ActiveDate":"2011-10-06","InactiveDate":null,"EditBugs":"1","ProjectName":"EMF Compare","url":"https://projects.eclipse.org/projects/modeling.emfcompare","Relation":{"Relation":"CM","Description":"Committer","IsActive":"1","Type":{"Type":"PR","Description":"Person - Project"}}}],"foundation-internal.simrel":[{"ActiveDate":"2015-03-03","InactiveDate":null,"EditBugs":"0","ProjectName":"simrel","url":"","Relation":{"Relation":"PL","Description":"Project Lead","IsActive":"1","Type":{"Type":"PR","Description":"Person - Project"}}}]}

echo "\n\nGet gerrits for user mbarbero:\n";
curl -s https://api.eclipse.org/account/profile/mbarbero/gerrit
# Returns
# {"merged_changes_count":"490"}

echo "\n\nGet forums posts for user bbaldassari2kd:\n";
curl -s https://api.eclipse.org/account/profile/bbaldassari2kd/forum
# Returns
# {"id":null,"alias":null,"posted_msg_count":"0","join_date":null,"last_visit":null,"level_name":null,"posts":[],"html_url":null,"account_url":"https://api.eclipse.org/account/profile/bbaldassari2kd","posts_url":null}


echo "\n\nGet forums posts for user mbarbero:\n";
curl -s https://api.eclipse.org/account/profile/mbarbero/forum
# Returns
# {"id":"204291","alias":"Mika\u00ebl Barbero","avatar_loc":null,"email":"mikael.barbero@eclipse-foundation.org","posted_msg_count":"2","join_date":"1423976351","location":null,"sig":null,"last_visit":"1487069464","level_name":"Junior Member","level_img":null,"posts":[{"msg_id":"1712648","msg_thread_id":"1071519","msg_poster_id":"204291","msg_reply_to":"1712636","msg_post_stamp":"1445932260","msg_update_stamp":"0","msg_updated_by":"0","msg_subject":"Re: [XCore] how to create an EMF object instance in an operation?","thread_id":"1071519","thread_forum_id":"108","thread_root_msg_id":"1712476","thread_last_post_date":"1445953928","thread_replies":"7","thread_views":"1209","thread_rating":"0","thread_n_rating":"0","thread_last_post_id":"1712694","thread_orderexpiry":"0","thread_thread_opt":"0","thread_tdescr":"","forum_name":"EMF","forum_cat_id":"5","forum_description":"Eclipse Modeling Framework (Core) &#160; <a class='smallLink' href='/modeling/emf/?project=emf'>[project home]</a>","forum_date_created":"1248897121","forum_thread_count":"16082","forum_post_count":"77423","forum_last_post_id":"1776680","cat_name":"Modeling","cat_description":" - Modeling tools and technologies - click +/- to expand/collapse","read_last_view":null,"last_msg_poster_id":"204291","last_msg_subject":"Re: [XCore] how to create an EMF object instance in an operation?","last_msg_post_stamp":"1445953928","last_msg_update_stamp":"0","last_poster_email":"mikael.barbero@eclipse-foundation.org","last_poster_alias":"Mika\u00ebl Barbero","root_msg_poster_id":"3599","root_msg_subject":"[XCore] how to create an EMF object instance in an operation?","root_msg_post_stamp":"1445798926","root_msg_update_stamp":"0","root_poster_email":"bhunt@mac.com","root_poster_alias":"Bryan Hunt","last_user_msg_poster_id":"204291","last_user_msg_subject":"Re: [XCore] how to create an EMF object instance in an operation?","last_user_msg_stamp":"1445932260","msg4_update_stamp":"0","msg_group_post_stamp":"1445953928"}]}

echo "\n\nGet mailing list information for scava-dev:\n";
curl -s https://api.eclipse.org/mailing_lists/metadata?name=scava-dev
# Returns


echo "\n";

