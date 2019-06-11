node {
    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */
        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        sh "docker image prune -f"
        app = docker.build("roshans007/devops_challenge")
    }

    stage('Test image') {
        /* We would run a test framework against our image. */

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

    stage('Run App Dev'){
        sh "docker run -d -p 8001:8001 -e 'PORT=8001' --name devops_challenge_dev --link dev-redis:redis roshans007/devops_challenge"
    }
}
