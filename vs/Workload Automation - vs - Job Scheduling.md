
https://www.benwebmaster.com/workload-automation-vs-job-scheduling/

Job Scheduling
	While on the contrary, a job scheduling software functions by scheduling "jobs and related processes" for the individuals.
	Most are time-based schedulers

	Job schedulers are native tools to automate batch processing after business processes are finished. Job scheduler helps in automating IT Processes like database maintenance.
	Mainly for backend processing.
	Mainly for developer.

Workload Automation
	The process that functions by automating a particular series of "business processes" and functions is termed as workload automation.
	has developed from job scheduling software
		for running batch processes like payroll, processing inventory levels for re-stock, credit count account processing etc.
	are capable of handling event-based scheduling and resource management across a complex amalgam of applications, databases and architectures, both physical and virtual.
	Broader automation:  The approach of workload automation which is to automate the entire system within the business that may or may not include some heterogeneous server environments.
		- 
	
	Features & Capabilities
	    - Ability to manage a business process from end-to-end
		- Central dashboard providing data on trends and forecasts
		- Audit trails/logging to ensure regulatory compliance
		- Management by exception alerts and notifications
		- Analysis and visualization tools to help prioritize response
		- Application of a broad range of enterprise applications
		- Self-service features to enable users to start processes without the help of IT
		- self-service solution: e.g. Customers are expecting things like managing bank accounts online and receive accurate flight details on a mobile app.

	Automating it makes it possible to manage these tasks without any human intervention.
	Unlike traditional batch processing, the approach is shifted from a time driven to event-driven processing.
	Workload automation is used by everyone from the business from developer to business person, even to customers.

=> where they differ is in the scope of functionality.
	workload automation tools cover a broader range of capabilities
		Workload automation is a practice of automating background processes and back-office systems. Unlike Job scheduler, the workload automation tool supports multiple applications and workflows including cross-system dependencies.


Benefits of workload automation in digital transformation

    Forecasting capabilities
    Customer support
    Overall value
    Reduce operating expenses for IT workload automation by 20-50%.
    Increase the productivity of IT staff by > 75%.
    See an ROI payback period of 12-18 months.
    Organizations can achieve the following:
        Increase in batch processing window by 80-100%						// batch window is a period of less-intensive online activity
        Reduced number of jobs falling by 81-100%
        Reduced server resources needed for WLA by 81-100%



https://www.bmc.com/blogs/job-scheduling-vs-workload-automation-whats-difference/
Job Scheduling vs Workload Automation: What’s The Difference?
Joe Hertvik, February 8, 2017

Most IT managers understand the differences between job scheduling and enterprise workload automation software, so there’s no point in explaining it further, right?

The problem is that even though you may know the differences, others may not. And at some point, you’ll probably have to explain those differences to someone else, such as a programmer, a Service Desk tech, your CIO, controller, or CEO.

For those times, here’s a simple explanation of the differences in plain English.

## Job Scheduling Software

Job scheduling packages are used for controlling the unattended processing of batch jobs on a single system. All major OS platforms have a job scheduler built into their operating system, such as the Windows Task Scheduler, the integrated IBM i job scheduler, and the cron job scheduler for Unix-like environments and Linux. For the IBM i operating system, there are also several third-party job scheduling packages that provide capabilities beyond the basic IBM i job scheduler (see my community post on IBM i job scheduling software for a more complete list of vendors offering third-party schedulers).

Job schedulers are generally platform-specific. They are configured to submit batch jobs for execution according to a pre-defined schedule or after a dependent event occurs. Some examples of dependent events that can submit jobs in a job scheduler are specific days and times of the week (i.e. Monday at 10:00 AM or Tuesday at 3:00 AM), specific days of the month (i.e. last date of month; first Monday; the 15th), or the completion of another batch job.

