stg:
	ansible-playbook -i hosts.ini stg-play.yml
prod:
	ansible-playbook -i hosts.ini prod-play.yml

host:
	nano hosts.ini
