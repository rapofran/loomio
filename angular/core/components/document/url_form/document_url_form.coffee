angular.module('loomioApp').directive 'documentUrlForm', ($translate, AppConfig, Records, DocumentService, KeyEventService) ->
  scope: {document: '='}
  templateUrl: 'generated/components/document/url_form/document_url_form.html'
  controller: ($scope) ->
    $scope.model = Records.discussions.build()

    $scope.submit = ->
      $scope.model.setErrors({})
      if $scope.model.url.toString().match(AppConfig.regex.url.source)
        $scope.document.url = $scope.model.url
        $scope.$emit('nextStep', $scope.document)
      else
        $scope.model.setErrors(url: [$translate.instant('document.error.invalid_format')])

    $scope.$on 'documentAdded', (event, doc) ->
      event.stopPropagation()
      $scope.$emit 'nextStep', doc

    KeyEventService.submitOnEnter $scope, anyEnter: true
    DocumentService.listenForPaste $scope
