export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:/usr/local/opt/go/libexec/bin"
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
export GOPATH=$HOME/go
. ~/.bashrc

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:$HOME/bin"

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

export NODE_ENV="development"
export RUN_ENV="local"

export FQ_EMAIL="andrew.merenbach@floqast.com"
export RUN_RECS_NOTIFICATION_EMAIL="andrew.merenbach@floqast.com"
export CRON_UPDATE_TLC_EMAIL_NOTIFICATION="andrew.merenbach@floqast.com"
export SERVER_EMAIL_SETUP="andrew.merenbach@floqast.com"
export SERVER_EMAIL_NOTIFICATION_RUNRECS="andrew.merenbach@floqast.com"
export SERVER_EMAIL_NOTIFICATION_CRON_UPDATETLC="andrew.merenbach@floqast.com"

export API_AWS_SQS_BI_QUEUE_NAME="bi-development-andrewmer.fifo"
export API_AWS_SQS_PROGRESSEMAIL_QUEUE_NAME="progress-email-andrewmer.fifo"
export API_AWS_SQS_READYFORREVIEWEMAIL_QUEUE_NAME="ready-for-review-andrewmer.fifo"
export API_AWS_SQS_RUNRECS_INTACCT_QUEUE_NAME="run-recs-sqs-intacct-andrewmer.fifo"
export API_AWS_SQS_RUNRECS_NETSUITE_QUEUE_NAME="run-recs-ytd-netsuite-andrewmer.fifo"
export API_AWS_SQS_RUNRECS_REPORT_QUEUE_NAME="run-recs-report-andrewmer.fifo"
export API_AWS_SQS_RUNRECS_TB_QUEUE_NAME="run-recs-sqs-tb-andrewmer.fifo"
export API_AWS_SQS_RUNRECS_YTD_INTACCT_QUEUE_NAME="run-recs-ytd-intacct-andrewmer.fifo"
export API_AWS_SQS_RUNRECS_YTD_NETSUITE_QUEUE_NAME="run-recs-ytd-netsuite-andrewmer.fifo"
export API_AWS_SQS_RUNRECS_YTD_TB_QUEUE_NAME="run-recs-ytd-tb-andrewmer.fifo"
export BI_SQS_QUEUE_NAME="bi-development-andrewmer.fifo"

