Each 15 seconds will verify if any prompt from our list was used, case it was will get current user and moment when that happen and will notify us , this case I used mailutils for that task

Set up:
1. Prompts we want to watch: within monitor.sh 
2. How we notify case this happens (in this case I used a mailutils which used mailserver within the place)
3. Verify nobody can change our bash_history file
4. Do some testing(please)

Optional:
We could change timeframe for whenver we want it to trigger, could change sleep  method at the end of monitor.sh , or if you like it use cronjob(although minimal here is 1 minute).

Hope it helps!!
