import boto3

from flask import Flask

app = Flask(__name__)

def get_ec2_response():

    ec2 = boto3.client("ec2")

    return ec2.describe_instances()

def get_instances():

    response = get_ec2_response()

    instance_list = []

    for reservation in response["Reservations"]:

        for instance in reservation["Instances"]:

            name = "Unknown"

            for tag in instance.get("Tags", []):

                if tag["Key"] == "Name":
                    name = tag["Value"]

            instance_list.append(
                {
                    "name": name,
                    "instance_id": instance["InstanceId"],
                    "instance_type": instance["InstanceType"],
                    "state": instance["State"]["Name"],
                    "public_ip": instance.get("PublicIpAddress", "N/A")
                }
            )

    return instance_list

def get_instances_by_state(state):

    return [
        instance
        for instance in get_instances()
        if instance["state"] == state
    ]

@app.route("/identity")
def identity():

    sts = boto3.client("sts")

    response = sts.get_caller_identity()

    return {
        "account": response["Account"],
        "arn": response["Arn"]
    }

@app.route("/instances")
def instances():

    instance_list = get_instances()

    return {
        "instances": instance_list
    }
@app.route("/")
def home():
    return "Welcome to Cloudscope! This is a simple Flask application that provides information about your AWS environment."

@app.route("/health")
def health():
    return {
        "status": "healthy"
    }

@app.route("/version")
def version():
    return {
        "version": "1.0.0"
    }

@app.route("/summary")
def summary():

    instances = get_instances()

    total_instances = len(instances)

    running_instances = len(
        [
            instance
            for instance in instances
            if instance["state"] == "running"
        ]
    )

    stopped_instances = len(
        [
            instance
            for instance in instances
            if instance["state"] == "stopped"
        ]
    )

    return {
        "total_instances": total_instances,
        "running_instances": running_instances,
        "stopped_instances": stopped_instances
    }

@app.route("/stopped-instances")
def stopped_instances():

   return {
        "instances": get_instances_by_state("stopped")
    }

@app.route("/running-instances")
def running_instances():

    return {
        "instances": get_instances_by_state("running")
    }
    
if __name__ == "__main__":
    app.run(debug=True)