
# Tutorials
## Client Script
Right click on record's header > Configure > Client Scripts > New
	Table: Incident
	Type: OnChange

function onChange(////){
  if(newValue == 1){
    g_form.setMandatory('category', true);
    g_form.setValue('short_description', 'Priority 1 Ticket')
  }
}

Remember to "Reload form" on record UI everytime after coding.

## Import Set and Data Sources

System Import Sets > Load Data
	Type: File
	Retrieve: Attachment
Create transform map
	// You can also "Run script"
	Related Link: "Auto Map Mapping Fields"
		Click on any field and set "Choice action". Can also "Use source script".
		Set some Coalease to true.
	Related Link: "Transform"
	Next steps: Go to Import Set

System Import Sets > Data Sources
	Related Link: Load all records
	

## Script Includes
	UI Action
	https://www.youtube.com/watch?v=tDq7hmbRwek


## Design a Catalog Item
https://www.youtube.com/watch?v=h93szUIZ6Ac

## Workflow
Workflow > Run Script Activity



## REST Message
curl -XPOST --insecure --user snowbot:11199f637e6adaa3d499bb0f4c773b5ad2 \
     https://JENKINS_URL:JENKINS_PORT/job/Zabbix/job/JOB_NAME/buildWithParameters?PARAM1=A&PARAM2=3


##
javax.net.ssl.SSLPeerUnverifiedException: peer not authenticated
https://docs.servicenow.com/bundle/istanbul-security-management/page/product/security-operations-common/task/update-cert_1.html

Acquire the SSL certificate from the third-party vendor.
For example, you can import an X.509 Certificate (PEM) from an SSL endpoint in the Firefox browser, as follows.
    Enter the endpoint URL into the browser address bar. For example: https://<3rdparty>/.
    Click the lock icon in the address line.
    Click More Information and click the Security tab.
    Click View Certificate and click the Detail tab.
    Click Export to save the PEM into your local file system.
    Open the saved file in any text editor tool and copy the content to the clipboard. It must begin with -----BEGIN CERTIFICATE----- and end with -----END CERTIFICATE-----.

Navigate to System Definition > Certificates.
Click New and create a new record for the integration.
In PEM Certificate, paste in the certificate you downloaded and copied into the clipboard earlier.
Click Save.

org.apache.commons.httpclient.HttpException: SSLPeerUnverifiedException


[Istanbul / Kingston]

                   System Definition > Certificates

                               Attach copy of self-signed cert (.cer) as DER/Trust Store Cert

[Jakarta]

               If Error:org.apache.commons.httpclient.HttpException: SSLPeerUnverifiedException

				Navigation > sys_properties.list > ENTER
               Set sys_properties 'com.glide.communications.httpclient.verify_hostname' = false (in sub-PROD only!)


(i) OOTB there is a module "All properties" which is defined under application menu "System properties". However, this is not visible because it is restricted to maint role only. To make the changes navigate to module from the navigation filter and search for a record "All properties"->Open the record and update the roles field to admin. 
