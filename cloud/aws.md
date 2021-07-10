
# Instance Type

- m5,m4
	「バランスがいい」
	CPUやメモリ、ネットワークをバランスよく提供する。一般的な安定利用なら
	一般的には本番環境ならこっちね
- t3,t2
	「バースト」できることが特長
	「ある時間だけ負荷が集中する」といった傾向が見えているWebサイトなどが当てはまりそうです
	開発環境やステージング環境などはこっちでコストを抑える
	本番も用途に応じてこちらを選ぶのもある、「CPUクレジット」のグラフを見て検討するのがいいでしょう
- c5,c4
	「コンピューティング負荷の高いワークロードに最適化」
	性能が高いプロセッサを積んでる、性能要件が高い場合はこちらを選ぶ		<--> ただし搭載メモリサイズは下がります
	用途に応じてこちらを選ぶ
- r5,r6
	搭載メモリサイズが増えています。
	　・r5: CPU 3.1Ghz、Mem "16GB" vs ・m5: CPU 3.1Ghz、Mem "8GB"
- ストレージ最適化 i3, d2, d3, h1 等
	EC2をホストするサーバに物理的に接続されているローカルストレージ（インスタンスストア）が標準利用可能なため、大量のIOトランザクションに対しても低レイテンシーで高速に利用可能です。
- 高速コンピューティング p3/p4, Inf1, g3/g4, f1 等
	GPUが搭載 for 動画エンコードなどグラフィック処理; FPGAが搭載 for ゲノム研究
- 「デフォルトでEBS最適化されています」インスタンスタイプ: EBSとその他NWが切り分けられてボトルネックになりにくい
	I/Oが多い場合は、これも考慮して選ぶべき
	
## 追加機能
e.g. m5a.2xlarge
追加機能無しタイプに対し、CPUをIntel製から変更したりリソース強化、追加等を意味します。
- a: AMD製CPUを搭載
	- m5.large: $ 0.124/h
	- m5a.large: $ 0.112/h （約10%安い）
- g: CPUは AWS Graviton2 を搭載	（Intel製と比較しコストメリット高） 	t4g/ m6g / c6g / r6g 等
- n: ネットワークを強化 	m5n / c5n / r5n 等
- d: NVMe ベースのローカルSSDストレージ（高速なIOのインスタンスストア）を追加. z1d 等
- e: メモリ搭載量を強化 (x1の場合) 	x1e


# How to Create AWS VPC in 10 steps, less than 10 min | by Varun Kumar Manik | Medium
Below are the 10 steps to Create and Verify your VPC

Diagram
	VPC	10.0.0.0/16
		Public Subnet	10.0.0.0/24	Private IP: 10.0.0.5, Elastic IP: 5.6.7.8
			with VPC NAT Gateway 10.0.0.8
			with instance Security Group
			Custom route table	10.0.0.0/16 target: local, 0.0.0.0/0 target: igw-xxxxx
		Private Subnet	10.0.1.0/24
			for instances
			Main route table	10.0.0.0/16 target: local, 0.0.0.0/0 target: nat-gw-xxxxx (above)

Step 01. Create a VPC
Step 02. Create 2 Public Subnet & Create 2 Private Subnet
Step 03. Create IGW (Internet Gateway) & Attach to the VPC
Step 04. Create Public and Private Route Table
Step 05. Add IGW in Public Route table (0.0.0.0/0)		routing 0.0.0.0/0 -> igw-xxxxx - PublicRT
Step 06. Add Public Subnet (1a & 1b) in Route table		associate subnets into the same route table - PrivateRT
Step 07. Create a NAT Gateway in Public Subnet
Step 08. Add NAT GW into the Private Route Table
Step 09. Add Private Subnet in Private Route Table
Step 10. Launch EC2 in this VPC & Validate your Connection

Optional Steps:
Step 11. Edit DNS Resolution and Hostname
Step 12. Cleanup the VPC Resources



# MISC

- ami to s3
		aws ec2 export-image --image-id ami-id --disk-image-format VMDK --s3-export-location S3Bucket=my-export-bucket,S3Prefix=exports/
		aws ec2 import-image --description "My server VM" --disk-containers Format=ova,UserBucket="{S3Bucket=my-import-bucket,S3Key=vms/my-server-vm.ova}"
		aws ec2 create-instance-export-task --instance-id INSTANCEID --target-environment vmware --export-to-s3-task file://C:\file.json
		aws ec2 create-instance-export-task --description "RHEL5 instance" --instance-id i-1234567890abcdef0 --target-environment vmware --export-to-s3-task DiskImageFormat=vmdk,ContainerFormat=ova,S3Bucket=myexportbucket,S3Prefix=RHEL5
		aws ec2 import-snapshot --description "My server VMDK" --disk-container Format=VMDK,UserBucket={S3Bucket=my-import-bucket,S3Key=vms/my-server-vm.vmdk}
		Or this (what is the difference?):
		aws ec2 create-store-image-task --image-id ami-046eb018cc11b38a4 --bucket my-testing-bucket1 -> command not found!!!
		aws ec2 create-restore-image-task --object-key ami-046eb018cc11b38a4.bin --bucket my-testing-bucket1 --name "Pango's testing AMI" -> command not found!!!
		Verified steps:
			aws s3 mb --region ap-southeast-1 s3://my-testing-bucket1
			aws s3 cp ./test.txt s3://my-testing-bucket1/

			//Set roles for user first: https://docs.aws.amazon.com/vm-import/latest/userguide/vmie_prereqs.html#vmimport-role
			aws iam create-role --role-name vmimport --assume-role-policy-document "file://./trust-policy.json"
			aws iam put-role-policy --role-name vmimport --policy-name vmimport --policy-document "file://./role-policy.json"

			aws ec2 describe-images --region ap-southeast-1 --owners self
			aws s3api list-buckets
			aws ec2 export-image --region ap-southeast-1 --image-id ami-046eb018cc11b38a4 --disk-image-format VMDK --s3-export-location S3Bucket=my-testing-bucket1,S3Prefix=exports/
			aws ec2 describe-export-image-tasks --region ap-southeast-1 --export-image-task-id export-ami-0ebb0250ee946ec2c
			aws ec2 import-image --region ap-southeast-1 --description "Pango's testing AMI" --disk-containers Format=VMDK,DeviceName=/dev/xvda,UserBucket="{S3Bucket=my-testing-bucket1,S3Key=exports/export-ami-0ebb0250ee946ec2c.vmdk}"
			aws ec2 describe-import-image-tasks --region ap-southeast-1
- ami to s3 to glacier
	TODO...

