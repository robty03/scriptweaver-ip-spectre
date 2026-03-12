install:
	pip install -r requirements.txt

run:
	python cli.py

clean:
	python -c "import shutil, os; shutil.rmtree('__pycache__', ignore_errors=True); shutil.rmtree('.pytest_cache', ignore_errors=True)"
	
create-db:
	aws dynamodb create-table \
	--table-name ip_spectre_logs \
	--attribute-definitions AttributeName=scan_id,AttributeType=S \
	--key-schema AttributeName=scan_id,KeyType=HASH \
	--billing-mode PAY_PER_REQUEST

purge-db:
	python -c "from aws_handler import delete_all_scans; print(delete_all_scans())"