# Itamae concrete5 recipe

## Usage

```
vagrant plugin install vagrant-hostmanager
```

```
bundle install --path vendor/bundle
```

```
vagrant up
bundle exec itamae ssh --vagrant --host concrete5 --node-json=node.json bootstrap.rb
```
