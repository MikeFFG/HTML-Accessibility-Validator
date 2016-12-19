##HTML and Accessibility Validation

The purpose of this repository is to create a way to automate html and accessibility validation tasks

All commands are described from root of project folder.

Requires gem bundler, npm and grunt. 

Run `bundle install` in directory to install Ruby Gem dependencies.
Run `npm install` in directory to install node dependencies.
Then, the first time you open the project, run `grunt create`. This will create the necessary log files.
If you already have these files, ignore this step because this will overwrite your logs.

**Running checker**

To run the accessibility and html checker, and populate the json log files used
by the site, type:
```
ruby validator/main.rb [flags]
```

__Flags:__

```-a``` - "automatic". This will download the info from this google doc:

https://docs.google.com/spreadsheets/d/1PRqzAK8M2qPhV2navyistU41cvfVjZL3W0iWClF0h5M/edit#gid=0

It will then run the html and accessibility checkers on them and store it in the logs folder. This automatically clears the logs each time.
Note that this doc is only available to those at Pixo but it could easily be repurposed for any other google doc.

It will also clear the logs each time it is run

```-u http://www.example.com``` - this is to manually run these checkers on one url. 
It will not clear the logs each time you run it. Note you must add the http:// and quotes are not necessary.

```-t "name of site/client/test"``` - adds custom title for the test (not for use with -a).

```-c``` - clears the logs before running (not for use with -a).

**Launching Site**

From root project folder, to launch site/server, on command line type:
```
ruby report_site/report_site.rb
```
You will be able to see the site at http://localhost:7655/

