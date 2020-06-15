

# Installation

https://jupyter.readthedocs.io/en/latest/install.html#alternative-for-experienced-python-users-installing-jupyter-with-pip

Microsoft Visual C++ Build Tools: https://visualstudio.microsoft.com/downloads/

easy_install --upgrade pip
pip3 install --upgrade pip

pip3 install jupyter

jupyter notebook

jupyter notebook notebook.ipynb
jupyter notebook --port 9999
jupyter notebook --no-browser




```Python38\Lib\site-packages\tornado\platform\asyncio.py
# After import asyncio

import typing
from typing import Any, TypeVar, Awaitable, Callable, Union, Optional

import sys

if sys.platform == 'win32':
    asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())
```


# Applications

export GITLAB_TOKEN=<token>
GITLAB_TOKEN=

gitlab_stats <id> -u <your gitlab url> -p <your proxy>



GET /projects/:id/statistics




import gitlab

# private token or personal token authentication
gl = gitlab.Gitlab('http://10.0.0.1', private_token='JVNSESs8EwWRx5yDxM5q')

# oauth token authentication
gl = gitlab.Gitlab('http://10.0.0.1', oauth_token='my_long_token_here')

# job token authentication (to be used in CI)
import os
gl = gitlab.Gitlab('http://10.0.0.1', job_token=os.environ['CI_JOB_TOKEN'])

# username/password authentication (for GitLab << 10.2)
gl = gitlab.Gitlab('http://10.0.0.1', email='jdoe', password='s3cr3t')

# anonymous gitlab instance, read-only for public resources
gl = gitlab.Gitlab('http://10.0.0.1')

# make an API request to create the gl.user object. This is mandatory if you
# use the username/password authentication.
gl.auth()



gl = gitlab.Gitlab.from_config('somewhere', ['/tmp/gl.cfg'])

https://python-gitlab.readthedocs.io/en/stable/api-usage.html
https://python-gitlab.readthedocs.io/en/stable/gl_objects/mrs.html
