angular.module('loomioApp').directive 'pendingEmailForm', ($translate, KeyEventService) ->
  scope: {emails: '='}
  restrict: 'E'
  templateUrl: 'generated/components/pending_email_form/pending_email_form.html'
  replace: true
  controller: ($scope) ->
    $scope.newEmail = ''

    $scope.addIfValid = ->
      $scope.emailValidationError = null
      $scope.checkEmailNotEmpty()
      $scope.checkEmailValid()
      $scope.checkEmailAvailable()
      $scope.add() unless $scope.emailValidationError

    $scope.add = ->
      return unless $scope.newEmail.length > 0
      $scope.emails.push($scope.newEmail)
      $scope.newEmail = ''
      $scope.emailValidationError = null

    $scope.submit = ->
      $scope.emailValidationError = null
      $scope.checkEmailValid()
      $scope.checkEmailAvailable()
      if !$scope.emailValidationError
        $scope.add()
        $scope.$emit 'emailsSubmitted'

    $scope.checkEmailNotEmpty = ->
      if $scope.newEmail.length <= 0
        $scope.emailValidationError = $translate.instant('pending_email_form.email_empty')

    $scope.checkEmailValid = ->
      if $scope.newEmail.length > 0 && !$scope.newEmail.match(/[^\s,;<>]+?@[^\s,;<>]+\.[^\s,;<>]+/g)
        $scope.emailValidationError = $translate.instant('pending_email_form.email_invalid')

    $scope.checkEmailAvailable = ->
      if _.contains($scope.emails, $scope.newEmail)
        $scope.emailValidationError = $translate.instant('pending_email_form.email_exists', email: $scope.newEmail)

    $scope.remove = (email) ->
      _.pull($scope.emails, email)

    KeyEventService.registerKeyEvent $scope, 'pressedEnter', $scope.add, (active) ->
      active.classList.contains('poll-common-share-form__add-option-input')
