FROM jupyter/minimal-notebook
# Install GCC
USER root
RUN apt update && sudo apt -y install build-essential
USER 1000
# Must install scipy dependencies before installing tomotopy
RUN pip install --no-cache-dir numpy pandas
RUN pip install --no-cache-dir \
    selenium \
    chromedriver-py \
    tomotopy \
    pyLDAvis
RUN fix-permissions "${CONDA_DIR}" && fix-permissions "/home/${NB_USER}"
ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root"]
