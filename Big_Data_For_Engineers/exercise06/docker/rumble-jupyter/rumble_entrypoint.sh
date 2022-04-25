#!/bin/bash

spark-submit $SPARK_SUBMIT_OPTIONS $SPARK_HOME/jars/spark-rumble-jar-with-dependencies.jar "$@"
