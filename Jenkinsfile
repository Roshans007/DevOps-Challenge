node {
    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage(Build) {
      sh ‘docker-compose -f dev-docker-compose.yml up -d’
    }

    stage('Test') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */
      sh
      docker run --env-file .env quay.io/deserve/static:${CODEBUILD_SOURCE_VERSION} /bin/bash -c 'python manage.py collectstatic --noinput --verbosity 1' 
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

    stage('Run App'){
        runApp()
    }
}

def runApp(){
    sh "ls"
    sh "docker run -d -p 8000:8000 --env-file ./env/prod.env --name devops_challenge_prod roshans007/devops_challenge"
    echo "Application started"
}
