local otterdog = import 'otterdog-functions.libsonnet';

# Function to create a new repository with default settings.
local newRepo(name) = {
  name: name,
  description: null,
  homepage: null,
  private: false,

  has_discussions: false,
  has_issues: true,
  has_projects: true,
  has_wiki: true,

  topics: [],

  is_template: false,
  template_repository: null,
  auto_init: true,

  default_branch: "main",

  allow_rebase_merge: true,
  allow_merge_commit: false,
  allow_squash_merge: true,

  allow_auto_merge: false,
  delete_branch_on_merge: true,

  allow_update_branch: true,

  # Can be one of: PR_TITLE, COMMIT_OR_PR_TITLE
  squash_merge_commit_title: "COMMIT_OR_PR_TITLE",
  # Can be one of: PR_BODY, COMMIT_MESSAGES, BLANK
  squash_merge_commit_message: "COMMIT_MESSAGES",
  # Can be one of: PR_TITLE, MERGE_MESSAGE
  merge_commit_title: "MERGE_MESSAGE",
  # Can be one of: PR_BODY, PR_TITLE, BLANK
  merge_commit_message: "PR_TITLE",

  archived: false,

  # about private forks
  allow_forking: true,

  web_commit_signoff_required: true,

  # security analysis
  secret_scanning: "enabled",
  secret_scanning_push_protection: "enabled",

  dependabot_alerts_enabled: true,
  dependabot_security_updates_enabled: false,

  # GitHub pages
  gh_pages_build_type: "disabled",
  gh_pages_source_branch: null,
  gh_pages_source_path: null,

  workflows: {
    enabled: true,

    # allow all actions by default
    allowed_actions: "all",
    allow_github_owned_actions: true,
    allow_verified_creator_actions: true,
    allow_action_patterns: [],

    # issue read tokens by default
    default_workflow_permissions: "read",

    # allow actions to approve and merge pull requests
    actions_can_approve_pull_request_reviews: true,
  },

  # repository webhooks
  webhooks: [],

  # repository environments
  environments: [],

  # branch protection rules
  branch_protection_rules: []
};

# Function to extend an existing repo with the same name.
local extendRepo(name) = {
   name: name
};

# Function to create a new branch protection rule with default settings.
local newBranchProtectionRule(pattern) = {
  pattern: pattern,
  allows_deletions: false,
  allows_force_pushes: false,
  bypass_force_push_allowances: [],
  bypass_pull_request_allowances: [],
  dismisses_stale_reviews: false,
  is_admin_enforced: false,
  lock_allows_fetch_and_merge: false,
  lock_branch: false,
  restricts_pushes: false,
  blocks_creations: false,
  push_restrictions: [],
  required_status_checks: [
    # by default, the eclipse contributor agreement check must pass.
    "eclipse-eca-validation:eclipsefdn/eca",
  ],
  requires_pull_request: true,
  required_approving_review_count: 2,
  requires_code_owner_reviews: false,
  requires_commit_signatures: false,
  requires_conversation_resolution: false,
  requires_linear_history: false,
  requires_status_checks: true,
  requires_strict_status_checks: false,
  restricts_review_dismissals: false,
  review_dismissal_allowances: [],
  require_last_push_approval: false,
  requires_deployments: false,
  required_deployment_environments: []
};

# Function to create a new organization webhook with default settings.
local newOrgWebhook(url) = {
  active: true,
  events: [],
  url: url,
  # Can be one of: form, json
  content_type: "form",
  insecure_ssl: "0",
  secret: null,
};

# Function to create a new repository webhook with default settings.
local newRepoWebhook(url) = newOrgWebhook(url);

# Function to create a new organization secret with default settings.
local newOrgSecret(name) = {
  name: name,
  visibility: "public",
  selected_repositories: [],
  value: null
};

# Function to create a new repository secret with default settings.
local newRepoSecret(name) = {
  name: name,
  value: null
};

# Function to create a new environment with default settings.
local newEnvironment(name) = {
  name: name,
  wait_timer: 0,
  reviewers: [],
  # Can be one of: all, protected_branches, branch_policies
  deployment_branch_policy: "all",
  branch_policies: [],
};

