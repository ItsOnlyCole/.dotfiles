#!/bin/bash
targetDirectory=$1
archive=$2

tar -cvfj $archive $targetDirectory
