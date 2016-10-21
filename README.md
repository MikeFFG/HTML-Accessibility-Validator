**HTML and Accessibility Validation**

All commands are described from root of project folder.

**Running checker**

To run the accessibility and html checker, and populate the json log files used
by the site, type:
```
ruby main.rb [flags]
```

__Flags:__

```-a``` - stands for automatic. This will download the info from this google doc:
https://docs.google.com/spreadsheets/d/1PRqzAK8M2qPhV2navyistU41cvfVjZL3W0iWClF0h5M/edit#gid=0
It will then run the html and accessibility checkers on them and store it in the logs folder. This automatically clears the logs each time.

```-u http://www.example.com``` - this is to manually run these checkers on one url. It will not clear the logs each time you run it.

```-c``` - clears the logs before running.

**Launching Site**

From root project folder, to launch site/server, on command line type:
```
ruby report_site/report_site.rb
```
You will be able to see the site at http://localhost:7655/

