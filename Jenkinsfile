node {
    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        app = docker.build("roshans007/devops_challenge")
    }

    stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */

        app.inside {
            sh 'python tests/test.py'
        }
    }

    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
    stage('Deploy') {
        docker.image('roshans007/devops_challenge:latest').withRun('-p 8000:8000 --env-file env/prod.env') {
          /* do things */
        }
    }

    /*stage('Remove Unused docker image') {
      steps{
        sh "docker rmi -f roshans007/devops_challenge:latest roshans007/devops_challenge:${env.BUILD_NUMBER}"
      }
    }*/
}
