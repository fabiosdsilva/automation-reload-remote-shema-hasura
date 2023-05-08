const dotenv = require('dotenv').config()
const { exec } = require('child_process')
const fs = require('fs')

const commnad = `hasura metadata reload --admin-secret ${process.env.HASURA_GRAPHQL_ADMIN_SECRET}`

async function reloadMetadata() {
	const folders = fs.readdirSync('./output')

	for (const folder of folders) {
		if (folder !== 'nginx') {
							
			exec(`cd output/${folder}/hasura;${commnad}`, (err, stdout, stderr) => {
				if (err) {
					console.error(err)
					return
			  	}
		
				console.log(stdout)
				console.log(stderr)

				console.log(`Reloaded metadata for ${folder}`)
			})
		}
		
	}
}

reloadMetadata()