Traditional job scheduling software generally runs jobs only on one machine, which introduces a number of problems for organizations, including:

    Siloed solutions: Lack of coordination between job schedulers running on different operating systems, such that critical related jobs on different operating systems may not run or may run out of sequence. Job schedulers generally don’t talk or work with each other across platforms.
    Complexity: Scheduling jobs and maintenance becomes more complicated as several schedulers on different operating systems must be manually configured and maintained, increasing complexity and the possibility of errors. More time from IT personnel is needed to perform these duties.
    Manual intervention: Job schedulers frequently require manual intervention to correct problems between related scheduled processes on different machines, such as when a file is created on one machine and FTP’d to a second machine to be processed.
    Programming resources: Job scheduling frequently requires additional scripting or programming to fill in gaps that occur when coordinating processes between machines and operating systems.

## Enterprise Workload Automation Software

Enterprise workload automation software offers improvements to these challenges. It performs all the same functions as job scheduling software, with these critical enhancements for working with batch jobs and coordinating processes on different servers and operating systems:

    Consistency: One standard graphical interface for configuring workloads on different servers, rather than having to configure job entries in several different packages.
    Visibility and control: Centralized control for scheduling and running different workloads on different servers, providing an enterprise-wide view and control over all batch jobs across the enterprise. Enterprise workload automation software also allows you to view active jobs and job run histories for processes controlled by the software.
    Simplified file transfers: Scheduling and integration of file transfers between different platforms and machines from the central interface, rather than scheduling transfers on each individual server.
    Faster workload deployments: Automatically promote new workloads from test to QA to production, eliminating the need to repeat manual configurations when going live (which can cause manual configuration errors).
    Big data: Schedule big data workloads using Hadoop.
    Programming reduction: Elimination of the need for manual scripting or programming when using different job schedulers on different systems. Job dependencies are worked out in your enterprise workload automation software, not in your programming department.
    Error reduction: Improve coordination between scheduled processes for co-dependent processing running on different servers, reducing errors that can occur when jobs run out of sequence or a critical job fails.
    SLA improvement: Integrate schedule changes to avoid resource conflicts and forecasted job completion times, ensuring that jobs will finish on time, helping to satisfy Service Level Agreements (SLAs).
    Reduced staff time needed to run scheduled jobs and processes: Less time is needed to configure, monitor, and respond with a single-level workload automation system than is needed for multiple separate job scheduler installs.

Enterprise workload automation solutions are to job scheduling software what a 2017 Tesla with AutoPilot is to a 1966 Volkswagon Beetle. Both products do the same basic job (scheduling and running of jobs and processes), but you can do more, and do it much better, with an enterprise workload automation solution. An enterprise workload automation solution is much more than a souped-up job scheduler: it’s a significant improvement in the entire implementation of job and workload scheduling.

## To learn more
This post provides a basic understanding of what job schedulers and enterprise workload automation solutions do and what the advantages are in using an enterprise workload automation solution. To find out more about enterprise workload automation products such as Control-M solution, please contact BMC Software for additional information.


# Difference with RPA
- As your virtual employee
- Not actually have to be physical robot
- Dcouments every step consistently
- Time-to-market within a few weeks
- No changes in your existing infrastructure needed
- Uses your existing applications

Functioning Layer: RPA imitates the user's activities, while the tranditional automation execute the programming instructions only.
Programming Skills: Creating a flowchart or diagram only. Not require any programming knowledge but maybe helpful
Complex System: RPA is independent of the architecture of the system. It just imitates the human activities. But for conventional autoation techniques the complex systems cannot be automated due to certain restrictions on the programming language.
Design Time for Scenario: Require less time to prepare the scenario, start from define on flowchart on GUI.
Domain Knowledge: users should have strong knowledge of the process and domain similar to other conventional automation techniques.
Primary Use: On anything a human can do. Can also be used for testing.
Execution Time and Scalability: Same level as human activities? Tranditional automation may be better at this.
Maintenance of Test Scenario: The RPA is very simple and easy to use, due to which the users are able to update any business operation and process. But the maintenance of the testing scenarios would be more costly.



