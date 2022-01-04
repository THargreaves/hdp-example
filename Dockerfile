FROM jupyter/minimal-notebook
USER root
# Install GCC and Firefox
RUN apt-get update && apt-get install -y \
    build-essential firefox
# Install Gecko (Webdriver for Firefox)
RUN wget -q https://github.com/mozilla/geckodriver/releases/download/v0.30.0/geckodriver-v0.30.0-linux64.tar.gz
RUN tar -xvzf geckodriver-*
RUN chmod +x geckodriver
RUN mv geckodriver /usr/local/bin/
RUN rm geckodriver*
USER 1000
# Must install scipy dependencies before installing tomotopy
# See requirements.txt for exact versions
RUN pip install --no-cache-dir numpy pandas matplotlib
RUN pip install --no-cache-dir \
    selenium \
    tomotopy \
    pyLDAvis \
    ipywidgets \
    nltk \
    tqdm
RUN fix-permissions "${CONDA_DIR}" && fix-permissions "/home/${NB_USER}"
ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root"]
