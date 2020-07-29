FROM python:3.8.5-slim

STOPSIGNAL SIGQUIT

WORKDIR /srv

COPY requirements.txt .

RUN python -m pip install --upgrade pip && \
  pip install -r requirements.txt && \
  rm -vf requirements.txt

USER www-data

EXPOSE 5001

COPY --chown=www-data:www-data src/ .

ENTRYPOINT ["gunicorn"]
CMD ["--bind", "0.0.0.0:5001", "--workers=2", "wsgi:app"]