# cronの代替になりそうなジョブ管理ツールのまとめ

REF: https://qiita.com/shrkw/items/5c3d53358b0016a09504

たまに検討するけど、よく忘れるのでまとめておく。ごく個人的な感想としては、Rundeck, Azkabanあたりで始めてみるのがいいかもと思う。
要件

    重複実行の防止
    ジョブの実行結果、かかった時間、ログ出力などが見れる
    失敗時の通知

候補
OSS系
Rundeck

    http://rundeck.org/
    Java Runtimeで動く
    RUNDECK PROという有料サービスもある http://simplifyops.com/
    参考: http://heartbeats.jp/hbblog/2015/01/rundeck.html

Oozie

    http://oozie.apache.org/
    Workflow Scheduler for Hadoop
    Java
    http://oozie.apache.org/docs/4.1.0/DG_Overview.html
    Webコンソールもあるみたい

Luigi

    https://github.com/spotify/luigi
    Built at Spotify
    Pythonで動く Downloading and running python setup.py install
    CUIベースで触るっぽい感じ？

Azkaban

    https://azkaban.github.io/
    created at LinkedIn to run Hadoop jobs
    Java Runtimeで動く
    きれいなweb UI
    soloモードだと、マネージャーもExcetorもDB (H2)も全部入りなので1サーバーだけで動く

Jenkins

    Jenkinsで実行まで行う
    cronの実行結果だけ受け取るのもあるけど、重複実行を防げない
    分散実行したい場合はJenkinsのスレーブ管理機能を使う
    バッチサーバーでJenkinsを動かしたくないなら工夫が必要
        curlで叩いてタイムアウトとか間抜け
    SaaSがよければ https://www.cloudbees.com/

Hinemos

    http://www.hinemos.info/hinemos/
    NTTデータの作ってるやつ
    監視もできるジョブ管理ツールらしい
        そういう解釈ならZabbixもジョブ管理ツールになりうる

Chronos

    http://airbnb.github.io/chronos/
    AirBnbで作ってる
    Mesosの上で動く
    分散環境で有効そう

airflow

    airbnb/airflow · GitHub
    Airflow’s Documentation — Airflow 1.0.0 documentation
    データパイプライン処理ツールという定義だけどどこが使いどころかまだわかってない
    Python 2系で動く
    Pythonで設定書く
    リッチなWeb UIあり

HTCondor

    http://research.cs.wisc.edu/htcondor/
    大規模環境向け？ジョブマネージャー
        単なるジョブスケジューラーとしても使えるみたいだけど
    30年くらい歴史ある

商用系
JP1

    http://www.hitachi.co.jp/Prod/comp/soft1/jp1/
    商用
    業務システムでは定番らしいけどよく知らない

Tivoli

    http://www-01.ibm.com/software/tivoli/
    商用
    IBMファミリーの製品
    よく知らない

jamsscheduler

    http://www.jamsscheduler.com/
    よく知らない

A-Auto

    よく知らない

Systemwalker Operation Manager

    富士通

参考

http://ja.wikipedia.org/wiki/%E3%82%B8%E3%83%A7%E3%83%96%E7%AE%A1%E7%90%86%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0





■ROIについて
定量的効果
	削減できた人件費（年）＝1件の処理にかかる時間（単位：時間）×1年で処理できた件数×担当者の時給
定性的効果
	・業務の自動化による人的ミスの削減や業務品質の向上
	・業務の自動化と配置転換による人材不足の解消
	・セキュリティの向上
費用
	導入費用
		導入支援スタッフの人件費
		専用端末、サーバーなどのハードウェア費用
		ライセンス費用
	保守運用の費用
		人件費
		メンテナンスに必要な費用
投資対効果を大きくするにはどうすればよいのか
	導入により削減できた費用から、導入費用や保守運用の費用を差し引くことによる数値として得ることができます。投資対効果の算出に用いることができるのは、定量的効果だけです。
