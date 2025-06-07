FROM python:3.11-slim

RUN adduser --disabled-password --gecos '' zetta
USER zetta

WORKDIR /app

COPY --chown=zetta:zetta requirements.txt ./

RUN pip install --no-cache-dir --user -r requirements.txt

COPY --chown=zetta:zetta . .

EXPOSE 5000

CMD ["python", "app.py"]