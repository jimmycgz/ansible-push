#Get Public or Private IP list from either a scaling group of tag group

export AWS_Profile='profile1'
export REGION='ca-central-1'
export ASG='tf-asg-2xxx...3'
export tag_name='standalone-ec2-pool'

asg_ips () {
#Get Public or Private IPs from a scaling group
	pri_ips=""
	pub_ips=""
	ids=""

        while [ "$ids" = "" ]; do
          ids=$(aws autoscaling describe-auto-scaling-groups --profile $AWS_Profile \
      		--auto-scaling-group-names $ASG --region $REGION \
		      --query AutoScalingGroups[].Instances[].InstanceId --output text)
          sleep 1
        done


	echo " "
	echo "Public IP list:"

	for ID in $ids;
	do
	    Pri_IP=$(aws ec2 describe-instances --profile $AWS_Profile --instance-ids $ID \
		  --region $REGION --query Reservations[].Instances[].PublicIpAddress --output text)
    
	    Pub_IP=$(aws ec2 describe-instances --profile $AWS_Profile --instance-ids $ID \
		  --region $REGION --query Reservations[].Instances[].PublicIpAddress --output text)

	    echo "$Pub_IP"

	    if [ "$pri_ips$pub_ips" = "" ]; then
		pri_ips="$pri_ips,$Pri_IP"
		pub_ips="$Pub_IP"
	    else
		pri_ips="$pri_ips,$Pri_IP"
		pub_ips="$pub_ips,$Pub_IP"
	    fi

	done
}

ec2-ips () {
#Get Public or Private IPs from a tag
	pri_ips=""
	pub_ips=""

	pub_ips=$(aws ec2 describe-instances --profile $AWS_Profile --region $REGION \
	--filter "Name=tag:Name,Values=v3-analysis-scal-pool" \
	--query Reservations[].Instances[].PublicIpAddress --output text)

	pri_ips=$(aws ec2 describe-instances --profile $AWS_Profile --region $REGION \
	--filter "Name=tag:Name,Values=v3-analysis-scal-pool" \
	--query Reservations[].Instances[].PrivateIpAddress --output text)

	echo " "
	echo "Public IP list:"

	for IP in $pub_ips;
	do
		echo $IP
	done 
}

# Uncomment any of below two to execute the function
#asg_ips
ec2-ips


echo " "
echo "public ips: $pub_ips"
