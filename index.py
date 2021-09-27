import streamlit as st
import pandas as pd
import numpy as np
import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="t9oimfo04G",
  database="py_medicine_tracker",
  auth_plugin='mysql_native_password'
)

st.set_page_config(
     page_title="Ex-stream-ly Cool DBMS App",
     page_icon="favicon.png",
     layout="wide",
     initial_sidebar_state="expanded",
     
 )

if 'page' not in st.session_state:
    st.session_state.page = 'Home'

if 'is_admin' not in st.session_state:
    st.session_state.is_admin = False

def page(str):
    st.session_state.page = str

def logout():
    st.session_state.is_admin = False

st.title("Py Medicine Tracker")
st.sidebar.title("Pages")
st.sidebar.markdown("---")

if not st.session_state.is_admin:
    page("login"):
else:
    st.sidebar.button("Logout",on_click=logout)
    st.sidebar.markdown("---")


if st.session_state.is_admin:    
    st.sidebar.button("Register",on_click=page,args=["reg"])


if st.session_state.page=="reg" and st.session_state.is_admin==True:
    st.write("Add Username And Password to Register")
    u_name=st.text_input("Username")
    pswd=st.text_input("Password",type="password")
    
    if st.button("Register",key="reg"):
        # mydb.cur.execute("INSERT INTO users (username, password) VALUES (%s, %s)", (u_name, pswd))
        # mydb.commit()
        st.success("Registered Successfully")
        st.write("You can now login")
        
if st.session_state.page=="login":
    st.write("Add Username And Password to Login")
    u_name=st.text_input("Username")
    pswd=st.text_input("Password",type="password")
    if st.button("Login",key="login"):
        if u_name=="admin" and pswd=="admin":
            st.success("Logged In Successfully")
            st.session_state.is_admin = True
        else:
            st.error("Incorrect Username Or Password")
        # mydb.cur.execute("SELECT * FROM users WHERE username=%s AND password=%s", (u_name, pswd))
        # mydb.commit()
    
    









