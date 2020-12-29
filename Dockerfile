FROM python:3.7.7-stretch

# Create a Working Directory
WORKDIR /app

# Copy requirements file and source code to working directory
COPY requirements.txt app.py /app/

# Install packages from requirements.txt
RUN pip install --upgrade pip &&\
	pip install --trusted-host --no-cache-dir pypi.python.org -r requirements.txt

# Expose port 5000
EXPOSE 5000

# Run app.py at container launch
CMD ["python", "app.py"]