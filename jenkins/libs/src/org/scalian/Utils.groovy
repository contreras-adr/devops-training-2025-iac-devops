package org.scalian-devops-2025

def getLastGitTag() {
    sh "git tag --sort version:refname | head -n 1 > version.tmp"
    String tag = readFile 'version.tmp'
    echo "Branch: ${scm.branches[0].name}"
    def result = tag ?: "0.0.1-Snapshot"
    echo "Tag, ${result}." 
    return result
}