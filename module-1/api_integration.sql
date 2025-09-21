USE ROLE accountadmin;
drop DATABASE course_repo;
create DATABASE course_repo;
USE SCHEMA public;

-- Create credentials
CREATE OR REPLACE SECRET course_repo.public.github_pat
  TYPE = password
  USERNAME = 'iankitkr'
  PASSWORD = ''
;
-- Create the API integration
CREATE OR REPLACE API INTEGRATION git_integration
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/iankitkr')
  ALLOWED_AUTHENTICATION_SECRETS = (course_repo.public.github_pat) -- allow your secret
  ENABLED = TRUE;

-- Create the git repository object
CREATE OR REPLACE GIT REPOSITORY course_repo.public.advanced_data_engineering_snowflake
  API_INTEGRATION =  git_integration-- Name of the API integration defined above
  ORIGIN = 'https://github.com/iankitkr/advanced-data-engineering-snowflake.git' -- Insert URL of forked repo
  GIT_CREDENTIALS = course_repo.public.github_pat;

-- List the git repositories
SHOW GIT REPOSITORIES;