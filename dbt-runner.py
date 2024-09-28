from typing import List
from dbt.cli.main import dbtRunner, dbtRunnerResult

class CustomRunner(dbtRunner):
    def invoke(self, args: List[str], **kwargs) -> dbtRunnerResult: 
        print("Here you can perform setup or authentication or modify args")
        super().invoke(args, **kwargs)

### patch the dbtRunner
dbtRunner = CustomRunner