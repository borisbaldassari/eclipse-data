
## The Bugzilla API

[Bugzilla](https://www.bugzilla.org/) is used for [bug tracking at Eclipse](https://bugs.eclipse.org/bugs/). The installed version (5.x) provides a new [REST API](https://wiki.mozilla.org/Bugzilla:REST_API) that can be used to fetch information about bugs and their comments. 

The `get_bugzilla.pl` script provides an example to use this API. It can be called on a whole component or on a specific bug entry.


```
boris@kadath:bugzilla_v5$ perl get_bugzilla.pl 
usage: get_bugzilla.pl [-h|--help] product [bug_id]

get_bugzilla.pl retrieves git review information from a Gerrit instance.

Parameters:
* [-h|--help]             Display usage and exit
* product                 The product to be analysed, as defined in the bug 
                          e.g. Platform
* [bug_id]                An optional bug ID to retrieve information from. If none
                          is provided the full list is retrieved.
    
Examples:
$ get_bugzilla.pl Platform
$ get_bugzilla.pl Platform 100
```

The script creates two CSV files: 

* `bugzilla_all_bugs.csv` contains all bugs related to the selected component. Columns are: `bug_id`, `creator`, `creation_time`, `count`, `is_private`, `text`.
* `bugzilla_all_comments.csv` contains all comments for all bugs retrieved. Columns are: `id`, `summary`, `status`, `resolution`, `severity`, `priority`, `classification`, `platform`, `product`, `version`, `component`, `creation_time`, `creator`, `assigned_to`, `last_change_time`, `target_milestone`.

The CSV files can be easily imported into any data consuming software like R:

```
> data <- read.csv(file="bugzilla_all_bugs.csv", header=T, sep=",")
> names(data)
 [1] "id"               "summary"          "status"           "resolution" 
 [5] "severity"         "priority"         "classification"   "platform"
 [9] "product"          "version"          "component"        "creation_time"
[13] "creator"          "assigned_to"      "last_change_time" "target_milestone"

```
