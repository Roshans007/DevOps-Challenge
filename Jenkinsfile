node {
    def app

    stage('Clone repository') {
        /* Clone repository to the workspace */

        checkout scm
    }

    stage('Build Application') {
        /* This builds the actual image */

        sh "docker image prune -f"
        app = docker.build("roshans007/devops_challenge")
    }

    stage('Test Application') {
        /* We would run a test framework against our image. */

        app.inside {
            sh 'python tests/test.py'
        }
    }

    stage('Push Image') {
        /* We'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */

        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }

    stage('Deploy to Staging'){
        /* Remove the old container
         * and deploy the new image in staging
         * Note: Currently the deployment server is same for prod & stage so using port 8001 for staging */

        sh "docker stop devops_challenge_dev"
        sh "docker rm devops_challenge_dev"
        sh "docker run -d -p 8001:8001 --env-file .env -e 'PORT=8001' --name devops_challenge_dev --link dev-redis:redis roshans007/devops_challenge"
    }

    stage('Deploy approval'){
        /* Manual approval stage
         * If everything looks good on staging then release manager can approve else abort the build */

        input "Deploy to prod?"
    }

    stage('Deploy to Prod'){
        /* Remove the old container
           and deploy the new image in prod */

        sh "docker stop devops_challenge_prod"
        sh "docker rm devops_challenge_prod"
        sh "docker run -d -p 8000:8000 --env-file .env -e 'ENVIRONMENT=PROD' --name devops_challenge_prod --link prod-redis:redis roshans007/devops_challenge"
    }
}
