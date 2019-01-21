
## Jenkins API

This directory contains code and example to access the [Jenkins API](XXX) setup at the Eclipse forge.

The `get_jenkins.pl` script uses the Perl Mojo web agent to fetch information from the Jenkins API. It executes two types of requests:

* Information about the Jenkins instance itself

When the script is executed retrieved information is displayed on standard output, and two CSV files are created:

* `jenkins_jobs.csv` contains a list of all jobs defined on the instance.
* `jenkins_main.csv` holds basic information about the Jenkins instance.

Output is as follows:

```
# Jenkins instance test run on Sun Dec 10 22:07:32 2017.
  Using [https://ci.eclipse.org/californium].
  Testing basic root acces.
  Using https://ci.eclipse.org/californium/api/json.
  Found 16 attributes:
  - nodeDescription.
  - unlabeledLoad.
  - numExecutors.
  - useCrumbs.
  - jobs.
  - useSecurity.
  - nodeName.
  - slaveAgentPort.
  - assignedLabels.
  - mode.
  - description.
  - overallLoad.
  - primaryView.
  - quietingDown.
  - views.
  - _class.
* NodeDescription: the master Jenkins node
* Number of executors: 2
* NodeName:
* Mode: NORMAL
* Jobs: found 29 items:
    - 1.0.x [ blue ] https://ci.eclipse.org/californium/job/1.0.x/.
    - 1.0.x-nightly [ blue ] https://ci.eclipse.org/californium/job/1.0.x-nightly/.
    - 1.1.x-nightly [ blue ] https://ci.eclipse.org/californium/job/1.1.x-nightly/.
    - 2.0.x [ blue ] https://ci.eclipse.org/californium/job/2.0.x/.
    - 2.0.x-nightly [ red ] https://ci.eclipse.org/californium/job/2.0.x-nightly/.
    - actinium [ aborted ] https://ci.eclipse.org/californium/job/actinium/.
    - californium.core [ disabled ] https://ci.eclipse.org/californium/job/californium.core/.
    - californium.core java8 [ disabled ] https://ci.eclipse.org/californium/job/californium.core%20java8/.
    - californium.core-release [ disabled ] https://ci.eclipse.org/californium/job/californium.core-release/.
    - californium.core-release-tagged [ disabled ] https://ci.eclipse.org/californium/job/californium.core-release-tagged/.
    - debug_branch [ disabled ] https://ci.eclipse.org/californium/job/debug_branch/.
    - element-connector [ disabled ] https://ci.eclipse.org/californium/job/element-connector/.
    - element-connector-release [ disabled ] https://ci.eclipse.org/californium/job/element-connector-release/.
    - element-connector-release-old [ disabled ] https://ci.eclipse.org/californium/job/element-connector-release-old/.
    - element-connector-release-tagged [ disabled ] https://ci.eclipse.org/californium/job/element-connector-release-tagged/.
    - hudson-debug [ disabled ] https://ci.eclipse.org/californium/job/hudson-debug/.
    - hudson-explore [ disabled ] https://ci.eclipse.org/californium/job/hudson-explore/.
    - master [ blue ] https://ci.eclipse.org/californium/job/master/.
    - master-nightly-sandbox [ disabled ] https://ci.eclipse.org/californium/job/master-nightly-sandbox/.
    - parent-release [ blue ] https://ci.eclipse.org/californium/job/parent-release/.
    - parent-release-tagged [ disabled ] https://ci.eclipse.org/californium/job/parent-release-tagged/.
    - parent-release-test [ disabled ] https://ci.eclipse.org/californium/job/parent-release-test/.
    - scandium [ disabled ] https://ci.eclipse.org/californium/job/scandium/.
    - scandium-release [ disabled ] https://ci.eclipse.org/californium/job/scandium-release/.
    - scandium-release-tagged [ disabled ] https://ci.eclipse.org/californium/job/scandium-release-tagged/.
    - scandium-sonar [ disabled ] https://ci.eclipse.org/californium/job/scandium-sonar/.
    - tools [ blue ] https://ci.eclipse.org/californium/job/tools/.
    - tools-release [ blue ] https://ci.eclipse.org/californium/job/tools-release/.
    - tools-release-tagged [ blue ] https://ci.eclipse.org/californium/job/tools-release-tagged/.
```

The generated CSV files can easily be imported in statistical or analysis tools like R:

```
> data <- read.csv(file="jenkins_jobs.csv", header=T, sep=",")
> names(data)
[1] "name"  "color" "url"  
> head(data, n=3)
           name color                                                   url
1         1.0.x  blue         https://ci.eclipse.org/californium/job/1.0.x/
2 1.0.x-nightly  blue https://ci.eclipse.org/californium/job/1.0.x-nightly/
3 1.1.x-nightly  blue https://ci.eclipse.org/californium/job/1.1.x-nightly/
```
