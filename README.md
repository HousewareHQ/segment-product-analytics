# Segment Product Analytics dbt Package

# 📣 What does this dbt package do?
This package transforms your raw Segment event data into [Houseware Event Schema](https://docs.houseware.io/docs/how-to-setup-houseware#step-3-transform-events-to-a-requisite-schema), to make events, users and their properties available on Houseware.

Typically these Segment events arrive at your warehouse in different tables such as:
- `TRACKS`
- `PAGES`
- Individuals tables for your events, e.g. `SIGNUP_SUCCESS`, `BUTTON_CLICKED` etc

The output of using this package is a single long events table called `allevents`, which will be materialized in the [target destination](https://docs.getdbt.com/docs/running-a-dbt-project/using-the-command-line-interface/configure-your-profile) on your warehouse.


# 🎯 How do I use the dbt package?
We need to know the schema in which your Segment events are flowing in the [target database](https://docs.getdbt.com/docs/running-a-dbt-project/using-the-command-line-interface/configure-your-profile). Please add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml

...
config-version: 2

vars:
  segment_product_analytics:
    segment_schema: "DEFAULT_SEGMENT_SCHEMA" # replace this with the schema in which Segment events are flowing
```


# 🗄 Which warehouses are supported?
This package has been tested on Snowflake.


# 🙌 Can I contribute?

Additional contributions to this package are very welcome! Please create issues
or open PRs against `main`. Check out 
[this post](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) 
on the best workflow for contributing to a package.


# 🏪 Are there any resources available?
- Have questions, feedback, or need help? Email us at nipun@houseware.io
- Check out [Houseware's blog](https://www.houseware.io/blog)
- Learn more about dbt [in the dbt docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the dbt blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
