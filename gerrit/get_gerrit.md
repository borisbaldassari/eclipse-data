
## Git review API

The Eclipse forge uses [Gerrit](https://www.gerritcodereview.com/) and Git for its code reviewing system. More information can be found on the following pages:

* The Eclipse wikipedia entry for Gerrit: https://wiki.eclipse.org/Gerrit
* The main Gerrit page for Eclipse: https://git.eclipse.org/r/#/q/status:open

## List all projects on a Gerrit server

The `get_gerrit_list_projects.pl` script queries a Gerrit server (in this case, the Eclipse Gerrit server) and lists all projects defined on the instance. The list is displayed on output and is stored in a CSV file (`gerrit_projects.csv`) in the current directory.

```
boris@kadath:gerrit$ perl get_gerrit_list_projects.pl
# Gerrit instance test run on Mon Jan 21 17:07:40 2019.

  Using [https://git.eclipse.org/r/].

# Testing gerrit > projects.
  Using https://git.eclipse.org/r/projects/.
  => Found 1647 projects:
  - permissions/ebr-dev ACTIVE
  - www.eclipse.org/rt ACTIVE
  - www.eclipse.org/images ACTIVE
[SNIP]
  - www.eclipse.org/mbeddr ACTIVE
  - permissions/cdo-dev ACTIVE
  - eclipsescada/org.eclipse.scada.releng ACTIVE
boris@kadath:gerrit$
```

The CSV file can then be easily imported into other software like R:

```
> data <- read.csv(file="gerrit_projects.csv", header=T, sep=",")
> names(data)
[1] "project"   "state"     "web_links"
> head(data, n=3)
                 project  state                              web_links
1    permissions/ebr-dev ACTIVE    plugins/gitiles/permissions/ebr-dev
2     www.eclipse.org/rt ACTIVE     plugins/gitiles/www.eclipse.org/rt
3 www.eclipse.org/images ACTIVE plugins/gitiles/www.eclipse.org/images
```

## List changes

The `get_gerrit.pl` script takes as input a project id (e.g. sirius/org.eclipse.sirius) and fetches the list of all changes from the server. Two CSV files are created:

* `gerrit_changes.csv` contains all changes, both open and closed, for the specific project ID.
* `gerrit_open_changes.csv` contains all currently open changes for the specific project ID.

An example run of the script is provided thereafter:

```
boris@kadath:gerrit$ perl get_gerrit.pl sirius/org.eclipse.sirius
# Gerrit instance test run on Mon Jan 21 17:59:31 2019.

  Using [https://git.eclipse.org/r/].

  Testing gerrit > changes.
  Using https://git.eclipse.org/r/changes/?q=+project:sirius/org.eclipse.sirius.
  => Found 5017.
  Attributes:
$VAR1 = 'project';
$VAR2 = 'deletions';
$VAR3 = 'subject';
$VAR4 = 'branch';
$VAR5 = 'unresolved_comment_count';
$VAR6 = 'updated';
$VAR7 = 'mergeable';
$VAR8 = 'created';
$VAR9 = 'hashtags';
$VAR10 = 'id';
$VAR11 = '_number';
$VAR12 = 'insertions';
$VAR13 = 'owner';
$VAR14 = 'submit_type';
$VAR15 = 'status';
$VAR16 = 'change_id';

# List of changes (showing only 10 items).
  - MERGED sirius/org.eclipse.sirius [cleanup] Remove a final static image from AnalysisResourceItemImpl
  - MERGED sirius/org.eclipse.sirius Report recent code changes from the previous code base.
  - MERGED sirius/org.eclipse.sirius Remove deprecated methods from the Session API
  - MERGED sirius/org.eclipse.sirius [419926] Fix rebranding errors in ViewpointSelection.
  - MERGED sirius/org.eclipse.sirius Adapt isFromSirius after namespace change
  - MERGED sirius/org.eclipse.sirius Report recent code changes from the previous code base.
  - MERGED sirius/org.eclipse.sirius Bump version number to 0.9.0.
  - MERGED sirius/org.eclipse.sirius Report recent code changes from the previous code base.
  - MERGED sirius/org.eclipse.sirius Re-Add the Viewpoint icon
  - MERGED sirius/org.eclipse.sirius Make Custom Properties displayed again in VP Editor
  Using https://git.eclipse.org/r/changes/?q=status:open+project:sirius/org.eclipse.sirius.
  => Found 5251 changes for project.
  Attributes:
$VAR1 = 'project';
$VAR2 = 'deletions';
$VAR3 = 'subject';
$VAR4 = 'branch';
$VAR5 = 'unresolved_comment_count';
$VAR6 = 'updated';
$VAR7 = 'mergeable';
$VAR8 = 'created';
$VAR9 = 'hashtags';
$VAR10 = 'id';
$VAR11 = '_number';
$VAR12 = 'insertions';
$VAR13 = 'owner';
$VAR14 = 'submit_type';
$VAR15 = 'status';
$VAR16 = 'change_id';

# List of changes (showing only 10 items).
  - NEW sirius/org.eclipse.sirius [DRAFT] : stop recording TOUCH notifications
  - NEW sirius/org.eclipse.sirius [468015] Deprecate ChangeViewpointSelectionCommand in sirius.ui plugin
  - NEW sirius/org.eclipse.sirius DRAFT [472186] Add possibility to add full selection with grouping item
  - NEW sirius/org.eclipse.sirius DRAFT [471816] Test to reveal the bug
  - NEW sirius/org.eclipse.sirius [466718] DRAFT -- Don't visit Mappings which can't be overriden
  - NEW sirius/org.eclipse.sirius DRAFT [467115] Try to fix test by adding sysout
  - NEW sirius/org.eclipse.sirius draft [463761] UI dependencies in the Sirius Edit bundles (diagram)
  - NEW sirius/org.eclipse.sirius DRAFT [cleanup] Improve GraphicalHelper with zoom level as 125% or 175%
  - NEW sirius/org.eclipse.sirius draft [463761] UI dependencies in the Sirius Edit bundles
  - NEW sirius/org.eclipse.sirius [DRAFT 463761] UI dependencies in the Sirius Edit bundles
```

Both CSV files can be easily imported into any statistical tool, like R:

```
> data <- read.csv(file="gerrit_changes.csv", header=T, sep=",")
> names(data)
 [1] "id"          "status"      "project"     "change_id"   "branch"     
 [6] "created"     "updated"     "insertions"  "deletions"   "submit_type"
[11] "subject"    
> head(data, n=3)
                                                                            id
1 sirius%2Forg.eclipse.sirius~master~Ia89be7b62ffa9862b6442a0ef7da5cd447605b4d
2 sirius%2Forg.eclipse.sirius~master~Ic2ca05784ba061fa1177ff4c51d821570adc909a
3 sirius%2Forg.eclipse.sirius~master~Ic191768bab82617f60462b636c287836590bce62
  status                   project                                 change_id
1    NEW sirius/org.eclipse.sirius Ia89be7b62ffa9862b6442a0ef7da5cd447605b4d
2    NEW sirius/org.eclipse.sirius Ic2ca05784ba061fa1177ff4c51d821570adc909a
3    NEW sirius/org.eclipse.sirius Ic191768bab82617f60462b636c287836590bce62
  branch                       created                       updated insertions
1 master 2019-01-04 10:16:38.000000000 2019-01-21 14:42:05.000000000         32
2 master 2019-01-21 08:21:26.000000000 2019-01-21 10:45:42.000000000         23
3 master 2019-01-16 09:01:52.000000000 2019-01-21 10:44:01.000000000        172
  deletions        submit_type
1     11801 MERGE_IF_NECESSARY
2         7 MERGE_IF_NECESSARY
3         7 MERGE_IF_NECESSARY
                                                         subject
1                 [542805] Remove oes.diagram.layoutdata plug-in
2 [541389] Update the target platforms to use GraphQL from Orbit
3             [541348] Add support for EMF EDataTypes in GraphQL
```