# Function to create a new organization with default settings.
local newOrg(id) = {
  github_id: id,
  settings: {
    name: null,
    plan: "free",
    billing_email: "webmaster@eclipse-foundation.org",
    company: null,
    email: null,
    twitter_username: null,
    location: null,
    description: null,
    blog: null,

    has_discussions: false,
    discussion_source_repository: null,

    has_organization_projects: true,
    has_repository_projects: true,

    # Base permissions to the organization’s repositories apply to all members and excludes outside collaborators.
    # Since organization members can have permissions from multiple sources, members and collaborators who have been
    # granted a higher level of access than the base permissions will retain their higher permission privileges.
    # Can be one of: read, write, admin, none
    default_repository_permission: "read",

    # Repository creation
    members_can_create_private_repositories: false,
    members_can_create_public_repositories: false,

    # Repository forking
    members_can_fork_private_repositories: false,

    # Repository defaults: Commit signoff
    web_commit_signoff_required: true,

    # GitHub Pages
    members_can_create_public_pages: true,

    dependabot_alerts_enabled_for_new_repositories: true,
    dependabot_security_updates_enabled_for_new_repositories: true,
    dependency_graph_enabled_for_new_repositories: true,

    ## Admin repository permissions

    # If enabled, members with admin permissions for the repository will be able to change its visibility.
    # If disabled, only organization owners can change repository visibilities.
    members_can_change_repo_visibility: false,

    # If enabled, members with admin permissions for the repository will be able to delete or transfer public
    # and private repositories. If disabled, only organization owners can delete or transfer repositories.
    members_can_delete_repositories: false,

    # If enabled, members with admin permissions for the repository will be able to delete issues.
    # If disabled, only organization owners can delete issues.
    members_can_delete_issues: false,

    # If enabled, all users with read access can create and comment on discussions in repositories of the organization.
    # If disabled, discussion creation is limited to users with at least triage permission.
    # Users with read access can still comment on discussions.
    readers_can_create_discussions: false,

    ## Member team permissions

    # If enabled, any member of the organization will be able to create new teams.
    # If disabled, only organization owners can create new teams.
    members_can_create_teams: false,

    two_factor_requirement: true,

    default_branch_name: "main",

    packages_containers_public: true,
    packages_containers_internal: true,

    members_can_change_project_visibility: true,

    security_managers: ["eclipsefdn-security"],

    workflows: {
      # enable workflows for all repositories
      enabled_repositories: "all",
      selected_repositories: [],

      # allow all actions by default
      allowed_actions: "all",
      allow_github_owned_actions: true,
      allow_verified_creator_actions: true,
      allow_action_patterns: [],

      # issue read tokens by default
      default_workflow_permissions: "read",

      # allow actions to approve and merge pull requests
      actions_can_approve_pull_request_reviews: true,
    }
  },

  secrets: [],
  webhooks: [],

  # List of repositories of the organization.
  # Entries here can be extended during template manifestation:
  #  * new repos should be defined using the newRepo template
  #  * extending existing repos inherited from the default config should be defined using the extendRepo template
  _repositories:: [
    newRepo('.eclipsefdn') {
      description: "Repository to host configurations related to the Eclipse Foundation.",
      homepage: std.format("https://%s.github.io/.eclipsefdn/", $['github_id']),
      template_repository: "EclipseFdn/.eclipsefdn-template",
      post_process_template_content: [
        ".github/CODEOWNERS",
        "README.md",
        "mkdocs.yml"
      ],
      allow_forking: true,
      allow_merge_commit: false,
      delete_branch_on_merge: true,
      gh_pages_build_type: "workflow",
      has_projects: false,
      has_wiki: false,
      branch_protection_rules: [
        newBranchProtectionRule('main') {
          bypass_pull_request_allowances: [
            std.format("@%s/eclipsefdn-releng", $['github_id']),
            std.format("@%s/eclipsefdn-security", $['github_id'])
          ],
          requires_pull_request: true,
          required_approving_review_count: 1,
          requires_code_owner_reviews: true,
          requires_status_checks: false,
          required_status_checks: [],
        },
      ],
      environments: [
        newEnvironment('github-pages') {
          branch_policies: [
            "main"
          ],
          deployment_branch_policy: "selected",
        }
      ],
    }
  ],

  # Merges configuration settings for repositories defined in _repositories
  # using the name of the repo as key. The result is unique array of repository
  # configurations.
  repositories: otterdog.mergeByKey(self._repositories, "name"),
};

{
  newOrg:: newOrg,
  newOrgWebhook:: newOrgWebhook,
  newOrgSecret:: newOrgSecret,
  newRepo:: newRepo,
  extendRepo:: extendRepo,
  newRepoWebhook:: newRepoWebhook,
  newRepoSecret:: newRepoSecret,
  newBranchProtectionRule:: newBranchProtectionRule,
  newEnvironment:: newEnvironment
}
