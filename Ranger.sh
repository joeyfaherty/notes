Ranger API details:

# If you can sure of trusting a domain, use -k to supress certificate checking
$ curl -k https://insecure.url/content-i-really-really-trust

# Get all policies:
$ curl -u joey -v -i -s -X GET https://my-ranger:6080/service/public/api/policy

# from a file.json
$ curl -u joey -i -H "Accept:application/json" -H "Content-Type: application/json" -X POST https://my-ranger:6080/service/public/api/policy -d @policy.json

ansible-playbook test.yml -vvvv


