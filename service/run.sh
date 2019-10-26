#Pull Deployment, can also be triggered by push like Ansible or Jenkins
#1: Specify folders and files
#2: Setup environment variables, separated as versions.json and config.json
#3: Spin up all containers via docker-compose, pull latest images as needed.


export Home_folder=${HOME}
export Work_folder="${Home_folder}/service"
export Conf_folder="${Home_folder}/service/config"
export Conf_file="${Conf_folder}/config.json"
export Ver_file="${Conf_folder}/versions.json"

#export Server_ENV=$(cat ${Home_folder}server_env.txt)


#Get Version tags from json
for s in $(echo $values | jq -r 'to_entries|map("\(.key)=\(.value|tostring)")|.[]' ${Ver_file} ); do
    export $s
done

#Get config and secrets from json
for s in $(echo $values | jq -r 'to_entries|map("\(.key)=\(.value|tostring)")|.[]' ${Conf_file} ); do
    export $s
done

docker login -p $dk_psw -u $dk_usr $your-own-url:$port
cd ${Work_folder}
/usr/local/bin/docker-compose up -d $1
#Use variables in your docker-compose.yml to get updated versions, ports, paramters
