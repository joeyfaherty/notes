# run only a single test in idea
put cursor in a test and press Alt + Shift + F10

# package jar file. This phase will build and run tests. If tests fail the jar will not be packaged.
$ sbt assembly

# sbt goals
sbt clean 	
Deletes all generated files (in the target directory).

sbt compile 	
Compiles the main sources (in src/main/scala and src/main/java directories).

sbt test 	
Compiles and runs all tests.

sbt console 	
Starts the Scala interpreter with a classpath including the compiled sources and all dependencies. To return to sbt, type :quit, Ctrl+D (Unix), or Ctrl+Z (Windows).

sbt run <argument>* 	
Runs the main class for the project in the same virtual machine as sbt.

sbt package 	
Creates a jar file containing the files in src/main/resources and the classes compiled from src/main/scala and src/main/java.

sbt help <command> 	
Displays detailed help for the specified command. If no command is provided, displays brief descriptions of all commands.

sbt reload 	
Reloads the build definition (build.sbt, project/*.scala, project/*.sbt files). Needed if you change the build

-------------------------------------------
