# Pipedrive Interactions to Orbit Workspace

![Build Status](https://github.com/orbit-love/community-ruby-pipedrive-orbit/workflows/CI/badge.svg)
[![Gem Version](https://badge.fury.io/rb/pipedrive_orbit.svg)](https://badge.fury.io/rb/pipedrive_orbit)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.0-4baaaa.svg)](.github/CODE_OF_CONDUCT.md)

Add your Pipedrive CRM interactions into your Orbit workspace with this community-built integration.

|<p align="left">:sparkles:</p> This is a *community project*. The Orbit team does its best to maintain it and keep it up to date with any recent API changes.<br/><br/>We welcome community contributions to make sure that it stays current. <p align="right">:sparkles:</p>|
|-----------------------------------------|

![There are three ways to use this integration. Install package - build and run your own applications. Run the CLI - run on-demand directly from your terminal. Schedule an automation with GitHub - get started in minutes - no coding required](readme-images/ways-to-use.png)

## First Time Setup

To set up this integration you will need your Pipedrive API key and Pipedrive organization URL. See the below table for instructions on where to find those details.
## Application Credentials

The application requires the following environment variables:

| Variable | Description | More Info
|---|---|--|
| `PIPEDRIVE_API_KEY` | API key for Pipedrive | Found in `Personal Preferences -> API` in your Pipedrive user settings
| `PIPEDRIVE_URL` | Organizational Pipedrive URL | First part of the Pipedrive organization URL, i.e. `https://example-134554.pipedrive.com`
| `ORBIT_API_KEY` | API key for Orbit | Found in `Account Settings` in your Orbit workspace
| `ORBIT_WORKSPACE_ID` | ID for your Orbit workspace | Last part of the Orbit workspace URL, i.e. `https://app.orbit.love/my-workspace`, the ID is `my-workspace`

## Package Usage

Install the package with the following command

```
$ gem install pipedrive_orbit
```

Then, run `bundle install` from your terminal.

You can instantiate a client by either passing in the required credentials during instantiation or by providing them in your `.env` file.

### Instantiation with credentials:

```ruby
client = PipedriveOrbit::Client.new(
    orbit_api_key: YOUR_API_KEY,
    orbit_workspace_id: YOUR_ORBIT_WORKSPACE_ID,
    pipedrive_api_key: YOUR_PIPEDRIVE_API_KEY,
    pipedrive_url: YOUR_PIPEDRIVE_URL
)
```

### Instantiation with credentials in dotenv file:

```ruby
client = PipedriveOrbit::Client.new
```
### Fetching Pipedrive Notes

Once, you have an instantiated client, you can fetch Pipedrive deal notes and send them to Orbit by invoking the `#notes` instance method:

```ruby
client.notes
```
### Fetching Pipedrive Notes

Once, you have an instantiated client, you can fetch Pipedrive activities and send them to Orbit by invoking the `#activities` instance method:

```ruby
client.activities
```
## CLI Usage

You can also use this package with the included CLI. To use the CLI pass in the required environment variables on the command line before invoking the CLI.

To check for new deal notes:

```bash
$ ORBIT_API_KEY=... ORBIT_WORKSPACE_ID=... PIPEDRIVE_API_KEY=... PIPEDRIVE_URL=... bundle exec pipedrive_orbit --check_notes
```

To check for new activities:

```bash
$ ORBIT_API_KEY=... ORBIT_WORKSPACE_ID=... PIPEDRIVE_API_KEY=... PIPEDRIVE_URL=... bundle exec pipedrive_orbit --check_activities
```

## GitHub Actions Automation Setup

⚡ You can set up this integration in a matter of minutes using our GitHub Actions template. It will run regularly to add new activities to your Orbit workspace. All you need is a GitHub account.

[See our guide for setting up this automation](https://github.com/orbit-love/github-actions-templates/blob/main/Pipedrive/README.md)

## Contributing

We 💜 contributions from everyone! Check out the [Contributing Guidelines](.github/CONTRIBUTING.md) for more information.

## License

This project is under the [MIT License](./LICENSE).

## Code of Conduct

This project uses the [Contributor Code of Conduct](.github/CODE_OF_CONDUCT.md). We ask everyone to please adhere by its guidelines.
